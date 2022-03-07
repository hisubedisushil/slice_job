import 'dart:convert';

CountryModel dataFromJson(String str) =>
    CountryModel.fromJson(json.decode(str));
String dataToJson(CountryModel data) => json.encode(data.toJson());

class CountryModel {
  CountryModel({
    String? id,
    String? sortname,
    String? name,
    String? countryCode,
    String? status,
  }) {
    _id = id;
    _sortname = sortname;
    _name = name;
    _countryCode = countryCode;
    _status = status;
  }

  CountryModel.fromJson(dynamic json) {
    _id = json['id'];
    _sortname = json['sortname'];
    _name = json['name'];
    _countryCode = json['country_code'];
    _status = json['status'];
  }
  String? _id;
  String? _sortname;
  String? _name;
  String? _countryCode;
  String? _status;

  String? get id => _id;
  String? get sortname => _sortname;
  String? get name => _name;
  String? get countryCode => _countryCode;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['sortname'] = _sortname;
    map['name'] = _name;
    map['country_code'] = _countryCode;
    map['status'] = _status;
    return map;
  }
}
