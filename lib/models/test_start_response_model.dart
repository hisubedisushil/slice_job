import 'dart:convert';

import 'question_model.dart';
import 'set_model.dart';

/// status : true
/// message : "Test Started Successfully."
/// data : {"set":{"id":"128","set_name":"Loksewa Exam Question","category_id":"73","category_name":"General Knowledge","total_question":"5","exam_duration":300},"questions":[{"id":"1846","set_id":"128","type":"choose","question":"Nepal ko janaganana 2068 ko nara ke thiyo?","option_a":"Kohi nachhutaun kohi nadohoriun","option_b":"Nadohoriun   kohi","option_c":"Kohi nadohoriun","option_d":"Kohi nachhutaun","answer":"a","paragraph":""},{"id":"1847","set_id":"128","type":"choose","question":"Kuna srilakali kriketarako vivahako kagajama tyanhaka rastrapati mahendra rajapaksale saksika rupama hastaksara gareka chhan?","option_a":"Angilo myathyuja","option_b":"Sanad Jaya Surya","option_c":"Angelo Metheus","option_d":"Maila Jayabardena","answer":"a","paragraph":""},{"id":"1848","set_id":"128","type":"choose","question":"Nepal &amp;nbsp;sarakarale janataka gunasa sunna suru garekohelo sarakara ko nisulka phona nan kati ho?","option_a":"1111","option_b":"100","option_c":"977","option_d":"101","answer":"a","paragraph":""},{"id":"1849","set_id":"128","type":"choose","question":"&amp;nbsp;Aduva utpadanama Nepal &amp;nbsp;bisvoko kuna sthanama parchha?","option_a":"CHautho sthanama","option_b":"Tesro","option_c":"Doshro","option_d":"Pahilo","answer":"a","paragraph":""},{"id":"1850","set_id":"128","type":"choose","question":"Barsako matra napne yantralai ke bhaninchha?","option_a":"Rena gaja","option_b":"Thermostat","option_c":"thermoreading","option_d":"pressure gauze","answer":"a","paragraph":""}]}

TestStartResponseModel testStartResponseModelFromJson(String str) =>
    TestStartResponseModel.fromJson(json.decode(str));
String testStartResponseModelToJson(TestStartResponseModel data) =>
    json.encode(data.toJson());

class TestStartResponseModel {
  TestStartResponseModel({
    bool? status,
    String? message,
    TestData? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  TestStartResponseModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? TestData.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  TestData? _data;
  TestStartResponseModel copyWith({
    bool? status,
    String? message,
    TestData? data,
  }) =>
      TestStartResponseModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  TestData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

/// set : {"id":"128","set_name":"Loksewa Exam Question","category_id":"73","category_name":"General Knowledge","total_question":"5","exam_duration":300}
/// questions : [{"id":"1846","set_id":"128","type":"choose","question":"Nepal ko janaganana 2068 ko nara ke thiyo?","option_a":"Kohi nachhutaun kohi nadohoriun","option_b":"Nadohoriun   kohi","option_c":"Kohi nadohoriun","option_d":"Kohi nachhutaun","answer":"a","paragraph":""},{"id":"1847","set_id":"128","type":"choose","question":"Kuna srilakali kriketarako vivahako kagajama tyanhaka rastrapati mahendra rajapaksale saksika rupama hastaksara gareka chhan?","option_a":"Angilo myathyuja","option_b":"Sanad Jaya Surya","option_c":"Angelo Metheus","option_d":"Maila Jayabardena","answer":"a","paragraph":""},{"id":"1848","set_id":"128","type":"choose","question":"Nepal &amp;nbsp;sarakarale janataka gunasa sunna suru garekohelo sarakara ko nisulka phona nan kati ho?","option_a":"1111","option_b":"100","option_c":"977","option_d":"101","answer":"a","paragraph":""},{"id":"1849","set_id":"128","type":"choose","question":"&amp;nbsp;Aduva utpadanama Nepal &amp;nbsp;bisvoko kuna sthanama parchha?","option_a":"CHautho sthanama","option_b":"Tesro","option_c":"Doshro","option_d":"Pahilo","answer":"a","paragraph":""},{"id":"1850","set_id":"128","type":"choose","question":"Barsako matra napne yantralai ke bhaninchha?","option_a":"Rena gaja","option_b":"Thermostat","option_c":"thermoreading","option_d":"pressure gauze","answer":"a","paragraph":""}]

TestData dataFromJson(String str) => TestData.fromJson(json.decode(str));
String dataToJson(TestData data) => json.encode(data.toJson());

class TestData {
  TestData({
    SetModel? set,
    List<QuestionModel>? questions,
  }) {
    _set = set;
    _questions = questions;
  }

  TestData.fromJson(dynamic json) {
    _set = json['set'] != null ? SetModel.fromJson(json['set']) : null;
    if (json['questions'] != null) {
      _questions = [];
      json['questions'].forEach((v) {
        _questions?.add(QuestionModel.fromJson(v));
      });
    }
  }
  SetModel? _set;
  List<QuestionModel>? _questions;
  TestData copyWith({
    SetModel? set,
    List<QuestionModel>? questions,
  }) =>
      TestData(
        set: set ?? _set,
        questions: questions ?? _questions,
      );
  SetModel? get set => _set;
  List<QuestionModel>? get questions => _questions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_set != null) {
      map['set'] = _set?.toJson();
    }
    if (_questions != null) {
      map['questions'] = _questions?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
