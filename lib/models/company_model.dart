import 'dart:convert';

CompanyModel companyModelFromJson(String str) =>
    CompanyModel.fromJson(json.decode(str));
String companyModelToJson(CompanyModel data) => json.encode(data.toJson());

class CompanyModel {
  CompanyModel({
    String? id,
    String? name,
    String? address,
    String? phone,
    String? email,
    String? website,
    String? description,
    String? shortDesc,
    String? info,
    String? photo,
  }) {
    _id = id;
    _name = name;
    _address = address;
    _phone = phone;
    _email = email;
    _website = website;
    _description = description;
    _shortDesc = shortDesc;
    _info = info;
    _photo = photo;
  }

  CompanyModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _address = json['address'];
    _phone = json['phone'];
    _email = json['email'];
    _website = json['website'];
    _description = json['description'];
    _shortDesc = json['short_desc'];
    _info = json['info'];
    _photo = json['photo'];
  }
  String? _id;
  String? _name;
  String? _address;
  String? _phone;
  String? _email;
  String? _website;
  String? _description;
  String? _shortDesc;
  String? _info;
  String? _photo;

  String? get id => _id;
  String? get name => _name;
  String? get address => _address;
  String? get phone => _phone;
  String? get email => _email;
  String? get website => _website;
  String? get description => _description;
  String? get shortDesc => _shortDesc;
  String? get info => _info;
  String? get photo => _photo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['address'] = _address;
    map['phone'] = _phone;
    map['email'] = _email;
    map['website'] = _website;
    map['description'] = _description;
    map['short_desc'] = _shortDesc;
    map['info'] = _info;
    map['photo'] = _photo;
    return map;
  }
}
