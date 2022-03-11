import 'dart:convert';

import 'company_model.dart';
import 'job_model.dart';

AppliedJobModel dataFromJson(String str) =>
    AppliedJobModel.fromJson(json.decode(str));
String dataToJson(AppliedJobModel data) => json.encode(data.toJson());

class AppliedJobModel {
  AppliedJobModel({
    String? id,
    String? trackId,
    String? appliedDate,
    String? action,
    String? actionDate,
    String? status,
    JobModel? job,
    CompanyModel? company,
  }) {
    _id = id;
    _trackId = trackId;
    _appliedDate = appliedDate;
    _action = action;
    _actionDate = actionDate;
    _status = status;
    _job = job;
    _company = company;
  }

  AppliedJobModel.fromJson(dynamic json) {
    _id = json['id'];
    _trackId = json['track_id'];
    _appliedDate = json['applied_date'];
    _action = json['action'];
    _actionDate = json['action_date'];
    _status = json['status'];
    _job = json['job'] != null ? JobModel.fromJson(json['job']) : null;
    _company =
        json['company'] != null ? CompanyModel.fromJson(json['company']) : null;
  }
  String? _id;
  String? _trackId;
  String? _appliedDate;
  String? _action;
  String? _actionDate;
  String? _status;
  JobModel? _job;
  CompanyModel? _company;

  String? get id => _id;
  String? get trackId => _trackId;
  String? get appliedDate => _appliedDate;
  String? get action => _action;
  String? get actionDate => _actionDate;
  String? get status => _status;
  JobModel? get job => _job;
  CompanyModel? get company => _company;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['track_id'] = _trackId;
    map['applied_date'] = _appliedDate;
    map['action'] = _action;
    map['action_date'] = _actionDate;
    map['status'] = _status;
    if (_job != null) {
      map['job'] = _job?.toJson();
    }
    if (_company != null) {
      map['company'] = _company?.toJson();
    }
    return map;
  }
}
