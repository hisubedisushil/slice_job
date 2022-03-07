import 'dart:convert';

import 'country_model.dart';

CountriesResponseModel countriesResponseModelFromJson(String str) =>
    CountriesResponseModel.fromJson(json.decode(str));
String countriesResponseModelToJson(CountriesResponseModel data) =>
    json.encode(data.toJson());

class CountriesResponseModel {
  CountriesResponseModel({
    bool? status,
    String? message,
    List<CountryModel>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  CountriesResponseModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(CountryModel.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<CountryModel>? _data;

  bool? get status => _status;
  String? get message => _message;
  List<CountryModel>? get data => _data;

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
