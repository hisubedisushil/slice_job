import 'dart:convert';

import 'company_model.dart';

JobModel jobModelFromJson(String str) => JobModel.fromJson(json.decode(str));
String jobModelToJson(JobModel data) => json.encode(data.toJson());

class JobModel {
  JobModel({
    String? id,
    String? jobKey,
    String? jobTittle,
    String? jobCity,
    String? jobCountry,
    String? experience,
    String? postDate,
    CompanyModel? company,
  }) {
    _id = id;
    _jobKey = jobKey;
    _jobTittle = jobTittle;
    _jobCity = jobCity;
    _jobCountry = jobCountry;
    _experience = experience;
    _postDate = postDate;
    _company = company;
  }

  JobModel.fromJson(dynamic json) {
    _id = json['id'];
    _jobKey = json['job_key'];
    _jobTittle = json['job_tittle'];
    _jobCity = json['job_city'];
    _jobCountry = json['job_country'];
    _experience = json['experience'];
    _postDate = json['post_date'];
    _company =
        json['company'] != null ? CompanyModel.fromJson(json['company']) : null;
  }
  String? _id;
  String? _jobKey;
  String? _jobTittle;
  String? _jobCity;
  String? _jobCountry;
  String? _experience;
  String? _postDate;
  CompanyModel? _company;

  String? get id => _id;
  String? get jobKey => _jobKey;
  String? get jobTittle => _jobTittle;
  String? get jobCity => _jobCity;
  String? get jobCountry => _jobCountry;
  String? get experience => _experience;
  String? get postDate => _postDate;
  CompanyModel? get company => _company;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['job_key'] = _jobKey;
    map['job_tittle'] = _jobTittle;
    map['job_city'] = _jobCity;
    map['job_country'] = _jobCountry;
    map['experience'] = _experience;
    map['post_date'] = _postDate;
    if (_company != null) {
      map['company'] = _company?.toJson();
    }
    return map;
  }
}
