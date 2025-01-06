// Copyright (c) 2022 Contributors to the Suwayomi project
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../constants/app_sizes.dart';
import '../../../../routes/router_config.dart';
import '../../../../utils/extensions/custom_extensions.dart';
import '../../../../utils/misc/toast/toast.dart';
import '../../../../widgets/emoticons.dart';
import '../../../library/presentation/library/controller/library_controller.dart';
import '../../domain/chapter/chapter_model.dart';
import '../../widgets/chapter_actions/multi_chapters_actions_bottom_app_bar.dart';
import 'controller/manga_details_controller.dart';
import 'widgets/big_screen_manga_details.dart';
import 'widgets/edit_manga_category_dialog.dart';
import 'widgets/manga_chapter_organizer.dart';
import 'widgets/small_screen_manga_details.dart';

class MangaDetailsScreen extends HookConsumerWidget {
  const MangaDetailsScreen({super.key, required this.mangaId, this.categoryId});
  final int mangaId;
  final int? categoryId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers as Class for this screen
    final mangaProvider = mangaWithIdProvider(mangaId: mangaId);
    final chapterListProvider = mangaChapterListProvider(mangaId: mangaId);
    final chapterListFilteredProvider =
        mangaChapterListWithFilterProvider(mangaId: mangaId);

    final manga = ref.watch(mangaProvider);
    final filteredChapterList = ref.watch(chapterListFilteredProvider);
    final firstUnreadChapter = ref.watch(
      firstUnreadInFilteredChapterListProvider(mangaId: mangaId),
    );

    final selectedChapters = useState<Map<int, Chapter>>({});

    // Refresh manga
    final mangaRefresh = useCallback(
        ([bool onlineFetch = false]) async =>
            await ref.read(mangaProvider.notifier).refresh(onlineFetch),
        [mangaProvider]);

    // Refresh chapter list
    final chapterListRefresh = useCallback(
        ([bool onlineFetch = false]) async =>
            await ref.read(chapterListProvider.notifier).refresh(onlineFetch),
        [chapterListProvider]);

    final refresh = useCallback(([onlineFetch = false]) async {
      if (context.mounted && onlineFetch) {
        ref.read(toastProvider(context)).show(
              context.l10n!.updating,
              withMicrotask: true,
            );
      }
      await mangaRefresh(onlineFetch);
      await chapterListRefresh(onlineFetch);
      if (context.mounted && onlineFetch) {
        if (manga.hasError) {
          ref.read(toastProvider(context)).showError(
                context.l10n!.errorSomethingWentWrong,
              );
        } else {
          ref.read(toastProvider(context)).show(
                context.l10n!.updateCompleted,
                withMicrotask: true,
              );
        }
      }
    }, [context, mangaRefresh, chapterListRefresh]);

    useEffect(() {
      if (filteredChapterList.isNotLoading && manga.isNotLoading) refresh();
      return;
    }, []);

