import 'package:flutter/material.dart';

import '../models/about_response_model.dart';
import '../models/blog_category_model.dart';
import '../models/city_model.dart';
import '../models/company_model.dart';
import '../models/contace_response_model.dart';
import '../models/country_model.dart';
import '../models/faq_response_model.dart';
import '../models/job_category_model.dart';
import '../models/job_title_model.dart';
import '../models/job_type_model.dart';
import '../models/policy_response_model.dart';
import '../models/term_response_model.dart';
import '../services/general_service.dart';
import 'connectivity_controller.dart';
import 'dio_controller.dart';

class GeneralController with ChangeNotifier {
  final ConnectivityController? _connectivityController;
  final DioController? _dioController;

  final _generalService = GeneralService.service;

  GeneralController(
    this._connectivityController,
    this._dioController,
  ) {
    if (_connectivityController != null && _dioController != null) {
      getAllCategories();
      getBlogCategories();
      getFeaturedCategories();
      getTopEmployers();
      getCountries();
      getJobTypes();
      getCareerLevels();
      getSalaryList();
      getEducationLevels();
      getExperienceLevels();
      getAboutUs();
      getContactUs();
      getFaqs();
      getTerms();
      getPrivacy();
    }
  }

  getAllCategories() async {
    if (_isLoadingAllJobCategories) {
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

    _isLoadingAllJobCategories = true;
    notifyListeners();

    _allCategories
      ..clear()
      ..addAll(await _generalService.getAllJobCategories(dio: _dioController!));

    _isLoadingAllJobCategories = false;
    notifyListeners();
  }

  getBlogCategories() async {
    if (_isLoadingBlogCategories) {
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

    _isLoadingBlogCategories = true;
    notifyListeners();

    _blogCategories
      ..clear()
      ..addAll(await _generalService.getBlogCategories(dio: _dioController!));

    _isLoadingBlogCategories = false;
    notifyListeners();
  }

  getFeaturedCategories() async {
    if (_isLoadingFeatureJobCategories) {
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

    _isLoadingFeatureJobCategories = true;
    notifyListeners();

    _featureCategories
      ..clear()
      ..addAll(
        await _generalService.getFeatureJobCategories(dio: _dioController!),
      );

    _isLoadingFeatureJobCategories = false;
    notifyListeners();
  }

  getTopEmployers() async {
    if (_isLoadingCompany) {
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

    _isLoadingCompany = true;
    notifyListeners();

    _companies
      ..clear()
      ..addAll(await _generalService.getTopEmployers(dio: _dioController!));

    _isLoadingCompany = false;
    notifyListeners();
  }

  getCountries() async {
    if (_isLoadingCountries) {
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

    _isLoadingCountries = true;
    notifyListeners();

    _countries
      ..clear()
      ..addAll(await _generalService.getCountries(dio: _dioController!));

    _isLoadingCountries = false;
    notifyListeners();
  }

  getJobTypes() async {
    if (_isLoadingJobTypes) {
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

    _isLoadingJobTypes = true;
    notifyListeners();

    _jobTypes
      ..clear()
      ..addAll(await _generalService.getJobTypes(dio: _dioController!));

    _isLoadingJobTypes = false;
    notifyListeners();
  }

  getCareerLevels() async {
    if (_isLoadingCareerLevels) {
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

    _isLoadingCareerLevels = true;
    notifyListeners();

    _jobCareerLevels
      ..clear()
      ..addAll(await _generalService.getJobCareerLevels(dio: _dioController!));

    _isLoadingCareerLevels = false;
    notifyListeners();
  }

  getSalaryList() async {
    if (_isLoadingSalaries) {
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

    _isLoadingSalaries = true;
    notifyListeners();

    _salaries
      ..clear()
      ..addAll(await _generalService.getJobSalaries(dio: _dioController!));

    _isLoadingSalaries = false;
    notifyListeners();
  }

  getEducationLevels() async {
    if (_isLoadingEducationLevels) {
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

    _isLoadingEducationLevels = true;
    notifyListeners();

    _educationLevels
      ..clear()
      ..addAll(await _generalService.getEducationLevels(dio: _dioController!));

    _isLoadingEducationLevels = false;
    notifyListeners();
  }

  getExperienceLevels() async {
    if (_isLoadingExperienceLevels) {
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

    _isLoadingExperienceLevels = true;
    notifyListeners();

    _experienceLevels
      ..clear()
      ..addAll(await _generalService.getExperienceLevels(dio: _dioController!));

    _isLoadingExperienceLevels = false;
    notifyListeners();
  }

  getAboutUs() async {
    if (_connectivityController == null) {
      return;
    }

    if (_dioController == null) {
      return;
    }

    if (!(_connectivityController?.hasInternet ?? false)) {
      return;
    }

    _aboutUs = await _generalService.getAbout(dio: _dioController!);

    notifyListeners();
  }

  getContactUs() async {
    if (_connectivityController == null) {
      return;
    }

    if (_dioController == null) {
      return;
    }

    if (!(_connectivityController?.hasInternet ?? false)) {
      return;
    }

    _contactUs = await _generalService.getContact(dio: _dioController!);

    notifyListeners();
  }

  getFaqs() async {
    if (_connectivityController == null) {
      return;
    }

    if (_dioController == null) {
      return;
    }

    if (!(_connectivityController?.hasInternet ?? false)) {
      return;
    }

    _faq = await _generalService.getFaq(dio: _dioController!);

    notifyListeners();
  }

  getTerms() async {
    if (_connectivityController == null) {
      return;
    }

    if (_dioController == null) {
      return;
    }

    if (!(_connectivityController?.hasInternet ?? false)) {
      return;
    }

    _terms = await _generalService.getTerm(dio: _dioController!);

    notifyListeners();
  }

  getPrivacy() async {
    if (_connectivityController == null) {
      return;
    }

    if (_dioController == null) {
      return;
    }

    if (!(_connectivityController?.hasInternet ?? false)) {
      return;
    }

    _privacy = await _generalService.getPolicy(dio: _dioController!);

    notifyListeners();
  }

  Future<List<JobTitleModel>> getJobTitles({required String categoryId}) async {
    if (_connectivityController == null) {
      return [];
    }

    if (_dioController == null) {
      return [];
    }

    if (!(_connectivityController?.hasInternet ?? false)) {
      return [];
    }

    return await _generalService.getJobTitles(
      dio: _dioController!,
      categoryId: categoryId,
    );
  }

  Future<List<CityModel>> getCities({required String countryId}) async {
    if (_connectivityController == null) {
      return [];
    }

    if (_dioController == null) {
      return [];
    }

    if (!(_connectivityController?.hasInternet ?? false)) {
      return [];
    }

    return await _generalService.getCities(
      dio: _dioController!,
      countryId: countryId,
    );
  }

  /// Data
  bool _isLoadingAllJobCategories = false;
  bool get isLoadingAllJobCategories => _isLoadingAllJobCategories;

  final List<JobCategoryModel> _allCategories = [];
  List<JobCategoryModel> get allCategories => _allCategories;

  bool _isLoadingBlogCategories = false;
  bool get isLoadingBlogCategories => _isLoadingBlogCategories;

  final List<BlogCategoryModel> _blogCategories = [];
  List<BlogCategoryModel> get blogCategories => _blogCategories;

  bool _isLoadingFeatureJobCategories = false;
  bool get isLoadingFeatureJobCategories => _isLoadingFeatureJobCategories;

  final List<JobCategoryModel> _featureCategories = [];
  List<JobCategoryModel> get featureCategories => _featureCategories;

  bool _isLoadingCompany = false;
  bool get isLoadingCompany => _isLoadingCompany;

  final List<CompanyModel> _companies = [];
  List<CompanyModel> get companies => _companies;

  bool _isLoadingCountries = false;
  bool get isLoadingCountries => _isLoadingCountries;

  final List<CountryModel> _countries = [];
  List<CountryModel> get countries => _countries;

  bool _isLoadingJobTypes = false;
  bool get isLoadingJobTypes => _isLoadingJobTypes;

  final List<JobTypeModel> _jobTypes = [];
  List<JobTypeModel> get jobTypes => _jobTypes;

  bool _isLoadingCareerLevels = false;
  bool get isLoadingCareerLevels => _isLoadingCareerLevels;

  final List<JobTypeModel> _jobCareerLevels = [];
  List<JobTypeModel> get jobCareerLevels => _jobCareerLevels;

  bool _isLoadingSalaries = false;
  bool get isLoadingSalaries => _isLoadingSalaries;

  final List<JobTypeModel> _salaries = [];
  List<JobTypeModel> get salaries => _salaries;

  bool _isLoadingEducationLevels = false;
  bool get isLoadingEducationLevels => _isLoadingEducationLevels;

  final List<JobTypeModel> _educationLevels = [];
  List<JobTypeModel> get educationLevels => _educationLevels;

  bool _isLoadingExperienceLevels = false;
  bool get isLoadingExperienceLevels => _isLoadingExperienceLevels;

  final List<JobTypeModel> _experienceLevels = [];
  List<JobTypeModel> get experienceLevels => _experienceLevels;

  AboutResponseModel? _aboutUs;
  AboutResponseModel? get aboutUs => _aboutUs;

  ContaceResponseModel? _contactUs;
  ContaceResponseModel? get contactUs => _contactUs;

  FaqResponseModel? _faq;
  FaqResponseModel? get faq => _faq;

  TermResponseModel? _terms;
  TermResponseModel? get terms => _terms;

  PolicyResponseModel? _privacy;
  PolicyResponseModel? get privacy => _privacy;
}
