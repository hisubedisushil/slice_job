import 'dart:convert';

import 'skill_model.dart';

SkillListResponseModel skillListResponseModelFromJson(String str) =>
    SkillListResponseModel.fromJson(json.decode(str));
String skillListResponseModelToJson(SkillListResponseModel data) =>
    json.encode(data.toJson());

class SkillListResponseModel {
  SkillListResponseModel({
    bool? status,
    String? message,
    List<SkillModel>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  SkillListResponseModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(SkillModel.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<SkillModel>? _data;

  bool? get status => _status;
  String? get message => _message;
  List<SkillModel>? get data => _data;

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
