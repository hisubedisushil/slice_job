import 'dart:convert';

import 'blog_category_model.dart';

BlogCategoriesResponseModel blogCategoriesResponseModelFromJson(String str) =>
    BlogCategoriesResponseModel.fromJson(json.decode(str));
String blogCategoriesResponseModelToJson(BlogCategoriesResponseModel data) =>
    json.encode(data.toJson());

class BlogCategoriesResponseModel {
  BlogCategoriesResponseModel({
    bool? status,
    String? message,
    List<BlogCategoryModel>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  BlogCategoriesResponseModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(BlogCategoryModel.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<BlogCategoryModel>? _data;

  bool? get status => _status;
  String? get message => _message;
  List<BlogCategoryModel>? get data => _data;

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
