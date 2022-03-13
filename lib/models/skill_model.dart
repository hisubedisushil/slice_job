import 'dart:convert';

SkillModel dataFromJson(String str) => SkillModel.fromJson(json.decode(str));
String dataToJson(SkillModel data) => json.encode(data.toJson());

class SkillModel {
  SkillModel({
    String? id,
    String? userId,
    String? skill,
    String? level,
    String? updateDate,
  }) {
    _id = id;
    _userId = userId;
    _skill = skill;
    _level = level;
    _updateDate = updateDate;
  }

  SkillModel.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _skill = json['skill'];
    _level = json['level'];
    _updateDate = json['update_date'];
  }
  String? _id;
  String? _userId;
  String? _skill;
  String? _level;
  String? _updateDate;

  String? get id => _id;
  String? get userId => _userId;
  String? get skill => _skill;
  String? get level => _level;
  String? get updateDate => _updateDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['skill'] = _skill;
    map['level'] = _level;
    map['update_date'] = _updateDate;
    return map;
  }
}
