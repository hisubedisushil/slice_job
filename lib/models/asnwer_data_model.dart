import 'dart:convert';

import 'package:slice_job/models/answer_model.dart';

/// category_id : "73"
/// entrance_set : "1"
/// quiz_key : "778FCD7A5CA2A730C"
/// entrance_result : [{"id":"1846","qno":1,"question":"Nepal ko janaganana 2068 ko nara ke thiyo?","answer":"a","option":"a","txt":"undefined"},{"id":"1847","qno":2,"question":"Kuna srilakali kriketarako vivahako kagajama tyanhaka rastrapati mahendra rajapaksale saksika rupama hastaksara gareka chhan?","answer":"a","option":"a","txt":"undefined"},{"id":"1848","qno":3,"question":"Nepal &nbsp;sarakarale janataka gunasa sunna suru garekohelo sarakara ko nisulka phona nan kati ho?","answer":"a","option":"d","txt":"undefined"},{"id":"1849","qno":4,"question":"&nbsp;Aduva utpadanama Nepal &nbsp;bisvoko kuna sthanama parchha?","answer":"a","option":"c","txt":"undefined"},{"id":"1850","qno":5,"question":"Barsako matra napne yantralai ke bhaninchha?","answer":"a","option":"b","txt":"undefined"}]
/// total_question : 5
/// total_score : 2
/// total_percent : 40

AnswerDataModel dataFromJson(String str) =>
    AnswerDataModel.fromJson(json.decode(str));
String dataToJson(AnswerDataModel data) => json.encode(data.toJson());

class AnswerDataModel {
  AnswerDataModel({
    String? categoryId,
    String? entranceSet,
    String? quizKey,
    List<AnswerModel>? answers,
    int? totalQuestion,
    int? totalScore,
    int? totalPercent,
  }) {
    _categoryId = categoryId;
    _entranceSet = entranceSet;
    _quizKey = quizKey;
    _answers = answers;
    _totalQuestion = totalQuestion;
    _totalScore = totalScore;
    _totalPercent = totalPercent;
  }

  AnswerDataModel.fromJson(dynamic json) {
    _categoryId = json['category_id'];
    _entranceSet = json['entrance_set'];
    _quizKey = json['quiz_key'];
    if (json['entrance_result'] != null) {
      _answers = [];
      json['entrance_result'].forEach((v) {
        _answers?.add(AnswerModel.fromJson(v));
      });
    }
    _totalQuestion = json['total_question'];
    _totalScore = json['total_score'];
    _totalPercent = json['total_percent'];
  }
  String? _categoryId;
  String? _entranceSet;
  String? _quizKey;
  List<AnswerModel>? _answers;
  int? _totalQuestion;
  int? _totalScore;
  int? _totalPercent;
  AnswerDataModel copyWith({
    String? categoryId,
    String? entranceSet,
    String? quizKey,
    List<AnswerModel>? answers,
    int? totalQuestion,
    int? totalScore,
    int? totalPercent,
  }) =>
      AnswerDataModel(
        categoryId: categoryId ?? _categoryId,
        entranceSet: entranceSet ?? _entranceSet,
        quizKey: quizKey ?? _quizKey,
        answers: answers ?? _answers,
        totalQuestion: totalQuestion ?? _totalQuestion,
        totalScore: totalScore ?? _totalScore,
        totalPercent: totalPercent ?? _totalPercent,
      );
  String? get categoryId => _categoryId;
  String? get entranceSet => _entranceSet;
  String? get quizKey => _quizKey;
  List<AnswerModel>? get answers => _answers;
  int? get totalQuestion => _totalQuestion;
  int? get totalScore => _totalScore;
  int? get totalPercent => _totalPercent;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['category_id'] = _categoryId;
    map['entrance_set'] = _entranceSet;
    map['quiz_key'] = _quizKey;
    if (_answers != null) {
      map['entrance_result'] = _answers?.map((v) => v.toJson()).toList();
    }
    map['total_question'] = _totalQuestion;
    map['total_score'] = _totalScore;
    map['total_percent'] = _totalPercent;
    return map;
  }
}
