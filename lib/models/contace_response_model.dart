import 'dart:convert';

/// status : true
/// message : "Page Contact Listed Successfully."
/// data : {"title":"Slicejob","contact":"<h2><strong>Slicejob Dot Com Pvt. Ltd</strong></h2>\r\n\r\n<p>Baluwatar, Kathmandu, Nepal</p>\r\n\r\n<p>+977 1 44 22 736</p>\r\n\r\n<p>info@slicejob.com</p>\r\n\r\n<p>sales@slicejob.com</p>\r\n\r\n<p>Sunday to Friday</p>\r\n\r\n<p>9:00 am - 6:00 pm</p>\r\n","phone":"info@slicejob.com","address":"Baluwatar, Kathmandu, Nepal","facebook":"https://www.facebook.com/slicejob","twitter":"https://twitter.com/slicejobnepal","instagram":"https://www.instagram.com/slicejob/","linkedin":"https://www.linkedin.com/company/14441329/admin/","youtube":"https://twitter.com/slicejobnepal","whatsapp":"","telegram":"","google_map":"<iframe src=\"https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1049.981249438089!2d85.33018887774995!3d27.726489642705083!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x39eb1905fc907c87%3A0x2b4caf1e24f70fb0!2sSlicejob%20Dot%20Com%20Pvt%20Ltd!5e0!3m2!1sen!2snp!4v1645596919679!5m2!1sen!2snp\" width=\"600\" height=\"450\" style=\"border:0;\" allowfullscreen=\"\" loading=\"lazy\"></iframe>"}

ContaceResponseModel contaceResponseModelFromJson(String str) =>
    ContaceResponseModel.fromJson(json.decode(str));
String contaceResponseModelToJson(ContaceResponseModel data) =>
    json.encode(data.toJson());

class ContaceResponseModel {
  ContaceResponseModel({
    bool? status,
    String? message,
    Data? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  ContaceResponseModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  Data? _data;

  bool? get status => _status;
  String? get message => _message;
  Data? get data => _data;

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

/// title : "Slicejob"
/// contact : "<h2><strong>Slicejob Dot Com Pvt. Ltd</strong></h2>\r\n\r\n<p>Baluwatar, Kathmandu, Nepal</p>\r\n\r\n<p>+977 1 44 22 736</p>\r\n\r\n<p>info@slicejob.com</p>\r\n\r\n<p>sales@slicejob.com</p>\r\n\r\n<p>Sunday to Friday</p>\r\n\r\n<p>9:00 am - 6:00 pm</p>\r\n"
/// phone : "info@slicejob.com"
/// address : "Baluwatar, Kathmandu, Nepal"
/// facebook : "https://www.facebook.com/slicejob"
/// twitter : "https://twitter.com/slicejobnepal"
/// instagram : "https://www.instagram.com/slicejob/"
/// linkedin : "https://www.linkedin.com/company/14441329/admin/"
/// youtube : "https://twitter.com/slicejobnepal"
/// whatsapp : ""
/// telegram : ""
/// google_map : "<iframe src=\"https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1049.981249438089!2d85.33018887774995!3d27.726489642705083!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x39eb1905fc907c87%3A0x2b4caf1e24f70fb0!2sSlicejob%20Dot%20Com%20Pvt%20Ltd!5e0!3m2!1sen!2snp!4v1645596919679!5m2!1sen!2snp\" width=\"600\" height=\"450\" style=\"border:0;\" allowfullscreen=\"\" loading=\"lazy\"></iframe>"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    String? title,
    String? contact,
    String? phone,
    String? address,
    String? facebook,
    String? twitter,
    String? instagram,
    String? linkedin,
    String? youtube,
    String? whatsapp,
    String? telegram,
    String? googleMap,
  }) {
    _title = title;
    _contact = contact;
    _phone = phone;
    _address = address;
    _facebook = facebook;
    _twitter = twitter;
    _instagram = instagram;
    _linkedin = linkedin;
    _youtube = youtube;
    _whatsapp = whatsapp;
    _telegram = telegram;
    _googleMap = googleMap;
  }

  Data.fromJson(dynamic json) {
    _title = json['title'];
    _contact = json['contact'];
    _phone = json['phone'];
    _address = json['address'];
    _facebook = json['facebook'];
    _twitter = json['twitter'];
    _instagram = json['instagram'];
    _linkedin = json['linkedin'];
    _youtube = json['youtube'];
    _whatsapp = json['whatsapp'];
    _telegram = json['telegram'];
    _googleMap = json['google_map'];
  }
  String? _title;
  String? _contact;
  String? _phone;
  String? _address;
  String? _facebook;
  String? _twitter;
  String? _instagram;
  String? _linkedin;
  String? _youtube;
  String? _whatsapp;
  String? _telegram;
  String? _googleMap;

  String? get title => _title;
  String? get contact => _contact;
  String? get phone => _phone;
  String? get address => _address;
  String? get facebook => _facebook;
  String? get twitter => _twitter;
  String? get instagram => _instagram;
  String? get linkedin => _linkedin;
  String? get youtube => _youtube;
  String? get whatsapp => _whatsapp;
  String? get telegram => _telegram;
  String? get googleMap => _googleMap;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['contact'] = _contact;
    map['phone'] = _phone;
    map['address'] = _address;
    map['facebook'] = _facebook;
    map['twitter'] = _twitter;
    map['instagram'] = _instagram;
    map['linkedin'] = _linkedin;
    map['youtube'] = _youtube;
    map['whatsapp'] = _whatsapp;
    map['telegram'] = _telegram;
    map['google_map'] = _googleMap;
    return map;
  }
}
