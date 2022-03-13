import 'dart:convert';

import 'certificate_model.dart';

CertificateListResponseModel certificateListResponseModelFromJson(String str) =>
    CertificateListResponseModel.fromJson(json.decode(str));
String certificateListResponseModelToJson(CertificateListResponseModel data) =>
    json.encode(data.toJson());

class CertificateListResponseModel {
  CertificateListResponseModel({
    bool? status,
    String? message,
    List<CertificateModel>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  CertificateListResponseModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(CertificateModel.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<CertificateModel>? _data;

  bool? get status => _status;
  String? get message => _message;
  List<CertificateModel>? get data => _data;

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
