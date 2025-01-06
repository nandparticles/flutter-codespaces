// Copyright (c) 2022 Contributors to the Suwayomi project
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/manga_book_repository.dart';
import '../../../domain/chapter/chapter_model.dart';

part 'reader_controller.g.dart';

@riverpod
FutureOr<Chapter?> chapter(
  ChapterRef ref, {
  required int mangaId,
  required int chapterIndex,
}) async {
  final token = CancelToken();
  ref.onDispose(token.cancel);
  final result = await ref.watch(mangaBookRepositoryProvider).getChapter(
        mangaId: mangaId,
        chapterIndex: chapterIndex,
      );
  ref.keepAlive();
  return result;
}
