import 'dart:convert';

import 'job_model.dart';

FeaturedJobsResponseModel featuresJobsResponseModelFromJson(String str) =>
    FeaturedJobsResponseModel.fromJson(json.decode(str));
String featuresJobsResponseModelToJson(FeaturedJobsResponseModel data) =>
    json.encode(data.toJson());

class FeaturedJobsResponseModel {
  FeaturedJobsResponseModel({
    bool? status,
    String? message,
    List<FeaturedJobData>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  FeaturedJobsResponseModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(FeaturedJobData.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<FeaturedJobData>? _data;

  bool? get status => _status;
  String? get message => _message;
  List<FeaturedJobData>? get data => _data;

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

FeaturedJobData dataFromJson(String str) =>
    FeaturedJobData.fromJson(json.decode(str));
String dataToJson(FeaturedJobData data) => json.encode(data.toJson());

class FeaturedJobData {
  FeaturedJobData({
    String? id,
    String? name,
    String? image,
    List<JobModel>? jobs,
  }) {
    _id = id;
    _name = name;
    _image = image;
    _jobs = jobs;
  }

  FeaturedJobData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _image = json['image'];
    if (json['jobs'] != null) {
      _jobs = [];
      json['jobs'].forEach((v) {
        _jobs?.add(JobModel.fromJson(v));
      });
    }
  }
  String? _id;
  String? _name;
  String? _image;
  List<JobModel>? _jobs;

  String? get id => _id;
  String? get name => _name;
  String? get image => _image;
  List<JobModel>? get jobs => _jobs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['image'] = _image;
    if (_jobs != null) {
      map['jobs'] = _jobs?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
