// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cv_basic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CVBasic _$$_CVBasicFromJson(Map<String, dynamic> json) => _$_CVBasic(
      id: json['id'] as String?,
      userId: json['user_id'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      birthDay: json['birth_day'] as String?,
      birthMonth: json['birth_month'] as String?,
      birthYear: json['birth_year'] as String?,
      gender: json['gender'] as String?,
      nationality: json['nationality'] as String?,
      maritalStatus: json['marital_status'] as String?,
      currentCountry: json['current_country'] as String?,
      currentCity: json['current_city'] as String?,
      email: json['email'] as String?,
      contactNumber: json['contact_number'] as String?,
      website: json['website'] as String?,
      jobRole: json['job_role'] as String?,
      jobTitle: json['job_title'] as String?,
      careerLevel: json['career_level'] as String?,
      jobType: json['job_type'] as String?,
      targetSalary: json['target_salary'] as String?,
      targetSalaryCurrency: json['target_salary_currency'] as String?,
      updateDate: json['update_date'] as String?,
      privacy: json['privacy'] as String?,
      testField: json['test_field'] as String?,
    );

Map<String, dynamic> _$$_CVBasicToJson(_$_CVBasic instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('user_id', instance.userId);
  writeNotNull('first_name', instance.firstName);
  writeNotNull('last_name', instance.lastName);
  writeNotNull('birth_day', instance.birthDay);
  writeNotNull('birth_month', instance.birthMonth);
  writeNotNull('birth_year', instance.birthYear);
  writeNotNull('gender', instance.gender);
  writeNotNull('nationality', instance.nationality);
  writeNotNull('marital_status', instance.maritalStatus);
  writeNotNull('current_country', instance.currentCountry);
  writeNotNull('current_city', instance.currentCity);
  writeNotNull('email', instance.email);
  writeNotNull('contact_number', instance.contactNumber);
  writeNotNull('website', instance.website);
  writeNotNull('job_role', instance.jobRole);
  writeNotNull('job_title', instance.jobTitle);
  writeNotNull('career_level', instance.careerLevel);
  writeNotNull('job_type', instance.jobType);
  writeNotNull('target_salary', instance.targetSalary);
  writeNotNull('target_salary_currency', instance.targetSalaryCurrency);
  writeNotNull('update_date', instance.updateDate);
  writeNotNull('privacy', instance.privacy);
  writeNotNull('test_field', instance.testField);
  return val;
}
