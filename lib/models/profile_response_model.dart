import 'dart:convert';

import 'profile_model.dart';

ProfileResponseModel profileResponseModelFromJson(String str) =>
    ProfileResponseModel.fromJson(json.decode(str));
String profileResponseModelToJson(ProfileResponseModel data) =>
    json.encode(data.toJson());

class ProfileResponseModel {
  ProfileResponseModel({
    bool? status,
    String? message,
    ProfileModel? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  ProfileResponseModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? ProfileModel.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  ProfileModel? _data;

  bool? get status => _status;
  String? get message => _message;
  ProfileModel? get data => _data;

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
