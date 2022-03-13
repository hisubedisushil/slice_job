import 'dart:convert';

import 'experience_model.dart';

WorkExperienceListResponseModel workExperienceListResponseModelFromJson(
        String str) =>
    WorkExperienceListResponseModel.fromJson(json.decode(str));
String workExperienceListResponseModelToJson(
        WorkExperienceListResponseModel data) =>
    json.encode(data.toJson());

class WorkExperienceListResponseModel {
  WorkExperienceListResponseModel({
    bool? status,
    String? message,
    List<ExperienceModel>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  WorkExperienceListResponseModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ExperienceModel.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<ExperienceModel>? _data;

  bool? get status => _status;
  String? get message => _message;
  List<ExperienceModel>? get data => _data;

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
