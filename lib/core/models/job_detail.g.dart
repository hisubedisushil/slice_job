// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_JobDetail _$$_JobDetailFromJson(Map<String, dynamic> json) => _$_JobDetail(
      id: json['id'] as String,
      jobKey: json['job_key'] as String,
      jobTittle: json['job_tittle'] as String?,
      jobCategory: json['job_category'] as String?,
      jobCatId: json['job_cat_id'] as String?,
      jobType: json['job_type'] as String?,
      jobCountry: json['job_country'] as String?,
      jobCity: json['job_city'] as String?,
      careerLevel: json['career_level'] as String?,
      educationLevel: json['education_level'] as String?,
      experience: json['experience'] as String?,
      jobSalary: json['job_salary'] as String?,
      jobApplyUrl: json['job_apply_url'] as String?,
      applicationReceieveBoth: json['application_receieve_both'] as String?,
      benefits: json['benefits'] as String?,
      descriptions: json['descriptions'] as String?,
      postDate: json['post_date'] as String?,
      company: Company.fromJson(json['company'] as Map<String, dynamic>?),
      onlineExam: json['online_exam'] as String?,
      link: json['link'] as String?,
    );

Map<String, dynamic> _$$_JobDetailToJson(_$_JobDetail instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'job_key': instance.jobKey,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('job_tittle', instance.jobTittle);
  writeNotNull('job_category', instance.jobCategory);
  writeNotNull('job_cat_id', instance.jobCatId);
  writeNotNull('job_type', instance.jobType);
  writeNotNull('job_country', instance.jobCountry);
  writeNotNull('job_city', instance.jobCity);
  writeNotNull('career_level', instance.careerLevel);
  writeNotNull('education_level', instance.educationLevel);
  writeNotNull('experience', instance.experience);
  writeNotNull('job_salary', instance.jobSalary);
  writeNotNull('job_apply_url', instance.jobApplyUrl);
  writeNotNull('application_receieve_both', instance.applicationReceieveBoth);
  writeNotNull('benefits', instance.benefits);
  writeNotNull('descriptions', instance.descriptions);
  writeNotNull('post_date', instance.postDate);
  writeNotNull('company', Company.toJson(instance.company));
  writeNotNull('online_exam', instance.onlineExam);
  writeNotNull('link', instance.link);
  return val;
}
