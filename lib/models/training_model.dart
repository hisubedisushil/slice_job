import 'dart:convert';

TrainingModel dataFromJson(String str) =>
    TrainingModel.fromJson(json.decode(str));
String dataToJson(TrainingModel data) => json.encode(data.toJson());

class TrainingModel {
  TrainingModel({
    String? id,
    String? userId,
    String? title,
    String? startMonth,
    String? startYear,
    String? endMonth,
    String? endYear,
    String? updateDate,
  }) {
    _id = id;
    _userId = userId;
    _title = title;
    _startMonth = startMonth;
    _startYear = startYear;
    _endMonth = endMonth;
    _endYear = endYear;
    _updateDate = updateDate;
  }

  TrainingModel.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _title = json['title'];
    _startMonth = json['start_month'];
    _startYear = json['start_year'];
    _endMonth = json['end_month'];
    _endYear = json['end_year'];
    _updateDate = json['update_date'];
  }
  String? _id;
  String? _userId;
  String? _title;
  String? _startMonth;
  String? _startYear;
  String? _endMonth;
  String? _endYear;
  String? _updateDate;

  String? get id => _id;
  String? get userId => _userId;
  String? get title => _title;
  String? get startMonth => _startMonth;
  String? get startYear => _startYear;
  String? get endMonth => _endMonth;
  String? get endYear => _endYear;
  String? get updateDate => _updateDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['title'] = _title;
    map['start_month'] = _startMonth;
    map['start_year'] = _startYear;
    map['end_month'] = _endMonth;
    map['end_year'] = _endYear;
    map['update_date'] = _updateDate;
    return map;
  }
}
