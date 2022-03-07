import 'dart:convert';

JobCategoryModel dataFromJson(String str) =>
    JobCategoryModel.fromJson(json.decode(str));
String dataToJson(JobCategoryModel data) => json.encode(data.toJson());

class JobCategoryModel {
  JobCategoryModel({
    String? id,
    String? type,
    String? name,
    String? status,
  }) {
    _id = id;
    _type = type;
    _name = name;
    _status = status;
  }

  JobCategoryModel.fromJson(dynamic json) {
    _id = json['id'];
    _type = json['type'];
    _name = json['name'];
    _status = json['status'];
  }
  String? _id;
  String? _type;
  String? _name;
  String? _status;

  String? get id => _id;
  String? get type => _type;
  String? get name => _name;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['type'] = _type;
    map['name'] = _name;
    map['status'] = _status;
    return map;
  }
}
