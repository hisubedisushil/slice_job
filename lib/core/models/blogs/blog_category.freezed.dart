// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'blog_category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BlogCategory _$BlogCategoryFromJson(Map<String, dynamic> json) {
  return _BlogCategory.fromJson(json);
}

/// @nodoc
mixin _$BlogCategory {
  String get id => throw _privateConstructorUsedError;
  String? get parentId => throw _privateConstructorUsedError;
  String? get catName => throw _privateConstructorUsedError;
  String? get catSlug => throw _privateConstructorUsedError;
  String? get date => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  String? get testField => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BlogCategoryCopyWith<BlogCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BlogCategoryCopyWith<$Res> {
  factory $BlogCategoryCopyWith(
          BlogCategory value, $Res Function(BlogCategory) then) =
      _$BlogCategoryCopyWithImpl<$Res, BlogCategory>;
  @useResult
  $Res call(
      {String id,
      String? parentId,
      String? catName,
      String? catSlug,
      String? date,
      String? status,
      String? testField});
}

/// @nodoc
class _$BlogCategoryCopyWithImpl<$Res, $Val extends BlogCategory>
    implements $BlogCategoryCopyWith<$Res> {
  _$BlogCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? parentId = freezed,
    Object? catName = freezed,
    Object? catSlug = freezed,
    Object? date = freezed,
    Object? status = freezed,
    Object? testField = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String?,
      catName: freezed == catName
          ? _value.catName
          : catName // ignore: cast_nullable_to_non_nullable
              as String?,
      catSlug: freezed == catSlug
          ? _value.catSlug
          : catSlug // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      testField: freezed == testField
          ? _value.testField
          : testField // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_BlogCategoryCopyWith<$Res>
    implements $BlogCategoryCopyWith<$Res> {
  factory _$$_BlogCategoryCopyWith(
          _$_BlogCategory value, $Res Function(_$_BlogCategory) then) =
      __$$_BlogCategoryCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String? parentId,
      String? catName,
      String? catSlug,
      String? date,
      String? status,
      String? testField});
}

/// @nodoc
class __$$_BlogCategoryCopyWithImpl<$Res>
    extends _$BlogCategoryCopyWithImpl<$Res, _$_BlogCategory>
    implements _$$_BlogCategoryCopyWith<$Res> {
  __$$_BlogCategoryCopyWithImpl(
      _$_BlogCategory _value, $Res Function(_$_BlogCategory) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? parentId = freezed,
    Object? catName = freezed,
    Object? catSlug = freezed,
    Object? date = freezed,
    Object? status = freezed,
    Object? testField = freezed,
  }) {
    return _then(_$_BlogCategory(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String?,
      catName: freezed == catName
          ? _value.catName
          : catName // ignore: cast_nullable_to_non_nullable
              as String?,
      catSlug: freezed == catSlug
          ? _value.catSlug
          : catSlug // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      testField: freezed == testField
          ? _value.testField
          : testField // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_BlogCategory implements _BlogCategory {
  const _$_BlogCategory(
      {required this.id,
      this.parentId,
      this.catName,
      this.catSlug,
      this.date,
      this.status,
      this.testField});

  factory _$_BlogCategory.fromJson(Map<String, dynamic> json) =>
      _$$_BlogCategoryFromJson(json);

  @override
  final String id;
  @override
  final String? parentId;
  @override
  final String? catName;
  @override
  final String? catSlug;
  @override
  final String? date;
  @override
  final String? status;
  @override
  final String? testField;

  @override
  String toString() {
    return 'BlogCategory(id: $id, parentId: $parentId, catName: $catName, catSlug: $catSlug, date: $date, status: $status, testField: $testField)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BlogCategory &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId) &&
            (identical(other.catName, catName) || other.catName == catName) &&
            (identical(other.catSlug, catSlug) || other.catSlug == catSlug) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.testField, testField) ||
                other.testField == testField));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, parentId, catName, catSlug, date, status, testField);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BlogCategoryCopyWith<_$_BlogCategory> get copyWith =>
      __$$_BlogCategoryCopyWithImpl<_$_BlogCategory>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BlogCategoryToJson(
      this,
    );
  }
}

abstract class _BlogCategory implements BlogCategory {
  const factory _BlogCategory(
      {required final String id,
      final String? parentId,
      final String? catName,
      final String? catSlug,
      final String? date,
      final String? status,
      final String? testField}) = _$_BlogCategory;

  factory _BlogCategory.fromJson(Map<String, dynamic> json) =
      _$_BlogCategory.fromJson;

  @override
  String get id;
  @override
  String? get parentId;
  @override
  String? get catName;
  @override
  String? get catSlug;
  @override
  String? get date;
  @override
  String? get status;
  @override
  String? get testField;
  @override
  @JsonKey(ignore: true)
  _$$_BlogCategoryCopyWith<_$_BlogCategory> get copyWith =>
      throw _privateConstructorUsedError;
}
