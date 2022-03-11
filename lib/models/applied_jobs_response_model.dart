import 'dart:convert';

import 'appled_job_model.dart';

AppliedJobsResponseModel appliedJobsResponseModelFromJson(String str) =>
    AppliedJobsResponseModel.fromJson(json.decode(str));
String appliedJobsResponseModelToJson(AppliedJobsResponseModel data) =>
    json.encode(data.toJson());

class AppliedJobsResponseModel {
  AppliedJobsResponseModel({
    bool? status,
    String? message,
    List<AppliedJobModel>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  AppliedJobsResponseModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(AppliedJobModel.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<AppliedJobModel>? _data;

  bool? get status => _status;
  String? get message => _message;
  List<AppliedJobModel>? get data => _data;

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
