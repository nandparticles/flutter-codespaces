// Copyright (c) 2022 Contributors to the Suwayomi project
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../constants/db_keys.dart';
import '../../../../../constants/enum.dart';
import '../../../../../utils/extensions/custom_extensions.dart';
import '../../../../../utils/mixin/shared_preferences_client_mixin.dart';
import '../../../data/source_repository/source_repository.dart';
import '../../../domain/filter/filter_model.dart';
import '../../../domain/source/source_model.dart';

part 'source_manga_controller.g.dart';

@riverpod
FutureOr<Source?> source(SourceRef ref, String sourceId) async {
  final token = CancelToken();
  ref.onDispose(token.cancel);
  final result = await ref
      .watch(sourceRepositoryProvider)
      .getSource(sourceId: sourceId, cancelToken: token);
  ref.keepAlive();
  return result;
}

@riverpod
Future<List<Filter>?> baseSourceMangaFilterList(
  BaseSourceMangaFilterListRef ref,
  String sourceId,
) async {
  final token = CancelToken();
  ref.onDispose(token.cancel);
  final result = await ref
      .watch(sourceRepositoryProvider)
      .getFilterList(sourceId: sourceId);
  ref.keepAlive();
  return result;
}

@riverpod
class SourceMangaFilterList extends _$SourceMangaFilterList {
  @override
  AsyncValue<List<Filter>?> build(String sourceId, {List<Filter>? filter}) {
    final networkFilter =
        ref.watch(baseSourceMangaFilterListProvider(sourceId));
    return filter != null ? AsyncData(filter) : networkFilter;
  }

  void updateFilter(List<Filter>? filter) =>
      state = state.copyWithData((p0) => filter);

  Future<void> reset() async =>
      ref.invalidate(baseSourceMangaFilterListProvider(sourceId));

  List<Map<String, dynamic>> get getAppliedFilter {
    final baseFilters = Filter.filtersToJson(
      ref.read(baseSourceMangaFilterListProvider(sourceId)).valueOrNull ?? [],
    );
    final currentFilters = Filter.filtersToJson(state.valueOrNull ?? []);
    if (baseFilters.length != currentFilters.length) return currentFilters;
    const equality = DeepCollectionEquality();
    return [
      for (int i = 0; i < baseFilters.length; i++)
        if (!equality.equals(currentFilters[i], baseFilters[i]))
          currentFilters[i],
    ];
  }
}

@riverpod
class SourceDisplayMode extends _$SourceDisplayMode
    with SharedPreferenceEnumClientMixin<DisplayMode> {
  @override
  DisplayMode? build() => initialize(
        DBKeys.sourceDisplayMode,
        enumList: DisplayMode.sourceDisplayList,
      );
}
