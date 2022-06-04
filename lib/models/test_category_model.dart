import 'dart:convert';

/// id : "73"
/// type : "Test"
/// name : "General Knowledge"
/// slug : "general-knowledge"
/// description : ""
/// image : ""
/// meta_title : ""
/// meta_keywords : ""
/// meta_description : ""
/// status : "active"
/// test_field : "test"

TestCategoryModel dataFromJson(String str) =>
    TestCategoryModel.fromJson(json.decode(str));
String dataToJson(TestCategoryModel data) => json.encode(data.toJson());

class TestCategoryModel {
  TestCategoryModel({
    String? id,
    String? type,
    String? name,
    String? slug,
    String? description,
    String? image,
    String? metaTitle,
    String? metaKeywords,
    String? metaDescription,
    String? status,
    String? testField,
  }) {
    _id = id;
    _type = type;
    _name = name;
    _slug = slug;
    _description = description;
    _image = image;
    _metaTitle = metaTitle;
    _metaKeywords = metaKeywords;
    _metaDescription = metaDescription;
    _status = status;
    _testField = testField;
  }

  TestCategoryModel.fromJson(dynamic json) {
    _id = json['id'];
    _type = json['type'];
    _name = json['name'];
    _slug = json['slug'];
    _description = json['description'];
    _image = json['image'];
    _metaTitle = json['meta_title'];
    _metaKeywords = json['meta_keywords'];
    _metaDescription = json['meta_description'];
    _status = json['status'];
    _testField = json['test_field'];
  }
  String? _id;
  String? _type;
  String? _name;
  String? _slug;
  String? _description;
  String? _image;
  String? _metaTitle;
  String? _metaKeywords;
  String? _metaDescription;
  String? _status;
  String? _testField;
  TestCategoryModel copyWith({
    String? id,
    String? type,
    String? name,
    String? slug,
    String? description,
    String? image,
    String? metaTitle,
    String? metaKeywords,
    String? metaDescription,
    String? status,
    String? testField,
  }) =>
      TestCategoryModel(
        id: id ?? _id,
        type: type ?? _type,
        name: name ?? _name,
        slug: slug ?? _slug,
        description: description ?? _description,
        image: image ?? _image,
        metaTitle: metaTitle ?? _metaTitle,
        metaKeywords: metaKeywords ?? _metaKeywords,
        metaDescription: metaDescription ?? _metaDescription,
        status: status ?? _status,
        testField: testField ?? _testField,
      );
  String? get id => _id;
  String? get type => _type;
  String? get name => _name;
  String? get slug => _slug;
  String? get description => _description;
  String? get image => _image;
  String? get metaTitle => _metaTitle;
  String? get metaKeywords => _metaKeywords;
  String? get metaDescription => _metaDescription;
  String? get status => _status;
  String? get testField => _testField;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['type'] = _type;
    map['name'] = _name;
    map['slug'] = _slug;
    map['description'] = _description;
    map['image'] = _image;
    map['meta_title'] = _metaTitle;
    map['meta_keywords'] = _metaKeywords;
    map['meta_description'] = _metaDescription;
    map['status'] = _status;
    map['test_field'] = _testField;
    return map;
  }
}
