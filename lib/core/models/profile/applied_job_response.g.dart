// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'applied_job_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppliedJobs _$$_AppliedJobsFromJson(Map<String, dynamic> json) =>
    _$_AppliedJobs(
      id: json['id'] as String?,
      trackId: json['track_id'] as String?,
      appliedDate: json['applied_date'] as String?,
      action: json['action'] as String?,
      actionDate: json['action_date'] as String?,
      status: json['status'] as String?,
      job: json['job'] == null
          ? null
          : Job.fromJson(json['job'] as Map<String, dynamic>),
      company: Company.fromJson(json['company'] as Map<String, dynamic>?),
    );

Map<String, dynamic> _$$_AppliedJobsToJson(_$_AppliedJobs instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('track_id', instance.trackId);
  writeNotNull('applied_date', instance.appliedDate);
  writeNotNull('action', instance.action);
  writeNotNull('action_date', instance.actionDate);
  writeNotNull('status', instance.status);
  writeNotNull('job', instance.job);
  writeNotNull('company', Company.toJson(instance.company));
  return val;
}
