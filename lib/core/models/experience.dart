// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'experience.freezed.dart';
part 'experience.g.dart';

@freezed
class Experience with _$Experience {
  const factory Experience({
    final String? id,
    final String? userId,
    final String? jobTitle,
    final String? company,
    final String? location,
    final String? fromMonth,
    final String? fromYear,
    final String? toMonth,
    final String? toYear,
    final String? workDescription,
    final String? updateDate,
  }) = _Experience;

  factory Experience.fromJson(Map<String, dynamic> json) =>
      _$ExperienceFromJson(json);
}

@freezed
class Education with _$Education {
  const factory Education({
    final String? id,
    final String? userId,
    final String? degree,
    final String? field,
    final String? institution,
    final String? country,
    final String? city,
    final String? startMonth,
    final String? startYear,
    final String? endMonth,
    final String? endYear,
    final String? updateDate,
  }) = _Education;

  factory Education.fromJson(Map<String, dynamic> json) =>
      _$EducationFromJson(json);
}

@freezed
class Skill with _$Skill {
  const factory Skill({
    final String? id,
    final String? userId,
    final String? skill,
    final String? level,
    final String? updateDate,
  }) = _Skill;

  factory Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);
}

@freezed
class Language with _$Language {
  const factory Language({
    final String? id,
    final String? userId,
    final String? language,
    final String? level,
    final String? updateDate,
  }) = _Language;

  factory Language.fromJson(Map<String, dynamic> json) =>
      _$LanguageFromJson(json);
}

@freezed
class Training with _$Training {
  const factory Training({
    final String? id,
    final String? userId,
    final String? title,
    final String? startMonth,
    final String? startYear,
    final String? endMonth,
    final String? endYear,
    final String? updateDate,
  }) = _Training;

  factory Training.fromJson(Map<String, dynamic> json) =>
      _$TrainingFromJson(json);
}

@freezed
class Certificate with _$Certificate {
  const factory Certificate({
    final String? id,
    final String? userId,
    final String? title,
    final String? description,
    final String? issueMonth,
    final String? issueYear,
    final String? expireMonth,
    final String? expireYear,
    final String? updateDate,
  }) = _Certificate;

  factory Certificate.fromJson(Map<String, dynamic> json) =>
      _$CertificateFromJson(json);
}
