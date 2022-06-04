import 'dart:convert';

/// id : "128"
/// set_name : "Loksewa Exam Question"
/// category_id : "73"
/// category_name : "General Knowledge"
/// total_question : "5"
/// exam_duration : 300

SetModel setFromJson(String str) => SetModel.fromJson(json.decode(str));
String setToJson(SetModel data) => json.encode(data.toJson());

class SetModel {
  SetModel({
    String? id,
    String? setName,
    String? categoryId,
    String? categoryName,
    String? totalQuestion,
    int? examDuration,
  }) {
    _id = id;
    _setName = setName;
    _categoryId = categoryId;
    _categoryName = categoryName;
    _totalQuestion = totalQuestion;
    _examDuration = examDuration;
  }

  SetModel.fromJson(dynamic json) {
    _id = json['id'];
    _setName = json['set_name'];
    _categoryId = json['category_id'];
    _categoryName = json['category_name'];
    _totalQuestion = json['total_question'];
    _examDuration = json['exam_duration'];
  }
  String? _id;
  String? _setName;
  String? _categoryId;
  String? _categoryName;
  String? _totalQuestion;
  int? _examDuration;

  SetModel copyWith({
    String? id,
    String? setName,
    String? categoryId,
    String? categoryName,
    String? totalQuestion,
    int? examDuration,
  }) =>
      SetModel(
        id: id ?? _id,
        setName: setName ?? _setName,
        categoryId: categoryId ?? _categoryId,
        categoryName: categoryName ?? _categoryName,
        totalQuestion: totalQuestion ?? _totalQuestion,
        examDuration: examDuration ?? _examDuration,
      );
  String? get id => _id;
  String? get setName => _setName;
  String? get categoryId => _categoryId;
  String? get categoryName => _categoryName;
  String? get totalQuestion => _totalQuestion;
  int? get examDuration => _examDuration;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['set_name'] = _setName;
    map['category_id'] = _categoryId;
    map['category_name'] = _categoryName;
    map['total_question'] = _totalQuestion;
    map['exam_duration'] = _examDuration;
    return map;
  }
}
