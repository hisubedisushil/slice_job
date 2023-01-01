// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job_search.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

JobSearch _$JobSearchFromJson(Map<String, dynamic> json) {
  return _JobSearch.fromJson(json);
}

/// @nodoc
mixin _$JobSearch {
  String? get jobTitle => throw _privateConstructorUsedError;
  String? get jobCategory => throw _privateConstructorUsedError;
  String? get jobType => throw _privateConstructorUsedError;
  String? get careerLevel => throw _privateConstructorUsedError;
  String? get jobSalary => throw _privateConstructorUsedError;
  String? get educationLevel => throw _privateConstructorUsedError;
  String? get experience => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JobSearchCopyWith<JobSearch> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JobSearchCopyWith<$Res> {
  factory $JobSearchCopyWith(JobSearch value, $Res Function(JobSearch) then) =
      _$JobSearchCopyWithImpl<$Res, JobSearch>;
  @useResult
  $Res call(
      {String? jobTitle,
      String? jobCategory,
      String? jobType,
      String? careerLevel,
      String? jobSalary,
      String? educationLevel,
      String? experience});
}

/// @nodoc
class _$JobSearchCopyWithImpl<$Res, $Val extends JobSearch>
    implements $JobSearchCopyWith<$Res> {
  _$JobSearchCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? jobTitle = freezed,
    Object? jobCategory = freezed,
    Object? jobType = freezed,
    Object? careerLevel = freezed,
    Object? jobSalary = freezed,
    Object? educationLevel = freezed,
    Object? experience = freezed,
  }) {
    return _then(_value.copyWith(
      jobTitle: freezed == jobTitle
          ? _value.jobTitle
          : jobTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      jobCategory: freezed == jobCategory
          ? _value.jobCategory
          : jobCategory // ignore: cast_nullable_to_non_nullable
              as String?,
      jobType: freezed == jobType
          ? _value.jobType
          : jobType // ignore: cast_nullable_to_non_nullable
              as String?,
      careerLevel: freezed == careerLevel
          ? _value.careerLevel
          : careerLevel // ignore: cast_nullable_to_non_nullable
              as String?,
      jobSalary: freezed == jobSalary
          ? _value.jobSalary
          : jobSalary // ignore: cast_nullable_to_non_nullable
              as String?,
      educationLevel: freezed == educationLevel
          ? _value.educationLevel
          : educationLevel // ignore: cast_nullable_to_non_nullable
              as String?,
      experience: freezed == experience
          ? _value.experience
          : experience // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_JobSearchCopyWith<$Res> implements $JobSearchCopyWith<$Res> {
  factory _$$_JobSearchCopyWith(
          _$_JobSearch value, $Res Function(_$_JobSearch) then) =
      __$$_JobSearchCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? jobTitle,
      String? jobCategory,
      String? jobType,
      String? careerLevel,
      String? jobSalary,
      String? educationLevel,
      String? experience});
}

/// @nodoc
class __$$_JobSearchCopyWithImpl<$Res>
    extends _$JobSearchCopyWithImpl<$Res, _$_JobSearch>
    implements _$$_JobSearchCopyWith<$Res> {
  __$$_JobSearchCopyWithImpl(
      _$_JobSearch _value, $Res Function(_$_JobSearch) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? jobTitle = freezed,
    Object? jobCategory = freezed,
    Object? jobType = freezed,
    Object? careerLevel = freezed,
    Object? jobSalary = freezed,
    Object? educationLevel = freezed,
    Object? experience = freezed,
  }) {
    return _then(_$_JobSearch(
      jobTitle: freezed == jobTitle
          ? _value.jobTitle
          : jobTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      jobCategory: freezed == jobCategory
          ? _value.jobCategory
          : jobCategory // ignore: cast_nullable_to_non_nullable
              as String?,
      jobType: freezed == jobType
          ? _value.jobType
          : jobType // ignore: cast_nullable_to_non_nullable
              as String?,
      careerLevel: freezed == careerLevel
          ? _value.careerLevel
          : careerLevel // ignore: cast_nullable_to_non_nullable
              as String?,
      jobSalary: freezed == jobSalary
          ? _value.jobSalary
          : jobSalary // ignore: cast_nullable_to_non_nullable
              as String?,
      educationLevel: freezed == educationLevel
          ? _value.educationLevel
          : educationLevel // ignore: cast_nullable_to_non_nullable
              as String?,
      experience: freezed == experience
          ? _value.experience
          : experience // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_JobSearch implements _JobSearch {
  const _$_JobSearch(
      {this.jobTitle,
      this.jobCategory,
      this.jobType,
      this.careerLevel,
      this.jobSalary,
      this.educationLevel,
      this.experience});

  factory _$_JobSearch.fromJson(Map<String, dynamic> json) =>
      _$$_JobSearchFromJson(json);

  @override
  final String? jobTitle;
  @override
  final String? jobCategory;
  @override
  final String? jobType;
  @override
  final String? careerLevel;
  @override
  final String? jobSalary;
  @override
  final String? educationLevel;
  @override
  final String? experience;

  @override
  String toString() {
    return 'JobSearch(jobTitle: $jobTitle, jobCategory: $jobCategory, jobType: $jobType, careerLevel: $careerLevel, jobSalary: $jobSalary, educationLevel: $educationLevel, experience: $experience)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_JobSearch &&
            (identical(other.jobTitle, jobTitle) ||
                other.jobTitle == jobTitle) &&
            (identical(other.jobCategory, jobCategory) ||
                other.jobCategory == jobCategory) &&
            (identical(other.jobType, jobType) || other.jobType == jobType) &&
            (identical(other.careerLevel, careerLevel) ||
                other.careerLevel == careerLevel) &&
            (identical(other.jobSalary, jobSalary) ||
                other.jobSalary == jobSalary) &&
            (identical(other.educationLevel, educationLevel) ||
                other.educationLevel == educationLevel) &&
            (identical(other.experience, experience) ||
                other.experience == experience));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, jobTitle, jobCategory, jobType,
      careerLevel, jobSalary, educationLevel, experience);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_JobSearchCopyWith<_$_JobSearch> get copyWith =>
      __$$_JobSearchCopyWithImpl<_$_JobSearch>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_JobSearchToJson(
      this,
    );
  }
}

abstract class _JobSearch implements JobSearch {
  const factory _JobSearch(
      {final String? jobTitle,
      final String? jobCategory,
      final String? jobType,
      final String? careerLevel,
      final String? jobSalary,
      final String? educationLevel,
      final String? experience}) = _$_JobSearch;

  factory _JobSearch.fromJson(Map<String, dynamic> json) =
      _$_JobSearch.fromJson;

  @override
  String? get jobTitle;
  @override
  String? get jobCategory;
  @override
  String? get jobType;
  @override
  String? get careerLevel;
  @override
  String? get jobSalary;
  @override
  String? get educationLevel;
  @override
  String? get experience;
  @override
  @JsonKey(ignore: true)
  _$$_JobSearchCopyWith<_$_JobSearch> get copyWith =>
      throw _privateConstructorUsedError;
}
