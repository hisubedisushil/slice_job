import 'dart:convert';

import 'education_model.dart';

EducationListResponseModel educationListResponseModelFromJson(String str) =>
    EducationListResponseModel.fromJson(json.decode(str));
String educationListResponseModelToJson(EducationListResponseModel data) =>
    json.encode(data.toJson());

class EducationListResponseModel {
  EducationListResponseModel({
    bool? status,
    String? message,
    List<EducationModel>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  EducationListResponseModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(EducationModel.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<EducationModel>? _data;

  bool? get status => _status;
  String? get message => _message;
  List<EducationModel>? get data => _data;

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
