import 'dart:convert';

EducationModel dataFromJson(String str) =>
    EducationModel.fromJson(json.decode(str));
String dataToJson(EducationModel data) => json.encode(data.toJson());

class EducationModel {
  EducationModel({
    String? id,
    String? userId,
    String? degree,
    String? field,
    String? institution,
    String? country,
    String? city,
    String? startMonth,
    String? startYear,
    String? endMonth,
    String? endYear,
    String? updateDate,
  }) {
    _id = id;
    _userId = userId;
    _degree = degree;
    _field = field;
    _institution = institution;
    _country = country;
    _city = city;
    _startMonth = startMonth;
    _startYear = startYear;
    _endMonth = endMonth;
    _endYear = endYear;
    _updateDate = updateDate;
  }

  EducationModel.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _degree = json['degree'];
    _field = json['field'];
    _institution = json['institution'];
    _country = json['country'];
    _city = json['city'];
    _startMonth = json['start_month'];
    _startYear = json['start_year'];
    _endMonth = json['end_month'];
    _endYear = json['end_year'];
    _updateDate = json['update_date'];
  }
  String? _id;
  String? _userId;
  String? _degree;
  String? _field;
  String? _institution;
  String? _country;
  String? _city;
  String? _startMonth;
  String? _startYear;
  String? _endMonth;
  String? _endYear;
  String? _updateDate;

  String? get id => _id;
  String? get userId => _userId;
  String? get degree => _degree;
  String? get field => _field;
  String? get institution => _institution;
  String? get country => _country;
  String? get city => _city;
  String? get startMonth => _startMonth;
  String? get startYear => _startYear;
  String? get endMonth => _endMonth;
  String? get endYear => _endYear;
  String? get updateDate => _updateDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['degree'] = _degree;
    map['field'] = _field;
    map['institution'] = _institution;
    map['country'] = _country;
    map['city'] = _city;
    map['start_month'] = _startMonth;
    map['start_year'] = _startYear;
    map['end_month'] = _endMonth;
    map['end_year'] = _endYear;
    map['update_date'] = _updateDate;
    return map;
  }
}
