import 'dart:convert';

/// id : "1846"
/// set_id : "128"
/// type : "choose"
/// question : "Nepal ko janaganana 2068 ko nara ke thiyo?"
/// option_a : "Kohi nachhutaun kohi nadohoriun"
/// option_b : "Nadohoriun   kohi"
/// option_c : "Kohi nadohoriun"
/// option_d : "Kohi nachhutaun"
/// answer : "a"
/// paragraph : ""

QuestionModel questionsFromJson(String str) =>
    QuestionModel.fromJson(json.decode(str));
String questionsToJson(QuestionModel data) => json.encode(data.toJson());

class QuestionModel {
  QuestionModel({
    String? id,
    String? setId,
    String? type,
    String? question,
    String? optionA,
    String? optionB,
    String? optionC,
    String? optionD,
    String? answer,
    String? paragraph,
  }) {
    _id = id;
    _setId = setId;
    _type = type;
    _question = question;
    _optionA = optionA;
    _optionB = optionB;
    _optionC = optionC;
    _optionD = optionD;
    _answer = answer;
    _paragraph = paragraph;
  }

  QuestionModel.fromJson(dynamic json) {
    _id = json['id'];
    _setId = json['set_id'];
    _type = json['type'];
    _question = json['question'];
    _optionA = json['option_a'];
    _optionB = json['option_b'];
    _optionC = json['option_c'];
    _optionD = json['option_d'];
    _answer = json['answer'];
    _paragraph = json['paragraph'];
  }
  String? _id;
  String? _setId;
  String? _type;
  String? _question;
  String? _optionA;
  String? _optionB;
  String? _optionC;
  String? _optionD;
  String? _answer;
  String? _paragraph;
  QuestionModel copyWith({
    String? id,
    String? setId,
    String? type,
    String? question,
    String? optionA,
    String? optionB,
    String? optionC,
    String? optionD,
    String? answer,
    String? paragraph,
  }) =>
      QuestionModel(
        id: id ?? _id,
        setId: setId ?? _setId,
        type: type ?? _type,
        question: question ?? _question,
        optionA: optionA ?? _optionA,
        optionB: optionB ?? _optionB,
        optionC: optionC ?? _optionC,
        optionD: optionD ?? _optionD,
        answer: answer ?? _answer,
        paragraph: paragraph ?? _paragraph,
      );
  String? get id => _id;
  String? get setId => _setId;
  String? get type => _type;
  String? get question => _question;
  String? get optionA => _optionA;
  String? get optionB => _optionB;
  String? get optionC => _optionC;
  String? get optionD => _optionD;
  String? get answer => _answer;
  String? get paragraph => _paragraph;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['set_id'] = _setId;
    map['type'] = _type;
    map['question'] = _question;
    map['option_a'] = _optionA;
    map['option_b'] = _optionB;
    map['option_c'] = _optionC;
    map['option_d'] = _optionD;
    map['answer'] = _answer;
    map['paragraph'] = _paragraph;
    return map;
  }
}
