import 'dart:convert';

ProfileModel dataFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));
String dataToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel({
    String? firstName,
    String? lastName,
    String? email,
    String? mobileNumber,
    String? gender,
    String? dob,
    String? qualification,
    String? experience,
    String? nationality,
    String? currCountry,
    String? currCity,
    String? photo,
    String? regDate,
    String? userType,
    String? isPremium,
    String? premiumStart,
    dynamic premiumEnd,
  }) {
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _mobileNumber = mobileNumber;
    _gender = gender;
    _dob = dob;
    _qualification = qualification;
    _experience = experience;
    _nationality = nationality;
    _currCountry = currCountry;
    _currCity = currCity;
    _photo = photo;
    _regDate = regDate;
    _userType = userType;
    _isPremium = isPremium;
    _premiumStart = premiumStart;
    _premiumEnd = premiumEnd;
  }

  ProfileModel.fromJson(dynamic json) {
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _email = json['email'];
    _mobileNumber = json['mobile_number'];
    _gender = json['gender'];
    _dob = json['dob'];
    _qualification = json['qualification'];
    _experience = json['experience'];
    _nationality = json['nationality'];
    _currCountry = json['curr_country'];
    _currCity = json['curr_city'];
    _photo = json['photo'];
    _regDate = json['reg_date'];
    _userType = json['user_type'];
    _isPremium = json['is_premium'];
    _premiumStart = json['premium_start'];
    _premiumEnd = json['premium_end'];
  }
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _mobileNumber;
  String? _gender;
  String? _dob;
  String? _qualification;
  String? _experience;
  String? _nationality;
  String? _currCountry;
  String? _currCity;
  String? _photo;
  String? _regDate;
  String? _userType;
  String? _isPremium;
  String? _premiumStart;
  dynamic _premiumEnd;

  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get mobileNumber => _mobileNumber;
  String? get gender => _gender;
  String? get dob => _dob;
  String? get qualification => _qualification;
  String? get experience => _experience;
  String? get nationality => _nationality;
  String? get currCountry => _currCountry;
  String? get currCity => _currCity;
  String? get photo => _photo;
  String? get regDate => _regDate;
  String? get userType => _userType;
  String? get isPremium => _isPremium;
  String? get premiumStart => _premiumStart;
  dynamic get premiumEnd => _premiumEnd;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['email'] = _email;
    map['mobile_number'] = _mobileNumber;
    map['gender'] = _gender;
    map['dob'] = _dob;
    map['qualification'] = _qualification;
    map['experience'] = _experience;
    map['nationality'] = _nationality;
    map['curr_country'] = _currCountry;
    map['curr_city'] = _currCity;
    map['photo'] = _photo;
    map['reg_date'] = _regDate;
    map['user_type'] = _userType;
    map['is_premium'] = _isPremium;
    map['premium_start'] = _premiumStart;
    map['premium_end'] = _premiumEnd;
    return map;
  }
}
