import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../models/appled_job_model.dart';
import '../models/certificate_model.dart';
import '../models/cv_basic_model.dart';
import '../models/cv_download_response_model.dart';
import '../models/education_model.dart';
import '../models/experience_model.dart';
import '../models/language_model.dart';
import '../models/profile_model.dart';
import '../models/skill_model.dart';
import '../models/training_model.dart';
import '../services/profile_service.dart';
import 'authentication_controller.dart';
import 'connectivity_controller.dart';
import 'dio_controller.dart';

class ProfileController with ChangeNotifier {
  final ConnectivityController? _connectivityController;
  final AuthenticationController? _authenticationController;
  final DioController? _dioController;

  final _profileService = ProfileService.service;

  ProfileController(
    this._connectivityController,
    this._authenticationController,
    this._dioController,
  ) {
    if (_connectivityController != null &&
        _authenticationController != null &&
        _dioController != null) {
      getProfile();
      getCVBasic();
      getAppliedJobs();
      getExperiences();
      getEducations();
      getSkills();
      getLanguages();
      getTrainings();
      getCertificates();
    }
  }

  getProfile() async {
    if (_isLoadingProfile) {
      return;
    }

    if (_connectivityController == null) {
      return;
    }

    if (_dioController == null) {
      return;
    }

    if (!(_connectivityController?.hasInternet ?? false)) {
      return;
    }

    if (_authenticationController == null) {
      return;
    }

    if (!(_authenticationController?.isLoggedIn ?? false)) {
      return;
    }

    _isLoadingProfile = true;
    notifyListeners();

    _profile = await _profileService.getProfile(
      dio: _dioController!,
    );

    _isLoadingProfile = false;
    notifyListeners();
  }

  getCVBasic() async {
    if (_isLoadingCVBasic) {
      return;
    }

    if (_connectivityController == null) {
      return;
    }

    if (_dioController == null) {
      return;
    }

    if (!(_connectivityController?.hasInternet ?? false)) {
      return;
    }

    if (_authenticationController == null) {
      return;
    }

    if (!(_authenticationController?.isLoggedIn ?? false)) {
      return;
    }

    _isLoadingCVBasic = true;
    notifyListeners();

    _cvBasic = await _profileService.getCVBasic(
      dio: _dioController!,
    );

    _isLoadingCVBasic = false;
    notifyListeners();
  }

  Future<bool> updateProfile({
    required String firstName,
    required String lastName,
    required String dob,
    required String nationality,
    required String gender,
    required String currentCountry,
    required String currentCity,
    required String qualification,
    required String experience,
    required String mobile,
  }) async {
    if (_connectivityController == null) {
      return false;
    }

    if (_dioController == null) {
      return false;
    }

    if (!(_connectivityController?.hasInternet ?? false)) {
      return false;
    }

    bool b = await _profileService.updateProfile(
      dio: _dioController!,
      firstName: firstName,
      lastName: lastName,
      gender: gender,
      qualification: qualification,
      currentCountry: currentCountry,
      currentCity: currentCity,
      mobile: mobile,
      nationality: nationality,
      dob: dob,
      experience: experience,
    );

    if (b) {
      await getProfile();
    }

    return b;
  }

  Future<String?> uploadProfileImage({required String image}) async {
    if (_connectivityController == null) {
      return null;
    }

    if (_dioController == null) {
      return null;
    }

    if (!(_connectivityController?.hasInternet ?? false)) {
      return null;
    }

    String result = await _profileService.uploadProfileImage(
      dio: _dioController!,
      image: image,
    );

    if (result.isEmpty) {
      await getProfile();
    }

    return result;
  }

  Future<String> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    if (_connectivityController == null) {
      return 'Network Error!';
    }

    if (_dioController == null) {
      return 'Network Error!';
    }

    if (!(_connectivityController?.hasInternet ?? false)) {
      return 'Network Error!';
    }

