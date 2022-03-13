import 'dart:convert';

import 'blog_model.dart';

BlogsResponseModel blogsResponseModelFromJson(String str) =>
    BlogsResponseModel.fromJson(json.decode(str));
String blogsResponseModelToJson(BlogsResponseModel data) =>
    json.encode(data.toJson());

class BlogsResponseModel {
  BlogsResponseModel({
    bool? status,
    String? message,
    String? total,
    String? page,
    List<BlogModel>? data,
  }) {
    _status = status;
    _message = message;
    _total = total;
    _page = page;
    _data = data;
  }

  BlogsResponseModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _total = json['total'];
    _page = json['page'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(BlogModel.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  String? _total;
  String? _page;
  List<BlogModel>? _data;

  bool? get status => _status;
  String? get message => _message;
  String? get total => _total;
  String? get page => _page;
  List<BlogModel>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['total'] = _total;
    map['page'] = _page;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
