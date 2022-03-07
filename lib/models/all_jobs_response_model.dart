import 'dart:convert';

import 'job_model.dart';

AllJobsResponseModel allJobsResponseModelFromJson(String str) =>
    AllJobsResponseModel.fromJson(json.decode(str));
String allJobsResponseModelToJson(AllJobsResponseModel data) =>
    json.encode(data.toJson());

class AllJobsResponseModel {
  AllJobsResponseModel({
    bool? status,
    String? message,
    String? total,
    String? page,
    List<JobModel>? data,
  }) {
    _status = status;
    _message = message;
    _total = total;
    _page = page;
    _data = data;
  }

  AllJobsResponseModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _total = json['total'];
    _page = json['page'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(JobModel.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  String? _total;
  String? _page;
  List<JobModel>? _data;

  bool? get status => _status;
  String? get message => _message;
  String? get total => _total;
  String? get page => _page;
  List<JobModel>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['total'] = _total;
    map['page'] = _page;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
