import 'dart:convert';

JobTitleModel dataFromJson(String str) =>
    JobTitleModel.fromJson(json.decode(str));
String dataToJson(JobTitleModel data) => json.encode(data.toJson());

class JobTitleModel {
  JobTitleModel({
    String? id,
    String? categoryId,
    String? title,
    String? status,
  }) {
    _id = id;
    _categoryId = categoryId;
    _title = title;
    _status = status;
  }

  JobTitleModel.fromJson(dynamic json) {
    _id = json['id'];
    _categoryId = json['category_id'];
    _title = json['title'];
    _status = json['status'];
  }
  String? _id;
  String? _categoryId;
  String? _title;
  String? _status;

  String? get id => _id;
  String? get categoryId => _categoryId;
  String? get title => _title;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['category_id'] = _categoryId;
    map['title'] = _title;
    map['status'] = _status;
    return map;
  }
}
