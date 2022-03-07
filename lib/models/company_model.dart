import 'dart:convert';

CompanyModel companyFromJson(String str) =>
    CompanyModel.fromJson(json.decode(str));
String companyToJson(CompanyModel data) => json.encode(data.toJson());

class CompanyModel {
  CompanyModel({
    String? id,
    String? name,
    String? address,
    String? photo,
  }) {
    _id = id;
    _name = name;
    _address = address;
    _photo = photo;
  }

  CompanyModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _address = json['address'];
    _photo = json['photo'];
  }
  String? _id;
  String? _name;
  String? _address;
  String? _photo;

  String? get id => _id;
  String? get name => _name;
  String? get address => _address;
  String? get photo => _photo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['address'] = _address;
    map['photo'] = _photo;
    return map;
  }
}
