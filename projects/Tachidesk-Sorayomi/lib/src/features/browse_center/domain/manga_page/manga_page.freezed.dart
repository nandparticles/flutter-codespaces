// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'manga_page.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MangaPage _$MangaPageFromJson(Map<String, dynamic> json) {
  return _MangaPage.fromJson(json);
}

/// @nodoc
mixin _$MangaPage {
  List<Manga>? get mangaList => throw _privateConstructorUsedError;
  bool? get hasNextPage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MangaPageCopyWith<MangaPage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MangaPageCopyWith<$Res> {
  factory $MangaPageCopyWith(MangaPage value, $Res Function(MangaPage) then) =
      _$MangaPageCopyWithImpl<$Res, MangaPage>;
  @useResult
  $Res call({List<Manga>? mangaList, bool? hasNextPage});
}

/// @nodoc
class _$MangaPageCopyWithImpl<$Res, $Val extends MangaPage>
    implements $MangaPageCopyWith<$Res> {
  _$MangaPageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mangaList = freezed,
    Object? hasNextPage = freezed,
  }) {
    return _then(_value.copyWith(
      mangaList: freezed == mangaList
          ? _value.mangaList
          : mangaList // ignore: cast_nullable_to_non_nullable
              as List<Manga>?,
      hasNextPage: freezed == hasNextPage
          ? _value.hasNextPage
          : hasNextPage // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MangaPageImplCopyWith<$Res>
    implements $MangaPageCopyWith<$Res> {
  factory _$$MangaPageImplCopyWith(
          _$MangaPageImpl value, $Res Function(_$MangaPageImpl) then) =
      __$$MangaPageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Manga>? mangaList, bool? hasNextPage});
}

/// @nodoc
class __$$MangaPageImplCopyWithImpl<$Res>
    extends _$MangaPageCopyWithImpl<$Res, _$MangaPageImpl>
    implements _$$MangaPageImplCopyWith<$Res> {
  __$$MangaPageImplCopyWithImpl(
      _$MangaPageImpl _value, $Res Function(_$MangaPageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mangaList = freezed,
    Object? hasNextPage = freezed,
  }) {
    return _then(_$MangaPageImpl(
      mangaList: freezed == mangaList
          ? _value._mangaList
          : mangaList // ignore: cast_nullable_to_non_nullable
              as List<Manga>?,
      hasNextPage: freezed == hasNextPage
          ? _value.hasNextPage
          : hasNextPage // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MangaPageImpl implements _MangaPage {
  _$MangaPageImpl({final List<Manga>? mangaList, this.hasNextPage})
      : _mangaList = mangaList;

  factory _$MangaPageImpl.fromJson(Map<String, dynamic> json) =>
      _$$MangaPageImplFromJson(json);

  final List<Manga>? _mangaList;
  @override
  List<Manga>? get mangaList {
    final value = _mangaList;
    if (value == null) return null;
    if (_mangaList is EqualUnmodifiableListView) return _mangaList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final bool? hasNextPage;

  @override
  String toString() {
    return 'MangaPage(mangaList: $mangaList, hasNextPage: $hasNextPage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MangaPageImpl &&
            const DeepCollectionEquality()
                .equals(other._mangaList, _mangaList) &&
            (identical(other.hasNextPage, hasNextPage) ||
                other.hasNextPage == hasNextPage));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_mangaList), hasNextPage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MangaPageImplCopyWith<_$MangaPageImpl> get copyWith =>
      __$$MangaPageImplCopyWithImpl<_$MangaPageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MangaPageImplToJson(
      this,
    );
  }
}

abstract class _MangaPage implements MangaPage {
  factory _MangaPage({final List<Manga>? mangaList, final bool? hasNextPage}) =
      _$MangaPageImpl;

  factory _MangaPage.fromJson(Map<String, dynamic> json) =
      _$MangaPageImpl.fromJson;

  @override
  List<Manga>? get mangaList;
  @override
  bool? get hasNextPage;
  @override
  @JsonKey(ignore: true)
  _$$MangaPageImplCopyWith<_$MangaPageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
