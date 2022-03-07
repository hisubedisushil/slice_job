import 'dart:convert';

import 'job_model.dart';

RecentJobsResponseModel recentJobsResponseModelFromJson(String str) =>
    RecentJobsResponseModel.fromJson(json.decode(str));
String recentJobsResponseModelToJson(RecentJobsResponseModel data) =>
    json.encode(data.toJson());

class RecentJobsResponseModel {
  RecentJobsResponseModel({
    bool? status,
    String? message,
    List<JobModel>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  RecentJobsResponseModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(JobModel.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<JobModel>? _data;

  bool? get status => _status;
  String? get message => _message;
  List<JobModel>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
