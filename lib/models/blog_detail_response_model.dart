import 'dart:convert';

import 'blog_model.dart';

BlogDetailResponseModel blogDetailResponseModelFromJson(String str) =>
    BlogDetailResponseModel.fromJson(json.decode(str));
String blogDetailResponseModelToJson(BlogDetailResponseModel data) =>
    json.encode(data.toJson());

class BlogDetailResponseModel {
  BlogDetailResponseModel({
    bool? status,
    String? message,
    BlogModel? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  BlogDetailResponseModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? BlogModel.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  BlogModel? _data;

  bool? get status => _status;
  String? get message => _message;
  BlogModel? get data => _data;

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
