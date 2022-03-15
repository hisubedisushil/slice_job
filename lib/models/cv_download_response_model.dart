import 'dart:convert';

/// status : true
/// message : "CV File Downloaded Successfully."
/// data : {"cv_file":"https://slicejob.com//api/v1/tempcv/9fb7b048c96d44a0337f049e0a61ff06_cv.pdf"}

CvDownloadResponseModel cvDownloadResponseModelFromJson(String str) =>
    CvDownloadResponseModel.fromJson(json.decode(str));
String cvDownloadResponseModelToJson(CvDownloadResponseModel data) =>
    json.encode(data.toJson());

class CvDownloadResponseModel {
  CvDownloadResponseModel({
    bool? status,
    String? message,
    Data? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  CvDownloadResponseModel.fromJson(dynamic json) {
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

/// cv_file : "https://slicejob.com//api/v1/tempcv/9fb7b048c96d44a0337f049e0a61ff06_cv.pdf"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    String? cvFile,
  }) {
    _cvFile = cvFile;
  }

  Data.fromJson(dynamic json) {
    _cvFile = json['cv_file'];
  }
  String? _cvFile;

  String? get cvFile => _cvFile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cv_file'] = _cvFile;
    return map;
  }
}
