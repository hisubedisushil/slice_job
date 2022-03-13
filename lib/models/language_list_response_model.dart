import 'dart:convert';

import 'language_model.dart';

LanguageListResponseModel languageListResponseModelFromJson(String str) =>
    LanguageListResponseModel.fromJson(json.decode(str));
String languageListResponseModelToJson(LanguageListResponseModel data) =>
    json.encode(data.toJson());

class LanguageListResponseModel {
  LanguageListResponseModel({
    bool? status,
    String? message,
    List<LanguageModel>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  LanguageListResponseModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(LanguageModel.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<LanguageModel>? _data;

  bool? get status => _status;
  String? get message => _message;
  List<LanguageModel>? get data => _data;

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