    return await _profileService.changePassword(
      dio: _dioController!,
      oldPassword: oldPassword,
      password: newPassword,
    );
  }

  getAppliedJobs() async {
    if (_connectivityController == null) {
      return;
    }

    if (_dioController == null) {
      return;
    }

    if (!(_connectivityController?.hasInternet ?? false)) {
      return;
    }

    _appliedJobs
      ..clear()
      ..addAll(await _profileService.getAppliedJobs(dio: _dioController!));

    notifyListeners();
  }

  Future<String> updateCVBasicInformation({
    required String firstName,
    required String lastName,
    required String birthDate,
    required String gender,
    required String nationality,
    required String maritalStatus,
    required String currentCountry,
    required String currentCity,
  }) async {
    if (_connectivityController == null) {
      return 'Network Error!';
    }

    if (_dioController == null) {
      return 'Network Error!';
    }

    if (!(_connectivityController?.hasInternet ?? false)) {
      return 'Network Error!';
    }
    List<String> date = birthDate.split('-');

    String result = await _profileService.updateCVBasicInformation(
      dio: _dioController!,
      firstName: firstName,
      lastName: lastName,
      birthDay: (date.length == 3) ? date[0] : '',
      birthMonth: (date.length == 3) ? date[1] : '',
      birthYear: (date.length == 3) ? date[2] : '',
      gender: gender,
      nationality: nationality,
      maritalStatus: maritalStatus,
      currentCountry: currentCountry,
      currentCity: currentCity,
    );

    if (result.isEmpty) {
      await getCVBasic();
      notifyListeners();
    }

    return result;
  }

  Future<String> updateCVContactInformation({
    required String email,
    required String contactNumber,
    required String website,
  }) async {
    if (_connectivityController == null) {
      return 'Network Error!';
    }

    if (_dioController == null) {
      return 'Network Error!';
    }

    if (!(_connectivityController?.hasInternet ?? false)) {
      return 'Network Error!';
    }

    String result = await _profileService.updateCVContactInformation(
      dio: _dioController!,
      email: email,
      contactNumber: contactNumber,
      website: website,
    );

    if (result.isEmpty) {
      await getCVBasic();
      notifyListeners();
    }

    return result;
  }

  Future<String> updateCVTargetJob({
    required String jobRole,
    required String jobTitle,
    required String level,
    required String type,
    required String salary,
    required String currency,
  }) async {
    if (_connectivityController == null) {
      return 'Network Error!';
    }

    if (_dioController == null) {
      return 'Network Error!';
    }

    if (!(_connectivityController?.hasInternet ?? false)) {
      return 'Network Error!';
    }

    String result = await _profileService.updateCVTargetJob(
      dio: _dioController!,
      jobRole: jobRole,
      jobTitle: jobTitle,
      level: level,
      type: type,
      salary: salary,
      currency: currency,
    );

    if (result.isEmpty) {
      await getCVBasic();
      notifyListeners();
    }

    return result;
  }

  /// Experience
  getExperiences() async {
    if (_connectivityController == null) {
      return;
    }

    if (_dioController == null) {
      return;
    }

    if (!(_connectivityController?.hasInternet ?? false)) {
      return;
    }

    _experienceList
      ..clear()
      ..addAll(await _profileService.getExperiences(dio: _dioController!));

    notifyListeners();
  }

  Future<String> postExperience({
    String? id,
    required String jobTitle,
    required String company,
    required String location,
    required String fromMonth,
    required String fromYear,
    required String toMonth,
    required String toYear,
    required String description,
  }) async {
    if (_connectivityController == null) {
      return 'Network Error!';
    }

    if (_dioController == null) {
      return 'Network Error!';
    }

    if (!(_connectivityController?.hasInternet ?? false)) {
      return 'Network Error!';
    }

    String result = await _profileService.addExperience(
      dio: _dioController!,
      id: id,
      jobTitle: jobTitle,
      company: company,
      location: location,
      fromMonth: fromMonth,
      fromYear: fromYear,
      toMonth: toMonth,
      toYear: toYear,
      description: description,
    );

    if (result.isEmpty) {
      await getExperiences();
    }

    return result;
  }

  Future<String> deleteExperience({required String id}) async {
    if (_connectivityController == null) {
      return 'Network Error!';
    }

    if (_dioController == null) {
      return 'Network Error!';
    }

    if (!(_connectivityController?.hasInternet ?? false)) {
      return 'Network Error!';
    }

    String result = await _profileService.deleteExperience(
      dio: _dioController!,
      id: id,
    );

    if (result.isEmpty) {
      await getExperiences();
    }

    return result;
  }

  /// Education
  getEducations() async {
    if (_connectivityController == null) {
      return;
    }

    if (_dioController == null) {
      return;
    }

    if (!(_connectivityController?.hasInternet ?? false)) {
      return;
    }

    _educationList
      ..clear()
      ..addAll(await _profileService.getEducations(dio: _dioController!));

    notifyListeners();
  }

  Future<String> postEducation({
    String? id,
    required String degree,
    required String field,
    required String institution,
    required String country,
    required String city,
    required String startMonth,
    required String startYear,
    required String endMonth,
    required String endYear,
  }) async {
    if (_connectivityController == null) {
      return 'Network Error!';
    }

    if (_dioController == null) {
      return 'Network Error!';
    }

    if (!(_connectivityController?.hasInternet ?? false)) {
      return 'Network Error!';
    }

    String result = await _profileService.addEducation(
      dio: _dioController!,
      id: id,
      degree: degree,
      field: field,
      institution: institution,
      country: country,
      city: city,
      startMonth: startMonth,
      startYear: startYear,
      endMonth: endMonth,
      endYear: endYear,
    );

    if (result.isEmpty) {
      await getEducations();
    }

    return result;
  }

  Future<String> deleteEducation({required String id}) async {
    if (_connectivityController == null) {
      return 'Network Error!';
    }

    if (_dioController == null) {
      return 'Network Error!';
    }

    if (!(_connectivityController?.hasInternet ?? false)) {
      return 'Network Error!';
    }

    String result = await _profileService.deleteEducation(
      dio: _dioController!,
      id: id,
    );

    if (result.isEmpty) {
      await getEducations();
    }

    return result;
  }

  /// Skill
  getSkills() async {
    if (_connectivityController == null) {
      return;
    }

    if (_dioController == null) {
      return;
    }

    if (!(_connectivityController?.hasInternet ?? false)) {
      return;
    }

    _skillList
      ..clear()
      ..addAll(await _profileService.getSkills(dio: _dioController!));

    notifyListeners();
  }

  Future<String> postSkill({
    String? id,
    required String skill,
    required String level,
  }) async {
    if (_connectivityController == null) {
      return 'Network Error!';
    }

    if (_dioController == null) {
      return 'Network Error!';
    }

    if (!(_connectivityController?.hasInternet ?? false)) {
      return 'Network Error!';
    }

    String result = await _profileService.addSkill(
      dio: _dioController!,
      id: id,
      skill: skill,
      level: level,
    );

    if (result.isEmpty) {
      await getSkills();
    }

    return result;
  }

  Future<String> deleteSkill({required String id}) async {
    if (_connectivityController == null) {
      return 'Network Error!';
    }

    if (_dioController == null) {
      return 'Network Error!';
    }

    if (!(_connectivityController?.hasInternet ?? false)) {
      return 'Network Error!';
    }

    String result = await _profileService.deleteSkill(
      dio: _dioController!,
      id: id,
    );

    if (result.isEmpty) {
      await getSkills();
    }

    return result;
  }

  /// Language
  getLanguages() async {
    if (_connectivityController == null) {
      return;
    }

    if (_dioController == null) {
      return;
    }

    if (!(_connectivityController?.hasInternet ?? false)) {
      return;
    }

    _languageList
      ..clear()
      ..addAll(await _profileService.getLanguages(dio: _dioController!));

    notifyListeners();
  }

  Future<String> postLanguage({
    String? id,
    required String language,
    required String level,
  }) async {
    if (_connectivityController == null) {
      return 'Network Error!';
    }

    if (_dioController == null) {
      return 'Network Error!';
    }

    if (!(_connectivityController?.hasInternet ?? false)) {
      return 'Network Error!';
    }

    String result = await _profileService.addLanguage(
      dio: _dioController!,
      id: id,
      language: language,
      level: level,
    );

    if (result.isEmpty) {
      await getLanguages();
    }

    return result;
  }

  Future<String> deleteLanguage({required String id}) async {
    if (_connectivityController == null) {
      return 'Network Error!';
    }

    if (_dioController == null) {
      return 'Network Error!';
    }

    if (!(_connectivityController?.hasInternet ?? false)) {
      return 'Network Error!';
    }

    String result = await _profileService.deleteLanguage(
      dio: _dioController!,
      id: id,
    );

    if (result.isEmpty) {
      await getLanguages();
    }

    return result;
  }

  /// Training
  getTrainings() async {
    if (_connectivityController == null) {
      return;
    }

    if (_dioController == null) {
      return;
    }

    if (!(_connectivityController?.hasInternet ?? false)) {
      return;
    }

    _trainingList
      ..clear()
      ..addAll(await _profileService.getTrainings(dio: _dioController!));

    notifyListeners();
  }

  Future<String> postTraining({
    String? id,
    required String title,
    required String startMonth,
    required String startYear,
    required String endMonth,
    required String endYear,
  }) async {
    if (_connectivityController == null) {
      return 'Network Error!';
    }

    if (_dioController == null) {
      return 'Network Error!';
    }

    if (!(_connectivityController?.hasInternet ?? false)) {
      return 'Network Error!';
    }

    String result = await _profileService.addTraining(
      dio: _dioController!,
      id: id,
      title: title,
      startMonth: startMonth,
      startYear: startYear,
      endMonth: endMonth,
      endYear: endYear,
    );

    if (result.isEmpty) {
      await getTrainings();
    }

    return result;
  }

  Future<String> deleteTraining({required String id}) async {
    if (_connectivityController == null) {
      return 'Network Error!';
    }

    if (_dioController == null) {
      return 'Network Error!';
    }

    if (!(_connectivityController?.hasInternet ?? false)) {
      return 'Network Error!';
    }

    String result = await _profileService.deleteTraining(
      dio: _dioController!,
      id: id,
    );

    if (result.isEmpty) {
      await getTrainings();
    }

    return result;
  }

  /// Certificate
  getCertificates() async {
    if (_connectivityController == null) {
      return;
    }

    if (_dioController == null) {
      return;
    }

    if (!(_connectivityController?.hasInternet ?? false)) {
      return;
    }

    _certificateList
      ..clear()
      ..addAll(await _profileService.getCertificates(dio: _dioController!));

    notifyListeners();
  }

  Future<String> postCertificate({
    String? id,
    required String title,
    required String description,
    required String issueMonth,
    required String issueYear,
    required String expireMonth,
    required String expireYear,
  }) async {
    if (_connectivityController == null) {
      return 'Network Error!';
    }

    if (_dioController == null) {
      return 'Network Error!';
    }

    if (!(_connectivityController?.hasInternet ?? false)) {
      return 'Network Error!';
    }

    String result = await _profileService.addCertificate(
      dio: _dioController!,
      id: id,
      title: title,
      description: description,
      issueMonth: issueMonth,
      issueYear: issueYear,
      expireMonth: expireMonth,
      expireYear: expireYear,
    );

    if (result.isEmpty) {
      await getCertificates();
    }

    return result;
  }

  Future<String> deleteCertificate({required String id}) async {
    if (_connectivityController == null) {
      return 'Network Error!';
    }

    if (_dioController == null) {
      return 'Network Error!';
    }

    if (!(_connectivityController?.hasInternet ?? false)) {
      return 'Network Error!';
    }

    String result = await _profileService.deleteCertificate(
      dio: _dioController!,
      id: id,
    );

    if (result.isEmpty) {
      await getCertificates();
    }

    return result;
  }

  /// Original CV
  Future<String?> uploadOriginalCV({required String cv}) async {
    if (_connectivityController == null) {
      return null;
    }

    if (_dioController == null) {
      return null;
    }

    if (!(_connectivityController?.hasInternet ?? false)) {
      return null;
    }

    return await _profileService.uploadCV(dio: _dioController!, cv: cv);
  }

  Future<String> getCVDownloadLink() async {
    if (_connectivityController == null) {
      return '';
    }

    if (_dioController == null) {
      return '';
    }

    if (!(_connectivityController?.hasInternet ?? false)) {
      return '';
    }

    CvDownloadResponseModel? cv = await _profileService.getCV(
      dio: _dioController!,
    );

    // return cv?.data?.cvFile ?? '';

    if (cv == null) {
      return '';
    } else {
      try {
        Directory appDocDir = await getApplicationDocumentsDirectory();
        Response r = await Dio().download(
          cv.data?.cvFile ?? '',
          '${appDocDir.path}/cv.pdf',
        );

        return '${appDocDir.path}/cv.pdf';
      } catch (e, s) {
        return '';
      }
    }
  }

  /// Data
  bool _isLoadingProfile = false;
  bool get isLoadingProfile => _isLoadingProfile;

  ProfileModel? _profile;
  ProfileModel? get profile => _profile;

  bool _isLoadingCVBasic = false;
  bool get isLoadingCVBasic => _isLoadingCVBasic;

  CVBasicModel? _cvBasic;
  CVBasicModel? get cvBasic => _cvBasic;

  final List<AppliedJobModel> _appliedJobs = [];
  List<AppliedJobModel> get appliedJobs => _appliedJobs;

  final List<ExperienceModel> _experienceList = [];
  List<ExperienceModel> get experienceList => _experienceList;

  final List<EducationModel> _educationList = [];
  List<EducationModel> get educationList => _educationList;

  final List<SkillModel> _skillList = [];
  List<SkillModel> get skillList => _skillList;

  final List<LanguageModel> _languageList = [];
  List<LanguageModel> get languageList => _languageList;

  final List<TrainingModel> _trainingList = [];
  List<TrainingModel> get trainingList => _trainingList;

  final List<CertificateModel> _certificateList = [];
  List<CertificateModel> get certificateList => _certificateList;
}
