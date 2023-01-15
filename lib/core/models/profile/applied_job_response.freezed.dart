// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'applied_job_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AppliedJobs _$AppliedJobsFromJson(Map<String, dynamic> json) {
  return _AppliedJobs.fromJson(json);
}

/// @nodoc
mixin _$AppliedJobs {
  String? get id => throw _privateConstructorUsedError;
  String? get trackId => throw _privateConstructorUsedError;
  String? get appliedDate => throw _privateConstructorUsedError;
  String? get action => throw _privateConstructorUsedError;
  String? get actionDate => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  Job? get job => throw _privateConstructorUsedError;
  @JsonKey(name: 'company', fromJson: Company.fromJson, toJson: Company.toJson)
  Company? get company => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppliedJobsCopyWith<AppliedJobs> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppliedJobsCopyWith<$Res> {
  factory $AppliedJobsCopyWith(
          AppliedJobs value, $Res Function(AppliedJobs) then) =
      _$AppliedJobsCopyWithImpl<$Res, AppliedJobs>;
  @useResult
  $Res call(
      {String? id,
      String? trackId,
      String? appliedDate,
      String? action,
      String? actionDate,
      String? status,
      Job? job,
      @JsonKey(name: 'company', fromJson: Company.fromJson, toJson: Company.toJson)
          Company? company});

  $JobCopyWith<$Res>? get job;
}

/// @nodoc
class _$AppliedJobsCopyWithImpl<$Res, $Val extends AppliedJobs>
    implements $AppliedJobsCopyWith<$Res> {
  _$AppliedJobsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? trackId = freezed,
    Object? appliedDate = freezed,
    Object? action = freezed,
    Object? actionDate = freezed,
    Object? status = freezed,
    Object? job = freezed,
    Object? company = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      trackId: freezed == trackId
          ? _value.trackId
          : trackId // ignore: cast_nullable_to_non_nullable
              as String?,
      appliedDate: freezed == appliedDate
          ? _value.appliedDate
          : appliedDate // ignore: cast_nullable_to_non_nullable
              as String?,
      action: freezed == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String?,
      actionDate: freezed == actionDate
          ? _value.actionDate
          : actionDate // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      job: freezed == job
          ? _value.job
          : job // ignore: cast_nullable_to_non_nullable
              as Job?,
      company: freezed == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as Company?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $JobCopyWith<$Res>? get job {
    if (_value.job == null) {
      return null;
    }

    return $JobCopyWith<$Res>(_value.job!, (value) {
      return _then(_value.copyWith(job: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_AppliedJobsCopyWith<$Res>
    implements $AppliedJobsCopyWith<$Res> {
  factory _$$_AppliedJobsCopyWith(
          _$_AppliedJobs value, $Res Function(_$_AppliedJobs) then) =
      __$$_AppliedJobsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? trackId,
      String? appliedDate,
      String? action,
      String? actionDate,
      String? status,
      Job? job,
      @JsonKey(name: 'company', fromJson: Company.fromJson, toJson: Company.toJson)
          Company? company});

  @override
  $JobCopyWith<$Res>? get job;
}

/// @nodoc
class __$$_AppliedJobsCopyWithImpl<$Res>
    extends _$AppliedJobsCopyWithImpl<$Res, _$_AppliedJobs>
    implements _$$_AppliedJobsCopyWith<$Res> {
  __$$_AppliedJobsCopyWithImpl(
      _$_AppliedJobs _value, $Res Function(_$_AppliedJobs) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? trackId = freezed,
    Object? appliedDate = freezed,
    Object? action = freezed,
    Object? actionDate = freezed,
    Object? status = freezed,
    Object? job = freezed,
    Object? company = freezed,
  }) {
    return _then(_$_AppliedJobs(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      trackId: freezed == trackId
          ? _value.trackId
          : trackId // ignore: cast_nullable_to_non_nullable
              as String?,
      appliedDate: freezed == appliedDate
          ? _value.appliedDate
          : appliedDate // ignore: cast_nullable_to_non_nullable
              as String?,
      action: freezed == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String?,
      actionDate: freezed == actionDate
          ? _value.actionDate
          : actionDate // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      job: freezed == job
          ? _value.job
          : job // ignore: cast_nullable_to_non_nullable
              as Job?,
      company: freezed == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as Company?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AppliedJobs implements _AppliedJobs {
  const _$_AppliedJobs(
      {this.id,
      this.trackId,
      this.appliedDate,
      this.action,
      this.actionDate,
      this.status,
      this.job,
      @JsonKey(name: 'company', fromJson: Company.fromJson, toJson: Company.toJson)
          this.company});

  factory _$_AppliedJobs.fromJson(Map<String, dynamic> json) =>
      _$$_AppliedJobsFromJson(json);

  @override
  final String? id;
  @override
  final String? trackId;
  @override
  final String? appliedDate;
  @override
  final String? action;
  @override
  final String? actionDate;
  @override
  final String? status;
  @override
  final Job? job;
  @override
  @JsonKey(name: 'company', fromJson: Company.fromJson, toJson: Company.toJson)
  final Company? company;

  @override
  String toString() {
    return 'AppliedJobs(id: $id, trackId: $trackId, appliedDate: $appliedDate, action: $action, actionDate: $actionDate, status: $status, job: $job, company: $company)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppliedJobs &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.trackId, trackId) || other.trackId == trackId) &&
            (identical(other.appliedDate, appliedDate) ||
                other.appliedDate == appliedDate) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.actionDate, actionDate) ||
                other.actionDate == actionDate) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.job, job) || other.job == job) &&
            (identical(other.company, company) || other.company == company));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, trackId, appliedDate, action,
      actionDate, status, job, company);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AppliedJobsCopyWith<_$_AppliedJobs> get copyWith =>
      __$$_AppliedJobsCopyWithImpl<_$_AppliedJobs>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AppliedJobsToJson(
      this,
    );
  }
}

abstract class _AppliedJobs implements AppliedJobs {
  const factory _AppliedJobs(
      {final String? id,
      final String? trackId,
      final String? appliedDate,
      final String? action,
      final String? actionDate,
      final String? status,
      final Job? job,
      @JsonKey(name: 'company', fromJson: Company.fromJson, toJson: Company.toJson)
          final Company? company}) = _$_AppliedJobs;

  factory _AppliedJobs.fromJson(Map<String, dynamic> json) =
      _$_AppliedJobs.fromJson;

  @override
  String? get id;
  @override
  String? get trackId;
  @override
  String? get appliedDate;
  @override
  String? get action;
  @override
  String? get actionDate;
  @override
  String? get status;
  @override
  Job? get job;
  @override
  @JsonKey(name: 'company', fromJson: Company.fromJson, toJson: Company.toJson)
  Company? get company;
  @override
  @JsonKey(ignore: true)
  _$$_AppliedJobsCopyWith<_$_AppliedJobs> get copyWith =>
      throw _privateConstructorUsedError;
}
