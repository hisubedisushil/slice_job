import 'dart:convert';

import 'cv_basic_model.dart';

CvBasicAllResponseModel cvBasicAllResponseModelFromJson(String str) =>
    CvBasicAllResponseModel.fromJson(json.decode(str));
String cvBasicAllResponseModelToJson(CvBasicAllResponseModel data) =>
    json.encode(data.toJson());

class CvBasicAllResponseModel {
  CvBasicAllResponseModel({
    bool? status,
    String? message,
    CVBasicModel? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  CvBasicAllResponseModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? CVBasicModel.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  CVBasicModel? _data;

  bool? get status => _status;
  String? get message => _message;
  CVBasicModel? get data => _data;

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
