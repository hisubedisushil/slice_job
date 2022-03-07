import 'dart:convert';

JobTypeModel dataFromJson(String str) =>
    JobTypeModel.fromJson(json.decode(str));
String dataToJson(JobTypeModel data) => json.encode(data.toJson());

class JobTypeModel {
  JobTypeModel({
    String? id,
    String? name,
    String? status,
  }) {
    _id = id;
    _name = name;
    _status = status;
  }

  JobTypeModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _status = json['status'];
  }
  String? _id;
  String? _name;
  String? _status;

  String? get id => _id;
  String? get name => _name;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['status'] = _status;
    return map;
  }
}
