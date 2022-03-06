import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));
String loginResponseModelToJson(LoginResponseModel data) =>
    json.encode(data.toJson());

class LoginResponseModel {
  LoginResponseModel({
    bool? status,
    String? message,
    LoginResponseData? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  LoginResponseModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data =
        json['data'] != null ? LoginResponseData.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  LoginResponseData? _data;

  bool? get status => _status;
  String? get message => _message;
  LoginResponseData? get data => _data;

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

LoginResponseData dataFromJson(String str) =>
    LoginResponseData.fromJson(json.decode(str));
String dataToJson(LoginResponseData data) => json.encode(data.toJson());

class LoginResponseData {
  LoginResponseData({
    String? token,
    String? email,
    int? expireAt,
  }) {
    _token = token;
    _email = email;
    _expireAt = expireAt;
  }

  LoginResponseData.fromJson(dynamic json) {
    _token = json['token'];
    _email = json['email'];
    _expireAt = json['expireAt'];
  }
  String? _token;
  String? _email;
  int? _expireAt;

  String? get token => _token;
  String? get email => _email;
  int? get expireAt => _expireAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = _token;
    map['email'] = _email;
    map['expireAt'] = _expireAt;
    return map;
  }
}
