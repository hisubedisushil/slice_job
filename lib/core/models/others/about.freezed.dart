// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'about.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

About _$AboutFromJson(Map<String, dynamic> json) {
  return _About.fromJson(json);
}

/// @nodoc
mixin _$About {
  String? get id => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  String? get postTitle => throw _privateConstructorUsedError;
  String? get postDesc => throw _privateConstructorUsedError;
  String? get updatedBy => throw _privateConstructorUsedError;
  String? get updatedDate => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AboutCopyWith<About> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AboutCopyWith<$Res> {
  factory $AboutCopyWith(About value, $Res Function(About) then) =
      _$AboutCopyWithImpl<$Res, About>;
  @useResult
  $Res call(
      {String? id,
      String? category,
      String? postTitle,
      String? postDesc,
      String? updatedBy,
      String? updatedDate,
      String? status});
}

/// @nodoc
class _$AboutCopyWithImpl<$Res, $Val extends About>
    implements $AboutCopyWith<$Res> {
  _$AboutCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? category = freezed,
    Object? postTitle = freezed,
    Object? postDesc = freezed,
    Object? updatedBy = freezed,
    Object? updatedDate = freezed,
    Object? status = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      postTitle: freezed == postTitle
          ? _value.postTitle
          : postTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      postDesc: freezed == postDesc
          ? _value.postDesc
          : postDesc // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedBy: freezed == updatedBy
          ? _value.updatedBy
          : updatedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedDate: freezed == updatedDate
          ? _value.updatedDate
          : updatedDate // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AboutCopyWith<$Res> implements $AboutCopyWith<$Res> {
  factory _$$_AboutCopyWith(_$_About value, $Res Function(_$_About) then) =
      __$$_AboutCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? category,
      String? postTitle,
      String? postDesc,
      String? updatedBy,
      String? updatedDate,
      String? status});
}

/// @nodoc
class __$$_AboutCopyWithImpl<$Res> extends _$AboutCopyWithImpl<$Res, _$_About>
    implements _$$_AboutCopyWith<$Res> {
  __$$_AboutCopyWithImpl(_$_About _value, $Res Function(_$_About) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? category = freezed,
    Object? postTitle = freezed,
    Object? postDesc = freezed,
    Object? updatedBy = freezed,
    Object? updatedDate = freezed,
    Object? status = freezed,
  }) {
    return _then(_$_About(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      postTitle: freezed == postTitle
          ? _value.postTitle
          : postTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      postDesc: freezed == postDesc
          ? _value.postDesc
          : postDesc // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedBy: freezed == updatedBy
          ? _value.updatedBy
          : updatedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedDate: freezed == updatedDate
          ? _value.updatedDate
          : updatedDate // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_About implements _About {
  const _$_About(
      {this.id,
      this.category,
      this.postTitle,
      this.postDesc,
      this.updatedBy,
      this.updatedDate,
      this.status});

  factory _$_About.fromJson(Map<String, dynamic> json) =>
      _$$_AboutFromJson(json);

  @override
  final String? id;
  @override
  final String? category;
  @override
  final String? postTitle;
  @override
  final String? postDesc;
  @override
  final String? updatedBy;
  @override
  final String? updatedDate;
  @override
  final String? status;

  @override
  String toString() {
    return 'About(id: $id, category: $category, postTitle: $postTitle, postDesc: $postDesc, updatedBy: $updatedBy, updatedDate: $updatedDate, status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_About &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.postTitle, postTitle) ||
                other.postTitle == postTitle) &&
            (identical(other.postDesc, postDesc) ||
                other.postDesc == postDesc) &&
            (identical(other.updatedBy, updatedBy) ||
                other.updatedBy == updatedBy) &&
            (identical(other.updatedDate, updatedDate) ||
                other.updatedDate == updatedDate) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, category, postTitle,
      postDesc, updatedBy, updatedDate, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AboutCopyWith<_$_About> get copyWith =>
      __$$_AboutCopyWithImpl<_$_About>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AboutToJson(
      this,
    );
  }
}

abstract class _About implements About {
  const factory _About(
      {final String? id,
      final String? category,
      final String? postTitle,
      final String? postDesc,
      final String? updatedBy,
      final String? updatedDate,
      final String? status}) = _$_About;

  factory _About.fromJson(Map<String, dynamic> json) = _$_About.fromJson;

  @override
  String? get id;
  @override
  String? get category;
  @override
  String? get postTitle;
  @override
  String? get postDesc;
  @override
  String? get updatedBy;
  @override
  String? get updatedDate;
  @override
  String? get status;
  @override
  @JsonKey(ignore: true)
  _$$_AboutCopyWith<_$_About> get copyWith =>
      throw _privateConstructorUsedError;
}
