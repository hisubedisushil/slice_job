// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Job _$JobFromJson(Map<String, dynamic> json) {
  return _Job.fromJson(json);
}

/// @nodoc
mixin _$Job {
  String get id => throw _privateConstructorUsedError;
  String get jobKey => throw _privateConstructorUsedError;
  String? get jobTittle => throw _privateConstructorUsedError;
  String? get jobCity => throw _privateConstructorUsedError;
  String? get jobCountry => throw _privateConstructorUsedError;
  String? get experience => throw _privateConstructorUsedError;
  String? get postDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'company', fromJson: Company.fromJson, toJson: Company.toJson)
  Company? get company => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JobCopyWith<Job> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JobCopyWith<$Res> {
  factory $JobCopyWith(Job value, $Res Function(Job) then) =
      _$JobCopyWithImpl<$Res, Job>;
  @useResult
  $Res call(
      {String id,
      String jobKey,
      String? jobTittle,
      String? jobCity,
      String? jobCountry,
      String? experience,
      String? postDate,
      @JsonKey(name: 'company', fromJson: Company.fromJson, toJson: Company.toJson)
          Company? company});
}

/// @nodoc
class _$JobCopyWithImpl<$Res, $Val extends Job> implements $JobCopyWith<$Res> {
  _$JobCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? jobKey = null,
    Object? jobTittle = freezed,
    Object? jobCity = freezed,
    Object? jobCountry = freezed,
    Object? experience = freezed,
    Object? postDate = freezed,
    Object? company = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      jobKey: null == jobKey
          ? _value.jobKey
          : jobKey // ignore: cast_nullable_to_non_nullable
              as String,
      jobTittle: freezed == jobTittle
          ? _value.jobTittle
          : jobTittle // ignore: cast_nullable_to_non_nullable
              as String?,
      jobCity: freezed == jobCity
          ? _value.jobCity
          : jobCity // ignore: cast_nullable_to_non_nullable
              as String?,
      jobCountry: freezed == jobCountry
          ? _value.jobCountry
          : jobCountry // ignore: cast_nullable_to_non_nullable
              as String?,
      experience: freezed == experience
          ? _value.experience
          : experience // ignore: cast_nullable_to_non_nullable
              as String?,
      postDate: freezed == postDate
          ? _value.postDate
          : postDate // ignore: cast_nullable_to_non_nullable
              as String?,
      company: freezed == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as Company?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_JobCopyWith<$Res> implements $JobCopyWith<$Res> {
  factory _$$_JobCopyWith(_$_Job value, $Res Function(_$_Job) then) =
      __$$_JobCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String jobKey,
      String? jobTittle,
      String? jobCity,
      String? jobCountry,
      String? experience,
      String? postDate,
      @JsonKey(name: 'company', fromJson: Company.fromJson, toJson: Company.toJson)
          Company? company});
}

/// @nodoc
class __$$_JobCopyWithImpl<$Res> extends _$JobCopyWithImpl<$Res, _$_Job>
    implements _$$_JobCopyWith<$Res> {
  __$$_JobCopyWithImpl(_$_Job _value, $Res Function(_$_Job) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? jobKey = null,
    Object? jobTittle = freezed,
    Object? jobCity = freezed,
    Object? jobCountry = freezed,
    Object? experience = freezed,
    Object? postDate = freezed,
    Object? company = freezed,
  }) {
    return _then(_$_Job(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      jobKey: null == jobKey
          ? _value.jobKey
          : jobKey // ignore: cast_nullable_to_non_nullable
              as String,
      jobTittle: freezed == jobTittle
          ? _value.jobTittle
          : jobTittle // ignore: cast_nullable_to_non_nullable
              as String?,
      jobCity: freezed == jobCity
          ? _value.jobCity
          : jobCity // ignore: cast_nullable_to_non_nullable
              as String?,
      jobCountry: freezed == jobCountry
          ? _value.jobCountry
          : jobCountry // ignore: cast_nullable_to_non_nullable
              as String?,
      experience: freezed == experience
          ? _value.experience
          : experience // ignore: cast_nullable_to_non_nullable
              as String?,
      postDate: freezed == postDate
          ? _value.postDate
          : postDate // ignore: cast_nullable_to_non_nullable
              as String?,
      company: freezed == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as Company?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Job implements _Job {
  const _$_Job(
      {required this.id,
      required this.jobKey,
      this.jobTittle,
      this.jobCity,
      this.jobCountry,
      this.experience,
      this.postDate,
      @JsonKey(name: 'company', fromJson: Company.fromJson, toJson: Company.toJson)
          this.company});

  factory _$_Job.fromJson(Map<String, dynamic> json) => _$$_JobFromJson(json);

  @override
  final String id;
  @override
  final String jobKey;
  @override
  final String? jobTittle;
  @override
  final String? jobCity;
  @override
  final String? jobCountry;
  @override
  final String? experience;
  @override
  final String? postDate;
  @override
  @JsonKey(name: 'company', fromJson: Company.fromJson, toJson: Company.toJson)
  final Company? company;

  @override
  String toString() {
    return 'Job(id: $id, jobKey: $jobKey, jobTittle: $jobTittle, jobCity: $jobCity, jobCountry: $jobCountry, experience: $experience, postDate: $postDate, company: $company)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Job &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.jobKey, jobKey) || other.jobKey == jobKey) &&
            (identical(other.jobTittle, jobTittle) ||
                other.jobTittle == jobTittle) &&
            (identical(other.jobCity, jobCity) || other.jobCity == jobCity) &&
            (identical(other.jobCountry, jobCountry) ||
                other.jobCountry == jobCountry) &&
            (identical(other.experience, experience) ||
                other.experience == experience) &&
            (identical(other.postDate, postDate) ||
                other.postDate == postDate) &&
            (identical(other.company, company) || other.company == company));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, jobKey, jobTittle, jobCity,
      jobCountry, experience, postDate, company);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_JobCopyWith<_$_Job> get copyWith =>
      __$$_JobCopyWithImpl<_$_Job>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_JobToJson(
      this,
    );
  }
}

abstract class _Job implements Job {
  const factory _Job(
      {required final String id,
      required final String jobKey,
      final String? jobTittle,
      final String? jobCity,
      final String? jobCountry,
      final String? experience,
      final String? postDate,
      @JsonKey(name: 'company', fromJson: Company.fromJson, toJson: Company.toJson)
          final Company? company}) = _$_Job;

  factory _Job.fromJson(Map<String, dynamic> json) = _$_Job.fromJson;

  @override
  String get id;
  @override
  String get jobKey;
  @override
  String? get jobTittle;
  @override
  String? get jobCity;
  @override
  String? get jobCountry;
  @override
  String? get experience;
  @override
  String? get postDate;
  @override
  @JsonKey(name: 'company', fromJson: Company.fromJson, toJson: Company.toJson)
  Company? get company;
  @override
  @JsonKey(ignore: true)
  _$$_JobCopyWith<_$_Job> get copyWith => throw _privateConstructorUsedError;
}
