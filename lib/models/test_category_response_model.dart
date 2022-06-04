import 'dart:convert';

import 'test_category_model.dart';

/// status : true
/// message : "Test Category Listed Successfully."
/// data : [{"id":"73","type":"Test","name":"General Knowledge","slug":"general-knowledge","description":"","image":"","meta_title":"","meta_keywords":"","meta_description":"","status":"active","test_field":"test"},{"id":"107","type":"Test","name":"MBA Case","slug":"mba-case","description":null,"image":null,"meta_title":null,"meta_keywords":null,"meta_description":null,"status":"active","test_field":"test"},{"id":"108","type":"Test","name":"MBA Case Study","slug":"mba-case-study","description":null,"image":null,"meta_title":null,"meta_keywords":null,"meta_description":null,"status":"active","test_field":"test"},{"id":"110","type":"Test","name":"GMAT-VERBAL ABILITY","slug":"gmat-verbal-ability","description":null,"image":null,"meta_title":null,"meta_keywords":null,"meta_description":null,"status":"active","test_field":"test"},{"id":"111","type":"Test","name":"GMAT-QUANTITATIVE TEST","slug":"gmat-quantitative-test","description":null,"image":null,"meta_title":null,"meta_keywords":null,"meta_description":null,"status":"active","test_field":"test"},{"id":"112","type":"Test","name":"IFRS","slug":"ifrs","description":null,"image":null,"meta_title":null,"meta_keywords":null,"meta_description":null,"status":"active","test_field":"test"},{"id":"113","type":"Test","name":"GMAT- CRITICAL REASONING","slug":"gmat-critical-reasoning","description":null,"image":null,"meta_title":null,"meta_keywords":null,"meta_description":null,"status":"active","test_field":"test"},{"id":"114","type":"Test","name":"GMAT- Sentence Correction","slug":"gmat-sentenance-correction","description":null,"image":null,"meta_title":null,"meta_keywords":null,"meta_description":null,"status":"active","test_field":"test"},{"id":"115","type":"Test","name":"GMAT-Reading Comprehension","slug":"gmat-reading-ccomprehension","description":null,"image":null,"meta_title":null,"meta_keywords":null,"meta_description":null,"status":"active","test_field":"test"},{"id":"116","type":"Test","name":"GMAT-Problem Solving","slug":"gmat-problem-solving","description":null,"image":null,"meta_title":null,"meta_keywords":null,"meta_description":null,"status":"active","test_field":"test"},{"id":"118","type":"Test","name":"GMAT-Data Sufficiency","slug":"gmat-data-sufficiency","description":null,"image":null,"meta_title":null,"meta_keywords":null,"meta_description":null,"status":"active","test_field":"test"},{"id":"128","type":"Test","name":"Electrical Engineering","slug":"electrical-engineering","description":null,"image":null,"meta_title":null,"meta_keywords":null,"meta_description":null,"status":"active","test_field":"test"},{"id":"130","type":"Test","name":"Electronic and Communication Engineering","slug":"electronic-and-communication-engineering","description":null,"image":null,"meta_title":null,"meta_keywords":null,"meta_description":null,"status":"active","test_field":"test"},{"id":"131","type":"Test","name":"Computer Engineering","slug":"computer-engineering","description":null,"image":null,"meta_title":null,"meta_keywords":null,"meta_description":null,"status":"active","test_field":"test"},{"id":"134","type":"Test","name":"Human Resource Managemengt","slug":"human-resource-management","description":null,"image":null,"meta_title":null,"meta_keywords":null,"meta_description":null,"status":"active","test_field":"test"},{"id":"135","type":"Test","name":"English Grammer","slug":"english-grammer","description":null,"image":null,"meta_title":null,"meta_keywords":null,"meta_description":null,"status":"active","test_field":"test"},{"id":"136","type":"Test","name":"Marketing-Advertising","slug":"marketing-advertising","description":null,"image":null,"meta_title":null,"meta_keywords":null,"meta_description":null,"status":"active","test_field":"test"},{"id":"137","type":"Test","name":"Marketing-Branding","slug":"marketin-branding","description":null,"image":null,"meta_title":null,"meta_keywords":null,"meta_description":null,"status":"active","test_field":"test"},{"id":"138","type":"Test","name":"Business Development","slug":"business-development","description":null,"image":null,"meta_title":null,"meta_keywords":null,"meta_description":null,"status":"active","test_field":"test"},{"id":"139","type":"Test","name":"Business Etiquette","slug":"business-etiquette","description":null,"image":null,"meta_title":null,"meta_keywords":null,"meta_description":null,"status":"active","test_field":"test"},{"id":"140","type":"Test","name":"Business Solution","slug":"business-solution","description":null,"image":null,"meta_title":null,"meta_keywords":null,"meta_description":null,"status":"active","test_field":"test"},{"id":"141","type":"Test","name":"Business Plan","slug":"business-plan","description":null,"image":null,"meta_title":null,"meta_keywords":null,"meta_description":null,"status":"active","test_field":"test"},{"id":"142","type":"Test","name":"Marketing-Sales","slug":"marketing-sales","description":null,"image":null,"meta_title":null,"meta_keywords":null,"meta_description":null,"status":"active","test_field":"test"},{"id":"145","type":"Test","name":"Civil Engineering","slug":"civil-engineering","description":"","image":"","meta_title":"","meta_keywords":"","meta_description":"","status":"active","test_field":"test"},{"id":"155","type":"Test","name":"Loksewa Preparation Questions","slug":"loksewa-preparation-questions","description":null,"image":null,"meta_title":null,"meta_keywords":null,"meta_description":null,"status":"active","test_field":"test"},{"id":"161","type":"Test","name":"New Test MBA","slug":"new-test-mba","description":null,"image":null,"meta_title":null,"meta_keywords":null,"meta_description":null,"status":"active","test_field":"test"},{"id":"162","type":"Test","name":"Weekly Quiz","slug":"weekly-quiz","description":null,"image":null,"meta_title":null,"meta_keywords":null,"meta_description":null,"status":"active","test_field":"test"},{"id":"164","type":"Test","name":"Weekly Quiz March","slug":"weekly-quiz-march","description":null,"image":null,"meta_title":null,"meta_keywords":null,"meta_description":null,"status":"active","test_field":"test"}]

TestCategoryResponseModel testCategoryResponseModelFromJson(String str) =>
    TestCategoryResponseModel.fromJson(json.decode(str));
String testCategoryResponseModelToJson(TestCategoryResponseModel data) =>
    json.encode(data.toJson());

class TestCategoryResponseModel {
  TestCategoryResponseModel({
    bool? status,
    String? message,
    List<TestCategoryModel>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  TestCategoryResponseModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(TestCategoryModel.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<TestCategoryModel>? _data;
  TestCategoryResponseModel copyWith({
    bool? status,
    String? message,
    List<TestCategoryModel>? data,
  }) =>
      TestCategoryResponseModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  List<TestCategoryModel>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
