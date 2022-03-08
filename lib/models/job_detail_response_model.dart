import 'dart:convert';

import 'job_detail_model.dart';

JobDetailResponseModel jobDetailResponseModelFromJson(String str) =>
    JobDetailResponseModel.fromJson(json.decode(str));
String jobDetailResponseModelToJson(JobDetailResponseModel data) =>
    json.encode(data.toJson());

class JobDetailResponseModel {
  JobDetailResponseModel({
    bool? status,
    String? message,
    JobDetailModel? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  JobDetailResponseModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? JobDetailModel.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  JobDetailModel? _data;

  bool? get status => _status;
  String? get message => _message;
  JobDetailModel? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}