    return PopScope(
      onPopInvoked: (didPop) async {
        if (didPop && categoryId != null) {
          ref.invalidate(categoryMangaListProvider(categoryId!));
        }
      },
      child: manga.showUiWhenData(
        context,
        (data) => Scaffold(
          appBar: selectedChapters.value.isNotEmpty
              ? AppBar(
                  leading: IconButton(
                    onPressed: () => selectedChapters.value = ({}),
                    icon: const Icon(Icons.close_rounded),
                  ),
                  title: Text(
                    context.l10n!.numSelected(selectedChapters.value.length),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        final chapterList = [
                          ...?filteredChapterList.valueOrNull
                        ];
                        selectedChapters.value = ({
                          for (Chapter i in chapterList)
                            if (i.id != null) i.id!: i
                        });
                      },
                      icon: const Icon(Icons.select_all_rounded),
                    ),
                    IconButton(
                      onPressed: () {
                        final chapterList = [
                          ...?filteredChapterList.valueOrNull
                        ];
                        selectedChapters.value = ({
                          for (Chapter i in chapterList)
                            if (i.id != null &&
                                !selectedChapters.value.containsKey(i.id))
                              i.id!: i
                        });
                      },
                      icon: const Icon(Icons.flip_to_back_rounded),
                    ),
                    MultiSelectPopupButton(
                      filteredChapterList: filteredChapterList,
                      selectedChapters: selectedChapters,
                    ),
                  ],
                )
              : AppBar(
                  title: Text(data?.title ?? context.l10n!.manga),
                  actions: [
                    if (context.isTablet) ...[
                      IconButton(
                        onPressed: () => refresh(true),
                        icon: const Icon(Icons.refresh_rounded),
                      ),
                      IconButton(
                        onPressed: () => showDialog(
                          context: context,
                          builder: (context) =>
                              EditMangaCategoryDialog(mangaId: mangaId),
                        ),
                        icon: const Icon(Icons.category_rounded),
                      )
                    ],
                    Builder(
                      builder: (context) => IconButton(
                        onPressed: () {
                          if (context.isTablet) {
                            Scaffold.of(context).openEndDrawer();
                          } else {
                            showModalBottomSheet(
                              context: context,
                              shape: RoundedRectangleBorder(
                                borderRadius: KBorderRadius.rT16.radius,
                              ),
                              clipBehavior: Clip.hardEdge,
                              builder: (_) =>
                                  MangaChapterOrganizer(mangaId: mangaId),
                            );
                          }
                        },
                        icon: const Icon(Icons.filter_list_rounded),
                      ),
                    ),
                    if (!context.isTablet)
                      PopupMenuButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: KBorderRadius.r16.radius,
                        ),
                        icon: const Icon(Icons.more_vert_rounded),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            onTap: () => Future.microtask(
                              () => showDialog(
                                context: context,
                                builder: (context) =>
                                    EditMangaCategoryDialog(mangaId: mangaId),
                              ),
                            ),
                            child: Text(context.l10n!.editCategory),
                          ),
                          PopupMenuItem(
                            onTap: () => refresh(true),
                            child: Text(context.l10n!.refresh),
                          ),
                        ],
                      )
                  ],
                ),
          endDrawer: Drawer(
            shape: const RoundedRectangleBorder(),
            width: kDrawerWidth,
            child: MangaChapterOrganizer(mangaId: mangaId),
          ),
          bottomSheet: selectedChapters.value.isNotEmpty
              ? MultiChaptersActionsBottomAppBar(
                  afterOptionSelected: chapterListRefresh,
                  selectedChapters: selectedChapters,
                )
              : null,
          floatingActionButton:
              firstUnreadChapter != null && selectedChapters.value.isEmpty
                  ? FloatingActionButton.extended(
                      isExtended: context.isTablet,
                      label: Text(
                        data?.lastChapterRead?.index != null
                            ? context.l10n!.resume
                            : context.l10n!.start,
                      ),
                      icon: const Icon(Icons.play_arrow_rounded),
                      onPressed: () {
                        ReaderRoute(
                          mangaId: firstUnreadChapter.mangaId ?? mangaId,
                          chapterIndex: firstUnreadChapter.index ?? 0,
                          showReaderLayoutAnimation: true,
                        ).push(context);
                      },
                    )
                  : null,
          body: data != null
              ? context.isTablet
                  ? BigScreenMangaDetails(
                      chapterList: filteredChapterList,
                      manga: data,
                      mangaId: mangaId,
                      onRefresh: refresh,
                      onDescriptionRefresh: mangaRefresh,
                      onListRefresh: chapterListRefresh,
                      selectedChapters: selectedChapters,
                    )
                  : SmallScreenMangaDetails(
                      chapterList: filteredChapterList,
                      manga: data,
                      mangaId: mangaId,
                      onRefresh: refresh,
                      onDescriptionRefresh: mangaRefresh,
                      onListRefresh: chapterListRefresh,
                      selectedChapters: selectedChapters,
                    )
              : Emoticons(
                  text: context.l10n!.noMangaFound,
                  button: TextButton(
                    onPressed: refresh,
                    child: Text(context.l10n!.refresh),
                  ),
                ),
        ),
        refresh: refresh,
        wrapper: (body) => Scaffold(
          appBar: AppBar(
            title: Text(context.l10n!.manga),
          ),
          body: body,
        ),
      ),
    );
  }
}

class MultiSelectPopupButton extends StatelessWidget {
  const MultiSelectPopupButton({
    super.key,
    required this.filteredChapterList,
    required this.selectedChapters,
  });

  final AsyncValue<List<Chapter>?> filteredChapterList;
  final ValueNotifier<Map<int, Chapter>> selectedChapters;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: KBorderRadius.r16.radius,
      ),
      icon: const Icon(Icons.more_vert_rounded),
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: () {
            List<Chapter> chapterList = [...?filteredChapterList.valueOrNull];
            final lastId = selectedChapters.value.keys.last;
            final lastIndex =
                chapterList.lastIndexWhere((chapter) => chapter.id == lastId);
            final maxIndex = min(chapterList.length, lastIndex + 10);
            selectedChapters.value = ({
              ...selectedChapters.value,
              for (int i = lastIndex + 1; i < maxIndex; i++)
                if (chapterList[i].id != null)
                  chapterList[i].id!: chapterList[i]
            });
          },
          child: Text(context.l10n!.selectNext10),
        ),
        PopupMenuItem(
          onTap: () {
            final chapterList = [...?filteredChapterList.valueOrNull];

            selectedChapters.value = ({
              for (Chapter i in chapterList)
                if (i.id != null && !i.read.ifNull()) i.id!: i
            });
          },
          child: Text(context.l10n!.selectUnread),
        ),
        PopupMenuItem(
          onTap: () {
            final chapterList = [...?filteredChapterList.valueOrNull];
            final selectedChapterIds =
                selectedChapters.value.keys.toList(growable: false);
            final firstSelectedIndex = chapterList.indexWhere(
                (chapter) => chapter.id == selectedChapterIds.firstOrNull);
            final lastSelectedIndex = chapterList.indexWhere(
                (chapter) => chapter.id == selectedChapterIds.lastOrNull);
            final firstIndex = min(firstSelectedIndex, lastSelectedIndex);
            final lastIndex = max(firstSelectedIndex, lastSelectedIndex);

            selectedChapters.value = ({
              for (int i = firstIndex; i <= lastIndex; i++)
                if (chapterList[i].id != null)
                  chapterList[i].id!: chapterList[i]
            });
          },
          child: Text(context.l10n!.selectInBetween),
        ),
      ],
    );
  }
}
