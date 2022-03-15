import 'dart:convert';

/// status : true
/// message : "Page Static Listed Successfully."
/// data : {"id":"22","category":"Policy","post_title":"General","post_desc":"<p style=\"text-align: justify;\">In order for the website to function efficiently it is important for slicejob.com to collect, use, publish, and share personal information.</p>\r\n\r\n<p style=\"text-align: justify;\">We don&rsquo;t sell the personal information stored in our servers to any other marketing agencies</p>\r\n\r\n<p style=\"text-align: justify;\">Our servers are located in the United States and Singapore. Information posted on Slicejob.com will be stored and retrieved from these servers and we collect, publish and store the following personal information:</p>\r\n\r\n<p style=\"text-align: justify;\"><strong>Collection</strong></p>\r\n\r\n<ul>\r\n\t<li style=\"text-align: justify;\">Name, permanent address, country of origin, email address, passport no, user activity, photo and financial information computer sign-on data, statistics on page views, traffic to and from slicejob.com and response to advertisements other information, including users&#39; IP address and standard web log information.</li>\r\n</ul>\r\n","updated_by":"slicejob","updated_date":"12 May 2017 08:27:29","status":"Published"}

PolicyResponseModel policyResponseModelFromJson(String str) =>
    PolicyResponseModel.fromJson(json.decode(str));
String policyResponseModelToJson(PolicyResponseModel data) =>
    json.encode(data.toJson());

class PolicyResponseModel {
  PolicyResponseModel({
    bool? status,
    String? message,
    Data? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  PolicyResponseModel.fromJson(dynamic json) {
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

/// id : "22"
/// category : "Policy"
/// post_title : "General"
/// post_desc : "<p style=\"text-align: justify;\">In order for the website to function efficiently it is important for slicejob.com to collect, use, publish, and share personal information.</p>\r\n\r\n<p style=\"text-align: justify;\">We don&rsquo;t sell the personal information stored in our servers to any other marketing agencies</p>\r\n\r\n<p style=\"text-align: justify;\">Our servers are located in the United States and Singapore. Information posted on Slicejob.com will be stored and retrieved from these servers and we collect, publish and store the following personal information:</p>\r\n\r\n<p style=\"text-align: justify;\"><strong>Collection</strong></p>\r\n\r\n<ul>\r\n\t<li style=\"text-align: justify;\">Name, permanent address, country of origin, email address, passport no, user activity, photo and financial information computer sign-on data, statistics on page views, traffic to and from slicejob.com and response to advertisements other information, including users&#39; IP address and standard web log information.</li>\r\n</ul>\r\n"
/// updated_by : "slicejob"
/// updated_date : "12 May 2017 08:27:29"
/// status : "Published"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    String? id,
    String? category,
    String? postTitle,
    String? postDesc,
    String? updatedBy,
    String? updatedDate,
    String? status,
  }) {
    _id = id;
    _category = category;
    _postTitle = postTitle;
    _postDesc = postDesc;
    _updatedBy = updatedBy;
    _updatedDate = updatedDate;
    _status = status;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _category = json['category'];
    _postTitle = json['post_title'];
    _postDesc = json['post_desc'];
    _updatedBy = json['updated_by'];
    _updatedDate = json['updated_date'];
    _status = json['status'];
  }
  String? _id;
  String? _category;
  String? _postTitle;
  String? _postDesc;
  String? _updatedBy;
  String? _updatedDate;
  String? _status;

  String? get id => _id;
  String? get category => _category;
  String? get postTitle => _postTitle;
  String? get postDesc => _postDesc;
  String? get updatedBy => _updatedBy;
  String? get updatedDate => _updatedDate;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['category'] = _category;
    map['post_title'] = _postTitle;
    map['post_desc'] = _postDesc;
    map['updated_by'] = _updatedBy;
    map['updated_date'] = _updatedDate;
    map['status'] = _status;
    return map;
  }
}
