import 'dart:convert';

CertificateModel dataFromJson(String str) =>
    CertificateModel.fromJson(json.decode(str));
String dataToJson(CertificateModel data) => json.encode(data.toJson());

class CertificateModel {
  CertificateModel({
    String? id,
    String? userId,
    String? title,
    String? description,
    String? issueMonth,
    String? issueYear,
    String? expireMonth,
    String? expireYear,
    String? updateDate,
  }) {
    _id = id;
    _userId = userId;
    _title = title;
    _description = description;
    _issueMonth = issueMonth;
    _issueYear = issueYear;
    _expireMonth = expireMonth;
    _expireYear = expireYear;
    _updateDate = updateDate;
  }

  CertificateModel.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _title = json['title'];
    _description = json['description'];
    _issueMonth = json['issue_month'];
    _issueYear = json['issue_year'];
    _expireMonth = json['expire_month'];
    _expireYear = json['expire_year'];
    _updateDate = json['update_date'];
  }
  String? _id;
  String? _userId;
  String? _title;
  String? _description;
  String? _issueMonth;
  String? _issueYear;
  String? _expireMonth;
  String? _expireYear;
  String? _updateDate;

  String? get id => _id;
  String? get userId => _userId;
  String? get title => _title;
  String? get description => _description;
  String? get issueMonth => _issueMonth;
  String? get issueYear => _issueYear;
  String? get expireMonth => _expireMonth;
  String? get expireYear => _expireYear;
  String? get updateDate => _updateDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['title'] = _title;
    map['description'] = _description;
    map['issue_month'] = _issueMonth;
    map['issue_year'] = _issueYear;
    map['expire_month'] = _expireMonth;
    map['expire_year'] = _expireYear;
    map['update_date'] = _updateDate;
    return map;
  }
}
