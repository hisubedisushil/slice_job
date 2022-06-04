import 'dart:convert';

import 'asnwer_data_model.dart';

/// status : true
/// message : "Test Finished Successfully."
/// data : {"category_id":"73","entrance_set":"1","quiz_key":"778FCD7A5CA2A730C","entrance_result":[{"id":"1846","qno":1,"question":"Nepal ko janaganana 2068 ko nara ke thiyo?","answer":"a","option":"a","txt":"undefined"},{"id":"1847","qno":2,"question":"Kuna srilakali kriketarako vivahako kagajama tyanhaka rastrapati mahendra rajapaksale saksika rupama hastaksara gareka chhan?","answer":"a","option":"a","txt":"undefined"},{"id":"1848","qno":3,"question":"Nepal &nbsp;sarakarale janataka gunasa sunna suru garekohelo sarakara ko nisulka phona nan kati ho?","answer":"a","option":"d","txt":"undefined"},{"id":"1849","qno":4,"question":"&nbsp;Aduva utpadanama Nepal &nbsp;bisvoko kuna sthanama parchha?","answer":"a","option":"c","txt":"undefined"},{"id":"1850","qno":5,"question":"Barsako matra napne yantralai ke bhaninchha?","answer":"a","option":"b","txt":"undefined"}],"total_question":5,"total_score":2,"total_percent":40}

TestFinishResponseModel testFinishResponseModelFromJson(String str) =>
    TestFinishResponseModel.fromJson(json.decode(str));
String testFinishResponseModelToJson(TestFinishResponseModel data) =>
    json.encode(data.toJson());

class TestFinishResponseModel {
  TestFinishResponseModel({
    bool? status,
    String? message,
    AnswerDataModel? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  TestFinishResponseModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data =
        json['data'] != null ? AnswerDataModel.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  AnswerDataModel? _data;
  TestFinishResponseModel copyWith({
    bool? status,
    String? message,
    AnswerDataModel? data,
  }) =>
      TestFinishResponseModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  AnswerDataModel? get data => _data;

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
