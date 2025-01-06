// Copyright (c) 2022 Contributors to the Suwayomi project
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../constants/app_sizes.dart';
import '../../../../../constants/enum.dart';

import '../../../../../routes/router_config.dart';
import '../../../../../utils/extensions/custom_extensions.dart';
import '../../../../../widgets/server_image.dart';
import '../../../../browse_center/domain/source/source_model.dart';
import '../../../../browse_center/presentation/source/controller/source_controller.dart';

class SourceQueryListTile extends ConsumerWidget {
  const SourceQueryListTile({
    super.key,
    required this.source,
    this.query,
    this.afterClick,
  });

  final Source source;
  final String? query;
  final VoidCallback? afterClick;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      onTap: (() async {
        if (source.id == null) return;
        ref.read(sourceLastUsedProvider.notifier).update(source.id);
        SourceMangaRoute(
          sourceId: source.id!,
          sourceType: query.isBlank ? SourceType.popular : SourceType.filter,
          query: query,
        ).push(context);
        afterClick?.call();
      }),
      leading: ClipRRect(
        borderRadius: KBorderRadius.r8.radius,
        child: ServerImage(
          imageUrl: source.iconUrl ?? "",
          size: const Size.square(48),
        ),
      ),
      title: query.isNotBlank
          ? RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "${source.displayName ?? source.name ?? ""}/ ",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          letterSpacing: .1,
                          wordSpacing: .1,
                          color: context.theme.hintColor,
                        ),
                  ),
                  TextSpan(
                    text: query ?? "",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            )
          : Text(source.displayName ?? source.name ?? ""),
      subtitle: (source.lang?.displayName).isNotBlank
          ? Text(
              source.lang?.displayName ?? "",
              style: TextStyle(color: context.theme.hintColor),
            )
          : null,
    );
  }
}
