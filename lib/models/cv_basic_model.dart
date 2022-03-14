import 'dart:convert';

CVBasicModel dataFromJson(String str) =>
    CVBasicModel.fromJson(json.decode(str));
String dataToJson(CVBasicModel data) => json.encode(data.toJson());

class CVBasicModel {
  CVBasicModel({
    String? id,
    String? userId,
    String? firstName,
    String? lastName,
    String? birthDay,
    String? birthMonth,
    String? birthYear,
    String? gender,
    String? nationality,
    String? maritalStatus,
    String? currentCountry,
    String? currentCity,
    String? email,
    String? contactNumber,
    String? website,
    String? jobRole,
    String? jobTitle,
    String? careerLevel,
    String? jobType,
    String? targetSalary,
    String? targetSalaryCurrency,
    String? updateDate,
    String? privacy,
    String? testField,
  }) {
    _id = id;
    _userId = userId;
    _firstName = firstName;
    _lastName = lastName;
    _birthDay = birthDay;
    _birthMonth = birthMonth;
    _birthYear = birthYear;
    _gender = gender;
    _nationality = nationality;
    _maritalStatus = maritalStatus;
    _currentCountry = currentCountry;
    _currentCity = currentCity;
    _email = email;
    _contactNumber = contactNumber;
    _website = website;
    _jobRole = jobRole;
    _jobTitle = jobTitle;
    _careerLevel = careerLevel;
    _jobType = jobType;
    _targetSalary = targetSalary;
    _targetSalaryCurrency = targetSalaryCurrency;
    _updateDate = updateDate;
    _privacy = privacy;
    _testField = testField;
  }

  CVBasicModel.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _birthDay = json['birth_day'];
    _birthMonth = json['birth_month'];
    _birthYear = json['birth_year'];
    _gender = json['gender'];
    _nationality = json['nationality'];
    _maritalStatus = json['marital_status'];
    _currentCountry = json['current_country'];
    _currentCity = json['current_city'];
    _email = json['email'];
    _contactNumber = json['contact_number'];
    _website = json['website'];
    _jobRole = json['job_role'];
    _jobTitle = json['job_title '];
    _careerLevel = json['career_level'];
    _jobType = json['job_type'];
    _targetSalary = json['target_salary'];
    _targetSalaryCurrency = json['target_salary_currency'];
    _updateDate = json['update_date'];
    _privacy = json['privacy'];
    _testField = json['test_field'];
  }
  String? _id;
  String? _userId;
  String? _firstName;
  String? _lastName;
  String? _birthDay;
  String? _birthMonth;
  String? _birthYear;
  String? _gender;
  String? _nationality;
  String? _maritalStatus;
  String? _currentCountry;
  String? _currentCity;
  String? _email;
  String? _contactNumber;
  String? _website;
  String? _jobRole;
  String? _jobTitle;
  String? _careerLevel;
  String? _jobType;
  String? _targetSalary;
  String? _targetSalaryCurrency;
  String? _updateDate;
  String? _privacy;
  String? _testField;

  String? get id => _id;
  String? get userId => _userId;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get birthDay => _birthDay;
  String? get birthMonth => _birthMonth;
  String? get birthYear => _birthYear;
  String? get gender => _gender;
  String? get nationality => _nationality;
  String? get maritalStatus => _maritalStatus;
  String? get currentCountry => _currentCountry;
  String? get currentCity => _currentCity;
  String? get email => _email;
  String? get contactNumber => _contactNumber;
  String? get website => _website;
  String? get jobRole => _jobRole;
  String? get jobTitle => _jobTitle;
  String? get careerLevel => _careerLevel;
  String? get jobType => _jobType;
  String? get targetSalary => _targetSalary;
  String? get targetSalaryCurrency => _targetSalaryCurrency;
  String? get updateDate => _updateDate;
  String? get privacy => _privacy;
  String? get testField => _testField;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['birth_day'] = _birthDay;
    map['birth_month'] = _birthMonth;
    map['birth_year'] = _birthYear;
    map['gender'] = _gender;
    map['nationality'] = _nationality;
    map['marital_status'] = _maritalStatus;
    map['current_country'] = _currentCountry;
    map['current_city'] = _currentCity;
    map['email'] = _email;
    map['contact_number'] = _contactNumber;
    map['website'] = _website;
    map['job_role'] = _jobRole;
    map['job_title '] = _jobTitle;
    map['career_level'] = _careerLevel;
    map['job_type'] = _jobType;
    map['target_salary'] = _targetSalary;
    map['target_salary_currency'] = _targetSalaryCurrency;
    map['update_date'] = _updateDate;
    map['privacy'] = _privacy;
    map['test_field'] = _testField;
    return map;
  }
}
