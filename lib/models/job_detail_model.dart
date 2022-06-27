import 'dart:convert';

import 'company_model.dart';

JobDetailModel dataFromJson(String str) =>
    JobDetailModel.fromJson(json.decode(str));
String dataToJson(JobDetailModel data) => json.encode(data.toJson());

class JobDetailModel {
  JobDetailModel({
    String? id,
    String? jobKey,
    String? jobTittle,
    String? jobCategory,
    String? jobCatId,
    String? jobType,
    String? jobCountry,
    String? jobCity,
    String? careerLevel,
    String? educationLevel,
    String? experience,
    String? jobSalary,
    String? jobApplyUrl,
    String? applicationReceieveBoth,
    String? benefits,
    String? onlineExam,
    String? descriptions,
    String? postDate,
    String? link,
    CompanyModel? company,
  }) {
    _id = id;
    _jobKey = jobKey;
    _jobTittle = jobTittle;
    _jobCategory = jobCategory;
    _jobCatId = jobCatId;
    _jobType = jobType;
    _jobCountry = jobCountry;
    _jobCity = jobCity;
    _careerLevel = careerLevel;
    _educationLevel = educationLevel;
    _experience = experience;
    _jobSalary = jobSalary;
    _jobApplyUrl = jobApplyUrl;
    _applicationReceieveBoth = applicationReceieveBoth;
    _benefits = benefits;
    _onlineExam = onlineExam;
    _descriptions = descriptions;
    _postDate = postDate;
    _link = link;
    _company = company;
  }

  JobDetailModel.fromJson(dynamic json) {
    _id = json['id'];
    _jobKey = json['job_key'];
    _jobTittle = json['job_tittle'];
    _jobCategory = json['job_category'];
    _jobCatId = json['job_cat_id'];
    _jobType = json['job_type'];
    _jobCountry = json['job_country'];
    _jobCity = json['job_city'];
    _careerLevel = json['career_level'];
    _educationLevel = json['education_level'];
    _experience = json['experience'];
    _jobSalary = json['job_salary'];
    _jobApplyUrl = json['job_apply_url'];
    _applicationReceieveBoth = json['application_receieve_both'];
    _benefits = json['benefits'];
    _onlineExam = json['online_exam'];
    _descriptions = json['descriptions'];
    _postDate = json['post_date'];
    _link = json['link'];
    _company =
        json['company'] != null ? CompanyModel.fromJson(json['company']) : null;
  }
  String? _id;
  String? _jobKey;
  String? _jobTittle;
  String? _jobCategory;
  String? _jobCatId;
  String? _jobType;
  String? _jobCountry;
  String? _jobCity;
  String? _careerLevel;
  String? _educationLevel;
  String? _experience;
  String? _jobSalary;
  String? _jobApplyUrl;
  String? _applicationReceieveBoth;
  String? _benefits;
  String? _onlineExam;
  String? _descriptions;
  String? _postDate;
  String? _link;
  CompanyModel? _company;

  String? get id => _id;
  String? get jobKey => _jobKey;
  String? get jobTittle => _jobTittle;
  String? get jobCategory => _jobCategory;
  String? get jobCatId => _jobCatId;
  String? get jobType => _jobType;
  String? get jobCountry => _jobCountry;
  String? get jobCity => _jobCity;
  String? get careerLevel => _careerLevel;
  String? get educationLevel => _educationLevel;
  String? get experience => _experience;
  String? get jobSalary => _jobSalary;
  String? get jobApplyUrl => _jobApplyUrl;
  String? get applicationReceieveBoth => _applicationReceieveBoth;
  String? get benefits => _benefits;
  String? get onlineExam => _onlineExam;
  String? get descriptions => _descriptions;
  String? get postDate => _postDate;
  String? get link => _link;
  CompanyModel? get company => _company;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['job_key'] = _jobKey;
    map['job_tittle'] = _jobTittle;
    map['job_category'] = _jobCategory;
    map['job_cat_id'] = _jobCatId;
    map['job_type'] = _jobType;
    map['job_country'] = _jobCountry;
    map['job_city'] = _jobCity;
    map['career_level'] = _careerLevel;
    map['education_level'] = _educationLevel;
    map['experience'] = _experience;
    map['job_salary'] = _jobSalary;
    map['job_apply_url'] = _jobApplyUrl;
    map['application_receieve_both'] = _applicationReceieveBoth;
    map['benefits'] = _benefits;
    map['online_exam'] = _onlineExam;
    map['descriptions'] = _descriptions;
    map['post_date'] = _postDate;
    map['link'] = _link;
    if (_company != null) {
      map['company'] = _company?.toJson();
    }
    return map;
  }
}
