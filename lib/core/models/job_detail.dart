// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'company.dart';

part 'job_detail.freezed.dart';
part 'job_detail.g.dart';

@freezed
class JobDetail with _$JobDetail {
  factory JobDetail({
    required final String id,
    required final String jobKey,
    String? jobTittle,
    String? jobCategory,
    String? jobCatId,
    String? jobType,
    String? jobCountry,
    String? jobCity,
    String? careerLevel,
    String? educationLevel,
    String? experience,
    String? jobSalary,
    String? jobApplyUrl,
    String? applicationReceieveBoth,
    String? benefits,
    String? descriptions,
    String? postDate,
    @JsonKey(name: 'company', fromJson: Company.fromJson, toJson: Company.toJson)
        final Company? company,
    String? onlineExam,
    String? link,
  }) = _JobDetail;

  factory JobDetail.fromJson(Map<String, dynamic> json) =>
      _$JobDetailFromJson(json);
}

extension JobDetailX on JobDetail {
  Map<String, String?> toDisplayMap() {
    final mapData = <String, String?>{};
    mapData.putIfAbsent('Job Category', () => jobCategory);
    mapData.putIfAbsent('Job Location', () => jobCity);
    mapData.putIfAbsent('Job Type', () => jobType);
    mapData.putIfAbsent('Career Level', () => careerLevel);
    mapData.putIfAbsent('Education Required', () => educationLevel);
    mapData.putIfAbsent('Experience Required', () => experience);
    mapData.putIfAbsent('Salary', () => jobSalary);
    mapData.putIfAbsent('Facility/Benefits\nProvided', () => benefits);
    return mapData;
  }
}
