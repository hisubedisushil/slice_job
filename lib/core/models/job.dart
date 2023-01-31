// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:slice_job/core/models/company.dart';

part 'job.freezed.dart';
part 'job.g.dart';

@freezed
class Job with _$Job {
  const factory Job({
    required final String id,
    required final String jobKey,
    final String? jobTittle,
    final String? jobCity,
    final String? jobCountry,
    final String? experience,
    final String? postDate,
    @JsonKey(name: 'company', fromJson: Company.fromJson, toJson: Company.toJson)
        final Company? company,
  }) = _Job;

  factory Job.fromJson(Map<String, dynamic> json) => _$JobFromJson(json);
}

@freezed
class JobTitle with _$JobTitle {
  const factory JobTitle({
    final String? id,
    final String? title,
    final String? categoryId,
    final String? status,
  }) = _JobTitle;

  factory JobTitle.fromJson(Map<String, dynamic> json) =>
      _$JobTitleFromJson(json);
}

@freezed
class JobType with _$JobType {
  const factory JobType({
    required final String id,
    required final String name,
    final String? status,
  }) = _JobType;

  factory JobType.fromJson(Map<String, dynamic> json) =>
      _$JobTypeFromJson(json);
}
