import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:slice_job/core/models/company.dart';
import 'package:slice_job/core/models/job.dart';

part 'applied_job_response.freezed.dart';
part 'applied_job_response.g.dart';

@freezed
class AppliedJobs with _$AppliedJobs {
  const factory AppliedJobs({
     final String? id,
     final String? trackId,
     final String? appliedDate,
     final String? action,
     final String? actionDate,
     final String? status,
     final Job? job,
     @JsonKey(name: 'company', fromJson: Company.fromJson, toJson: Company.toJson)
        final Company? company,
  }) = _AppliedJobs;

  factory AppliedJobs.fromJson(Map<String, dynamic> json) =>
      _$AppliedJobsFromJson(json);
}