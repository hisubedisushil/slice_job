// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'experience.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Experience _$$_ExperienceFromJson(Map<String, dynamic> json) =>
    _$_Experience(
      id: json['id'] as String?,
      userId: json['user_id'] as String?,
      jobTitle: json['job_title'] as String?,
      company: json['company'] as String?,
      location: json['location'] as String?,
      fromMonth: json['from_month'] as String?,
      fromYear: json['from_year'] as String?,
      toMonth: json['to_month'] as String?,
      toYear: json['to_year'] as String?,
      workDescription: json['work_description'] as String?,
      updateDate: json['update_date'] as String?,
    );

Map<String, dynamic> _$$_ExperienceToJson(_$_Experience instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('user_id', instance.userId);
  writeNotNull('job_title', instance.jobTitle);
  writeNotNull('company', instance.company);
  writeNotNull('location', instance.location);
  writeNotNull('from_month', instance.fromMonth);
  writeNotNull('from_year', instance.fromYear);
  writeNotNull('to_month', instance.toMonth);
  writeNotNull('to_year', instance.toYear);
  writeNotNull('work_description', instance.workDescription);
  writeNotNull('update_date', instance.updateDate);
  return val;
}

_$_Education _$$_EducationFromJson(Map<String, dynamic> json) => _$_Education(
      id: json['id'] as String?,
      userId: json['user_id'] as String?,
      degree: json['degree'] as String?,
      field: json['field'] as String?,
      institution: json['institution'] as String?,
      country: json['country'] as String?,
      city: json['city'] as String?,
      startMonth: json['start_month'] as String?,
      startYear: json['start_year'] as String?,
      endMonth: json['end_month'] as String?,
      endYear: json['end_year'] as String?,
      updateDate: json['update_date'] as String?,
    );

Map<String, dynamic> _$$_EducationToJson(_$_Education instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('user_id', instance.userId);
  writeNotNull('degree', instance.degree);
  writeNotNull('field', instance.field);
  writeNotNull('institution', instance.institution);
  writeNotNull('country', instance.country);
  writeNotNull('city', instance.city);
  writeNotNull('start_month', instance.startMonth);
  writeNotNull('start_year', instance.startYear);
  writeNotNull('end_month', instance.endMonth);
  writeNotNull('end_year', instance.endYear);
  writeNotNull('update_date', instance.updateDate);
  return val;
}

_$_Skill _$$_SkillFromJson(Map<String, dynamic> json) => _$_Skill(
      id: json['id'] as String?,
      userId: json['user_id'] as String?,
      skill: json['skill'] as String?,
      level: json['level'] as String?,
      updateDate: json['update_date'] as String?,
    );

Map<String, dynamic> _$$_SkillToJson(_$_Skill instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('user_id', instance.userId);
  writeNotNull('skill', instance.skill);
  writeNotNull('level', instance.level);
  writeNotNull('update_date', instance.updateDate);
  return val;
}

_$_Language _$$_LanguageFromJson(Map<String, dynamic> json) => _$_Language(
      id: json['id'] as String?,
      userId: json['user_id'] as String?,
      language: json['language'] as String?,
      level: json['level'] as String?,
      updateDate: json['update_date'] as String?,
    );

Map<String, dynamic> _$$_LanguageToJson(_$_Language instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('user_id', instance.userId);
  writeNotNull('language', instance.language);
  writeNotNull('level', instance.level);
  writeNotNull('update_date', instance.updateDate);
  return val;
}

_$_Training _$$_TrainingFromJson(Map<String, dynamic> json) => _$_Training(
      id: json['id'] as String?,
      userId: json['user_id'] as String?,
      title: json['title'] as String?,
      startMonth: json['start_month'] as String?,
      startYear: json['start_year'] as String?,
      endMonth: json['end_month'] as String?,
      endYear: json['end_year'] as String?,
      updateDate: json['update_date'] as String?,
    );

Map<String, dynamic> _$$_TrainingToJson(_$_Training instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('user_id', instance.userId);
  writeNotNull('title', instance.title);
  writeNotNull('start_month', instance.startMonth);
  writeNotNull('start_year', instance.startYear);
  writeNotNull('end_month', instance.endMonth);
  writeNotNull('end_year', instance.endYear);
  writeNotNull('update_date', instance.updateDate);
  return val;
}

_$_Certificate _$$_CertificateFromJson(Map<String, dynamic> json) =>
    _$_Certificate(
      id: json['id'] as String?,
      userId: json['user_id'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      issueMonth: json['issue_month'] as String?,
      issueYear: json['issue_year'] as String?,
      expireMonth: json['expire_month'] as String?,
      expireYear: json['expire_year'] as String?,
      updateDate: json['update_date'] as String?,
    );

Map<String, dynamic> _$$_CertificateToJson(_$_Certificate instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('user_id', instance.userId);
  writeNotNull('title', instance.title);
  writeNotNull('description', instance.description);
  writeNotNull('issue_month', instance.issueMonth);
  writeNotNull('issue_year', instance.issueYear);
  writeNotNull('expire_month', instance.expireMonth);
  writeNotNull('expire_year', instance.expireYear);
  writeNotNull('update_date', instance.updateDate);
  return val;
}
