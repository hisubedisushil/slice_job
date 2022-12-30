// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job_category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

JobCategory _$JobCategoryFromJson(Map<String, dynamic> json) {
  return _JobCategory.fromJson(json);
}

/// @nodoc
mixin _$JobCategory {
  String get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JobCategoryCopyWith<JobCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JobCategoryCopyWith<$Res> {
  factory $JobCategoryCopyWith(
          JobCategory value, $Res Function(JobCategory) then) =
      _$JobCategoryCopyWithImpl<$Res, JobCategory>;
  @useResult
  $Res call({String id, String type, String name, String status});
}

/// @nodoc
class _$JobCategoryCopyWithImpl<$Res, $Val extends JobCategory>
    implements $JobCategoryCopyWith<$Res> {
  _$JobCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? name = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_JobCategoryCopyWith<$Res>
    implements $JobCategoryCopyWith<$Res> {
  factory _$$_JobCategoryCopyWith(
          _$_JobCategory value, $Res Function(_$_JobCategory) then) =
      __$$_JobCategoryCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String type, String name, String status});
}

/// @nodoc
class __$$_JobCategoryCopyWithImpl<$Res>
    extends _$JobCategoryCopyWithImpl<$Res, _$_JobCategory>
    implements _$$_JobCategoryCopyWith<$Res> {
  __$$_JobCategoryCopyWithImpl(
      _$_JobCategory _value, $Res Function(_$_JobCategory) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? name = null,
    Object? status = null,
  }) {
    return _then(_$_JobCategory(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_JobCategory implements _JobCategory {
  const _$_JobCategory(
      {required this.id,
      required this.type,
      required this.name,
      required this.status});

  factory _$_JobCategory.fromJson(Map<String, dynamic> json) =>
      _$$_JobCategoryFromJson(json);

  @override
  final String id;
  @override
  final String type;
  @override
  final String name;
  @override
  final String status;

  @override
  String toString() {
    return 'JobCategory(id: $id, type: $type, name: $name, status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_JobCategory &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, type, name, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_JobCategoryCopyWith<_$_JobCategory> get copyWith =>
      __$$_JobCategoryCopyWithImpl<_$_JobCategory>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_JobCategoryToJson(
      this,
    );
  }
}

abstract class _JobCategory implements JobCategory {
  const factory _JobCategory(
      {required final String id,
      required final String type,
      required final String name,
      required final String status}) = _$_JobCategory;

  factory _JobCategory.fromJson(Map<String, dynamic> json) =
      _$_JobCategory.fromJson;

  @override
  String get id;
  @override
  String get type;
  @override
  String get name;
  @override
  String get status;
  @override
  @JsonKey(ignore: true)
  _$$_JobCategoryCopyWith<_$_JobCategory> get copyWith =>
      throw _privateConstructorUsedError;
}
