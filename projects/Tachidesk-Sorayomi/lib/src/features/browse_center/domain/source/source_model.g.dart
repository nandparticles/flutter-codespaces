// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'source_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SourceImpl _$$SourceImplFromJson(Map<String, dynamic> json) => _$SourceImpl(
      displayName: json['displayName'] as String?,
      iconUrl: json['iconUrl'] as String?,
      id: json['id'] as String?,
      isConfigurable: json['isConfigurable'] as bool?,
      isNsfw: json['isNsfw'] as bool?,
      lang: LanguageJsonConverter.fromJson(json['lang'] as String?),
      name: json['name'] as String?,
      supportsLatest: json['supportsLatest'] as bool?,
    );

Map<String, dynamic> _$$SourceImplToJson(_$SourceImpl instance) =>
    <String, dynamic>{
      'displayName': instance.displayName,
      'iconUrl': instance.iconUrl,
      'id': instance.id,
      'isConfigurable': instance.isConfigurable,
      'isNsfw': instance.isNsfw,
      'lang': LanguageJsonConverter.toJson(instance.lang),
      'name': instance.name,
      'supportsLatest': instance.supportsLatest,
    };
