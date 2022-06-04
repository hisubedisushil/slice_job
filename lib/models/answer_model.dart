import 'dart:convert';

/// id : "1846"
/// qno : 1
/// question : "Nepal ko janaganana 2068 ko nara ke thiyo?"
/// answer : "a"
/// option : "a"
/// txt : "undefined"

AnswerModel entranceResultFromJson(String str) =>
    AnswerModel.fromJson(json.decode(str));
String entranceResultToJson(AnswerModel data) => json.encode(data.toJson());

class AnswerModel {
  AnswerModel({
    String? id,
    int? qno,
    String? question,
    String? answer,
    String? option,
    String? txt,
  }) {
    _id = id;
    _qno = qno;
    _question = question;
    _answer = answer;
    _option = option;
    _txt = txt;
  }

  AnswerModel.fromJson(dynamic json) {
    _id = json['id'];
    _qno = json['qno'];
    _question = json['question'];
    _answer = json['answer'];
    _option = json['option'];
    _txt = json['txt'];
  }
  String? _id;
  int? _qno;
  String? _question;
  String? _answer;
  String? _option;
  String? _txt;
  AnswerModel copyWith({
    String? id,
    int? qno,
    String? question,
    String? answer,
    String? option,
    String? txt,
  }) =>
      AnswerModel(
        id: id ?? _id,
        qno: qno ?? _qno,
        question: question ?? _question,
        answer: answer ?? _answer,
        option: option ?? _option,
        txt: txt ?? _txt,
      );
  String? get id => _id;
  int? get qno => _qno;
  String? get question => _question;
  String? get answer => _answer;
  String? get option => _option;
  String? get txt => _txt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['qno'] = _qno;
    map['question'] = _question;
    map['answer'] = _answer;
    map['option'] = _option;
    map['txt'] = _txt;
    return map;
  }
}
