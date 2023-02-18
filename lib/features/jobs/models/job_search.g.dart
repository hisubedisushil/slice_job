// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_JobSearch _$$_JobSearchFromJson(Map<String, dynamic> json) => _$_JobSearch(
      jobTittle: json['job_tittle'] as String?,
      jobCategory: json['job_category'] as String?,
      jobType: json['job_type'] as String?,
      careerLevel: json['career_level'] as String?,
      jobSalary: json['job_salary'] as String?,
      educationLevel: json['education_level'] as String?,
      experience: json['experience'] as String?,
    );

Map<String, dynamic> _$$_JobSearchToJson(_$_JobSearch instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('job_tittle', instance.jobTittle);
  writeNotNull('job_category', instance.jobCategory);
  writeNotNull('job_type', instance.jobType);
  writeNotNull('career_level', instance.careerLevel);
  writeNotNull('job_salary', instance.jobSalary);
  writeNotNull('education_level', instance.educationLevel);
  writeNotNull('experience', instance.experience);
  return val;
}
