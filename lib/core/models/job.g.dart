// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Job _$$_JobFromJson(Map<String, dynamic> json) => _$_Job(
      id: json['id'] as String,
      jobKey: json['job_key'] as String,
      jobTittle: json['job_tittle'] as String?,
      jobCity: json['job_city'] as String?,
      jobCountry: json['job_country'] as String?,
      experience: json['experience'] as String?,
      postDate: json['post_date'] as String?,
      company: Company.fromJson(json['company'] as Map<String, dynamic>?),
    );

Map<String, dynamic> _$$_JobToJson(_$_Job instance) {
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
  writeNotNull('job_city', instance.jobCity);
  writeNotNull('job_country', instance.jobCountry);
  writeNotNull('experience', instance.experience);
  writeNotNull('post_date', instance.postDate);
  writeNotNull('company', Company.toJson(instance.company));
  return val;
}

_$_JobTitle _$$_JobTitleFromJson(Map<String, dynamic> json) => _$_JobTitle(
      id: json['id'] as String?,
      title: json['title'] as String?,
      categoryId: json['category_id'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$$_JobTitleToJson(_$_JobTitle instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('title', instance.title);
  writeNotNull('category_id', instance.categoryId);
  writeNotNull('status', instance.status);
  return val;
}

_$_JobType _$$_JobTypeFromJson(Map<String, dynamic> json) => _$_JobType(
      id: json['id'] as String,
      name: json['name'] as String,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$$_JobTypeToJson(_$_JobType instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('status', instance.status);
  return val;
}
