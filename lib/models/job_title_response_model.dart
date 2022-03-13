import 'dart:convert';

import 'job_title_model.dart';

JobTitleResponseModel jobTitleResponseModelFromJson(String str) =>
    JobTitleResponseModel.fromJson(json.decode(str));
String jobTitleResponseModelToJson(JobTitleResponseModel data) =>
    json.encode(data.toJson());

class JobTitleResponseModel {
  JobTitleResponseModel({
    bool? status,
    String? message,
    List<JobTitleModel>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  JobTitleResponseModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(JobTitleModel.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<JobTitleModel>? _data;

  bool? get status => _status;
  String? get message => _message;
  List<JobTitleModel>? get data => _data;

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
