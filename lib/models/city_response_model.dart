import 'dart:convert';

import 'city_model.dart';

CityResponseModel cityResponseModelFromJson(String str) =>
    CityResponseModel.fromJson(json.decode(str));
String cityResponseModelToJson(CityResponseModel data) =>
    json.encode(data.toJson());

class CityResponseModel {
  CityResponseModel({
    bool? status,
    String? message,
    List<CityModel>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  CityResponseModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(CityModel.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<CityModel>? _data;

  bool? get status => _status;
  String? get message => _message;
  List<CityModel>? get data => _data;

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
