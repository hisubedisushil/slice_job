import 'dart:convert';

import 'job_type_model.dart';

JobTypesResponseModel jobTypesResponseModelFromJson(String str) =>
    JobTypesResponseModel.fromJson(json.decode(str));
String jobTypesResponseModelToJson(JobTypesResponseModel data) =>
    json.encode(data.toJson());

class JobTypesResponseModel {
  JobTypesResponseModel({
    bool? status,
    String? message,
    List<JobTypeModel>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  JobTypesResponseModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(JobTypeModel.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<JobTypeModel>? _data;

  bool? get status => _status;
  String? get message => _message;
  List<JobTypeModel>? get data => _data;

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
