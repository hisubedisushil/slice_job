import 'dart:convert';

RegisterResponseModel registerResponseModelFromJson(String str) =>
    RegisterResponseModel.fromJson(json.decode(str));
String registerResponseModelToJson(RegisterResponseModel data) =>
    json.encode(data.toJson());

class RegisterResponseModel {
  RegisterResponseModel({
    bool? status,
    String? message,
    RegisterResponseData? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  RegisterResponseModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null
        ? RegisterResponseData.fromJson(json['data'])
        : null;
  }
  bool? _status;
  String? _message;
  RegisterResponseData? _data;

  bool? get status => _status;
  String? get message => _message;
  RegisterResponseData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

RegisterResponseData dataFromJson(String str) =>
    RegisterResponseData.fromJson(json.decode(str));
String dataToJson(RegisterResponseData data) => json.encode(data.toJson());

class RegisterResponseData {
  RegisterResponseData({
    String? firstName,
    String? lastName,
    String? email,
    String? regDate,
    String? regIp,
    String? emailConfirm,
    String? userType,
    String? typeApproved,
  }) {
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _regDate = regDate;
    _regIp = regIp;
    _emailConfirm = emailConfirm;
    _userType = userType;
    _typeApproved = typeApproved;
  }

  RegisterResponseData.fromJson(dynamic json) {
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _email = json['email'];
    _regDate = json['reg_date'];
    _regIp = json['reg_ip'];
    _emailConfirm = json['email_confirm'];
    _userType = json['user_type'];
    _typeApproved = json['type_approved'];
  }
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _regDate;
  String? _regIp;
  String? _emailConfirm;
  String? _userType;
  String? _typeApproved;

  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get regDate => _regDate;
  String? get regIp => _regIp;
  String? get emailConfirm => _emailConfirm;
  String? get userType => _userType;
  String? get typeApproved => _typeApproved;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['email'] = _email;
    map['reg_date'] = _regDate;
    map['reg_ip'] = _regIp;
    map['email_confirm'] = _emailConfirm;
    map['user_type'] = _userType;
    map['type_approved'] = _typeApproved;
    return map;
  }
}
