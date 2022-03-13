import 'dart:convert';

import 'training_model.dart';

TrainingListResponseModel trainingListResponseModelFromJson(String str) =>
    TrainingListResponseModel.fromJson(json.decode(str));
String trainingListResponseModelToJson(TrainingListResponseModel data) =>
    json.encode(data.toJson());

class TrainingListResponseModel {
  TrainingListResponseModel({
    bool? status,
    String? message,
    List<TrainingModel>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  TrainingListResponseModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(TrainingModel.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<TrainingModel>? _data;

  bool? get status => _status;
  String? get message => _message;
  List<TrainingModel>? get data => _data;

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
