import 'dart:convert';

import 'company_model.dart';

CompanyResponseModel companyResponseModelFromJson(String str) =>
    CompanyResponseModel.fromJson(json.decode(str));
String companyResponseModelToJson(CompanyResponseModel data) =>
    json.encode(data.toJson());

class CompanyResponseModel {
  CompanyResponseModel({
    bool? status,
    String? message,
    List<CompanyModel>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  CompanyResponseModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(CompanyModel.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<CompanyModel>? _data;

  bool? get status => _status;
  String? get message => _message;
  List<CompanyModel>? get data => _data;

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
