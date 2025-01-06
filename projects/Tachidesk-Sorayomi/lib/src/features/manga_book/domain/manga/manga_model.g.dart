// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MangaImpl _$$MangaImplFromJson(Map<String, dynamic> json) => _$MangaImpl(
      artist: json['artist'] as String?,
      author: json['author'] as String?,
      description: json['description'] as String?,
      downloadCount: json['downloadCount'] as int?,
      chapterCount: json['chapterCount'] as int?,
      lastReadAt: json['lastReadAt'] as int?,
      lastChapterRead: json['lastChapterRead'] == null
          ? null
          : Chapter.fromJson(json['lastChapterRead'] as Map<String, dynamic>),
      freshData: json['freshData'] as bool?,
      genre:
          (json['genre'] as List<dynamic>?)?.map((e) => e as String).toList(),
      inLibrary: json['inLibrary'] as bool?,
      id: json['id'] as int?,
      inLibraryAt: json['inLibraryAt'] as int?,
      initialized: json['initialized'] as bool?,
      realUrl: json['realUrl'] as String?,
      source: json['source'] == null
          ? null
          : Source.fromJson(json['source'] as Map<String, dynamic>),
      sourceId: json['sourceId'] as String?,
      status: MangaStatus.fromJson(json['status'] as String),
      thumbnailUrl: json['thumbnailUrl'] as String?,
      thumbnailUrlLastFetched: json['thumbnailUrlLastFetched'] as int?,
      title: json['title'] as String?,
      unreadCount: json['unreadCount'] as int?,
      lastFetchedAt: json['lastFetchedAt'] as int?,
      chaptersLastFetchedAt: json['chaptersLastFetchedAt'] as int?,
      url: json['url'] as String?,
      meta: json['meta'] == null
          ? null
          : MangaMeta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$MangaImplToJson(_$MangaImpl instance) =>
    <String, dynamic>{
      'artist': instance.artist,
      'author': instance.author,
      'description': instance.description,
      'downloadCount': instance.downloadCount,
      'chapterCount': instance.chapterCount,
      'lastReadAt': instance.lastReadAt,
      'lastChapterRead': instance.lastChapterRead?.toJson(),
      'freshData': instance.freshData,
      'genre': instance.genre,
      'inLibrary': instance.inLibrary,
      'id': instance.id,
      'inLibraryAt': instance.inLibraryAt,
      'initialized': instance.initialized,
      'realUrl': instance.realUrl,
      'source': instance.source?.toJson(),
      'sourceId': instance.sourceId,
      'status': MangaStatus.toJson(instance.status),
      'thumbnailUrl': instance.thumbnailUrl,
      'thumbnailUrlLastFetched': instance.thumbnailUrlLastFetched,
      'title': instance.title,
      'unreadCount': instance.unreadCount,
      'lastFetchedAt': instance.lastFetchedAt,
      'chaptersLastFetchedAt': instance.chaptersLastFetchedAt,
      'url': instance.url,
      'meta': instance.meta?.toJson(),
    };

_$MangaMetaImpl _$$MangaMetaImplFromJson(Map<String, dynamic> json) =>
    _$MangaMetaImpl(
      invertTap: MangaMeta.fromJsonToBool(
          json['flutter_readerNavigationLayoutInvert']),
      readerNavigationLayout: $enumDecodeNullable(
          _$ReaderNavigationLayoutEnumMap,
          json['flutter_readerNavigationLayout']),
      readerMode:
          $enumDecodeNullable(_$ReaderModeEnumMap, json['flutter_readerMode']),
      readerPadding: MangaMeta.fromJsonToDouble(json['flutter_readerPadding']),
      readerMagnifierSize:
          MangaMeta.fromJsonToDouble(json['flutter_readerMagnifierSize']),
      scanlator: json['flutter_scanlator'] as String?,
    );

Map<String, dynamic> _$$MangaMetaImplToJson(_$MangaMetaImpl instance) =>
    <String, dynamic>{
      'flutter_readerNavigationLayoutInvert': instance.invertTap,
      'flutter_readerNavigationLayout':
          _$ReaderNavigationLayoutEnumMap[instance.readerNavigationLayout],
      'flutter_readerMode': _$ReaderModeEnumMap[instance.readerMode],
      'flutter_readerPadding': instance.readerPadding,
      'flutter_readerMagnifierSize': instance.readerMagnifierSize,
      'flutter_scanlator': instance.scanlator,
    };

const _$ReaderNavigationLayoutEnumMap = {
  ReaderNavigationLayout.defaultNavigation: 'defaultNavigation',
  ReaderNavigationLayout.lShaped: 'lShaped',
  ReaderNavigationLayout.rightAndLeft: 'rightAndLeft',
  ReaderNavigationLayout.edge: 'edge',
  ReaderNavigationLayout.kindlish: 'kindlish',
  ReaderNavigationLayout.disabled: 'disabled',
};

const _$ReaderModeEnumMap = {
  ReaderMode.defaultReader: 'defaultReader',
  ReaderMode.continuousVertical: 'continuousVertical',
  ReaderMode.singleHorizontalLTR: 'singleHorizontalLTR',
  ReaderMode.singleHorizontalRTL: 'singleHorizontalRTL',
  ReaderMode.continuousHorizontalLTR: 'continuousHorizontalLTR',
  ReaderMode.continuousHorizontalRTL: 'continuousHorizontalRTL',
  ReaderMode.singleVertical: 'singleVertical',
  ReaderMode.webtoon: 'webtoon',
};
