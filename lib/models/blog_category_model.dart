import 'dart:convert';

BlogCategoryModel dataFromJson(String str) =>
    BlogCategoryModel.fromJson(json.decode(str));
String dataToJson(BlogCategoryModel data) => json.encode(data.toJson());

class BlogCategoryModel {
  BlogCategoryModel({
    String? id,
    String? parentId,
    String? catName,
    String? catSlug,
    String? date,
    String? status,
    String? testField,
  }) {
    _id = id;
    _parentId = parentId;
    _catName = catName;
    _catSlug = catSlug;
    _date = date;
    _status = status;
    _testField = testField;
  }

  BlogCategoryModel.fromJson(dynamic json) {
    _id = json['id'];
    _parentId = json['parent_id'];
    _catName = json['cat_name'];
    _catSlug = json['cat_slug'];
    _date = json['date'];
    _status = json['status'];
    _testField = json['test_field'];
  }
  String? _id;
  String? _parentId;
  String? _catName;
  String? _catSlug;
  String? _date;
  String? _status;
  String? _testField;

  String? get id => _id;
  String? get parentId => _parentId;
  String? get catName => _catName;
  String? get catSlug => _catSlug;
  String? get date => _date;
  String? get status => _status;
  String? get testField => _testField;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['parent_id'] = _parentId;
    map['cat_name'] = _catName;
    map['cat_slug'] = _catSlug;
    map['date'] = _date;
    map['status'] = _status;
    map['test_field'] = _testField;
    return map;
  }
}
