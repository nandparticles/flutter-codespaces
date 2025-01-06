// Copyright (c) 2022 Contributors to the Suwayomi project
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../routes/router_config.dart';
import '../../../../../utils/extensions/custom_extensions.dart';
import '../../../domain/chapter/chapter_model.dart';
import '../../../domain/manga/manga_model.dart';
import '../../../widgets/download_status_icon.dart';

class ChapterListTile extends StatelessWidget {
  const ChapterListTile({
    super.key,
    required this.manga,
    required this.chapter,
    required this.updateData,
    required this.toggleSelect,
    this.canTapSelect = false,
    this.isSelected = false,
  });
  final Manga manga;
  final Chapter chapter;
  final AsyncCallback updateData;
  final ValueChanged<Chapter> toggleSelect;
  final bool canTapSelect;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: Key("manga-${manga.id}-chapter-${chapter.id}"),
      onSecondaryTap: () => toggleSelect(chapter),
      child: ListTile(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (chapter.bookmarked.ifNull()) ...[
              Icon(
                Icons.bookmark,
                color: chapter.read.ifNull() ? Colors.grey : context.iconColor,
                size: 20,
              ),
              const Gap(4),
            ],
            Expanded(
              child: Text(
                chapter.getDisplayName(context),
                style: TextStyle(
                  color: chapter.read.ifNull() ? Colors.grey : null,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        subtitle: chapter.uploadDate != null
            ? Row(
                children: [
                  Text(
                    chapter.uploadDate!.toDaysAgo(context),
                    style: TextStyle(
                      color: chapter.read.ifNull() ? Colors.grey : null,
                    ),
                  ),
                  if (!chapter.read.ifNull() &&
                      (chapter.lastPageRead).getValueOnNullOrNegative() != 0)
                    Text(
                      " • ${context.l10n!.page(chapter.lastPageRead.getValueOnNullOrNegative() + 1)}",
                      style: const TextStyle(color: Colors.grey),
                      overflow: TextOverflow.ellipsis,
                    ),
                  if (chapter.scanlator.isNotBlank)
                    Expanded(
                      child: Text(
                        " • ${chapter.scanlator}",
                        style: TextStyle(
                          color: chapter.read.ifNull() ? Colors.grey : null,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
              )
            : null,
        trailing: (chapter.index != null && manga.id != null)
            ? DownloadStatusIcon(
                updateData: updateData,
                chapter: chapter,
                mangaId: manga.id!,
                isDownloaded: chapter.downloaded.ifNull(),
              )
            : null,
        selectedColor: context.theme.colorScheme.onSurface,
        selectedTileColor:
            context.isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
        selected: isSelected,
        onTap: canTapSelect
            ? () => toggleSelect(chapter)
            : () => ReaderRoute(
                  mangaId: manga.id!,
                  chapterIndex: chapter.index!,
                  showReaderLayoutAnimation: true,
                ).push(context),
        onLongPress: () => toggleSelect(chapter),
      ),
    );
  }
}
