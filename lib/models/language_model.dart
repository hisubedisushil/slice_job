import 'dart:convert';

LanguageModel dataFromJson(String str) =>
    LanguageModel.fromJson(json.decode(str));
String dataToJson(LanguageModel data) => json.encode(data.toJson());

class LanguageModel {
  LanguageModel({
    String? id,
    String? userId,
    String? language,
    String? level,
    String? updateDate,
  }) {
    _id = id;
    _userId = userId;
    _language = language;
    _level = level;
    _updateDate = updateDate;
  }

  LanguageModel.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _language = json['language'];
    _level = json['level'];
    _updateDate = json['update_date'];
  }
  String? _id;
  String? _userId;
  String? _language;
  String? _level;
  String? _updateDate;

  String? get id => _id;
  String? get userId => _userId;
  String? get language => _language;
  String? get level => _level;
  String? get updateDate => _updateDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['language'] = _language;
    map['level'] = _level;
    map['update_date'] = _updateDate;
    return map;
  }
}
