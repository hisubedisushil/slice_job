import 'dart:convert';

ExperienceModel dataFromJson(String str) =>
    ExperienceModel.fromJson(json.decode(str));
String dataToJson(ExperienceModel data) => json.encode(data.toJson());

class ExperienceModel {
  ExperienceModel({
    String? id,
    String? userId,
    String? jobTitle,
    String? company,
    String? location,
    String? fromMonth,
    String? fromYear,
    String? toMonth,
    String? toYear,
    String? workDescription,
    String? updateDate,
  }) {
    _id = id;
    _userId = userId;
    _jobTitle = jobTitle;
    _company = company;
    _location = location;
    _fromMonth = fromMonth;
    _fromYear = fromYear;
    _toMonth = toMonth;
    _toYear = toYear;
    _workDescription = workDescription;
    _updateDate = updateDate;
  }

  ExperienceModel.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _jobTitle = json['job_title'];
    _company = json['company'];
    _location = json['location'];
    _fromMonth = json['from_month'];
    _fromYear = json['from_year'];
    _toMonth = json['to_month'];
    _toYear = json['to_year'];
    _workDescription = json['work_description'];
    _updateDate = json['update_date'];
  }
  String? _id;
  String? _userId;
  String? _jobTitle;
  String? _company;
  String? _location;
  String? _fromMonth;
  String? _fromYear;
  String? _toMonth;
  String? _toYear;
  String? _workDescription;
  String? _updateDate;

  String? get id => _id;
  String? get userId => _userId;
  String? get jobTitle => _jobTitle;
  String? get company => _company;
  String? get location => _location;
  String? get fromMonth => _fromMonth;
  String? get fromYear => _fromYear;
  String? get toMonth => _toMonth;
  String? get toYear => _toYear;
  String? get workDescription => _workDescription;
  String? get updateDate => _updateDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['job_title'] = _jobTitle;
    map['company'] = _company;
    map['location'] = _location;
    map['from_month'] = _fromMonth;
    map['from_year'] = _fromYear;
    map['to_month'] = _toMonth;
    map['to_year'] = _toYear;
    map['work_description'] = _workDescription;
    map['update_date'] = _updateDate;
    return map;
  }
}
