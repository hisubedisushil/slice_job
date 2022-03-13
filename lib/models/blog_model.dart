import 'dart:convert';

BlogModel blogModelFromJson(String str) => BlogModel.fromJson(json.decode(str));
String blogModelToJson(BlogModel data) => json.encode(data.toJson());

class BlogModel {
  BlogModel({
    String? id,
    String? title,
    String? subTitle,
    String? shortDesc,
    String? detailDesc,
    String? slug,
    String? image,
    String? type,
    String? articleBy,
    String? byDesc,
    String? addDate,
    String? categoryId,
    String? categoryName,
  }) {
    _id = id;
    _title = title;
    _subTitle = subTitle;
    _shortDesc = shortDesc;
    _detailDesc = detailDesc;
    _slug = slug;
    _image = image;
    _type = type;
    _articleBy = articleBy;
    _byDesc = byDesc;
    _addDate = addDate;
    _categoryId = categoryId;
    _categoryName = categoryName;
  }

  BlogModel.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _subTitle = json['sub_title'];
    _shortDesc = json['short_desc'];
    _detailDesc = json['detail_desc'];
    _slug = json['slug'];
    _image = json['image'];
    _type = json['type'];
    _articleBy = json['article_by'];
    _byDesc = json['by_desc'];
    _addDate = json['add_date'];
    _categoryId = json['category_id'];
    _categoryName = json['category_name'];
  }
  String? _id;
  String? _title;
  String? _subTitle;
  String? _shortDesc;
  String? _detailDesc;
  String? _slug;
  String? _image;
  String? _type;
  String? _articleBy;
  String? _byDesc;
  String? _addDate;
  String? _categoryId;
  String? _categoryName;

  String? get id => _id;
  String? get title => _title;
  String? get subTitle => _subTitle;
  String? get shortDesc => _shortDesc;
  String? get detailDesc => _detailDesc;
  String? get slug => _slug;
  String? get image => _image;
  String? get type => _type;
  String? get articleBy => _articleBy;
  String? get byDesc => _byDesc;
  String? get addDate => _addDate;
  String? get categoryId => _categoryId;
  String? get categoryName => _categoryName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['sub_title'] = _subTitle;
    map['short_desc'] = _shortDesc;
    map['detail_desc'] = _detailDesc;
    map['slug'] = _slug;
    map['image'] = _image;
    map['type'] = _type;
    map['article_by'] = _articleBy;
    map['by_desc'] = _byDesc;
    map['add_date'] = _addDate;
    map['category_id'] = _categoryId;
    map['category_name'] = _categoryName;
    return map;
  }
}
