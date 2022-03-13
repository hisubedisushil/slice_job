import 'dart:convert';

CityModel dataFromJson(String str) => CityModel.fromJson(json.decode(str));
String dataToJson(CityModel data) => json.encode(data.toJson());

class CityModel {
  CityModel({
    String? id,
    String? name,
    String? countryId,
  }) {
    _id = id;
    _name = name;
    _countryId = countryId;
  }

  CityModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _countryId = json['country_id'];
  }
  String? _id;
  String? _name;
  String? _countryId;

  String? get id => _id;
  String? get name => _name;
  String? get countryId => _countryId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['country_id'] = _countryId;
    return map;
  }
}
