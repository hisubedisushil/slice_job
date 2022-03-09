import 'package:flutter/material.dart';

import '../models/all_jobs_response_model.dart';
import '../models/features_jobs_response_model.dart';
import '../models/job_detail_model.dart';
import '../models/job_model.dart';
import '../services/job_service.dart';
import 'authentication_controller.dart';
import 'connectivity_controller.dart';
import 'dio_controller.dart';

class JobController with ChangeNotifier {
  final ConnectivityController? _connectivityController;
  final AuthenticationController? _authenticationController;
  final DioController? _dioController;

  final _jobService = JobService.service;

  JobController(
    this._connectivityController,
    this._authenticationController,
    this._dioController,
  ) {
    if (_connectivityController != null &&
        _authenticationController != null &&
        _dioController != null) {
      getFeaturedJobs();
      getRecentJobs();
      getAllJobs();
    }
  }

  getAllJobs({bool init = true}) async {
    if (_isLoadingAllJobs) {
      return;
    }

    if (_isMoreAllJobs) {
      return;
    }

    if (!_canLoadMoreAllJobs && !init) {
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

    if (init) {
      _allPage = 1;
      _isLoadingAllJobs = true;
    } else {
      _allPage++;
      _isMoreAllJobs = true;
    }
    notifyListeners();

    AllJobsResponseModel? model = await _jobService.getAllJobs(
      dio: _dioController!,
      page: _allPage,
    );

    if ((model?.data ?? []).isNotEmpty) {
      _canLoadMoreAllJobs = true;
    } else {
      _canLoadMoreAllJobs = false;
    }

    if (init) {
      _allJobs
        ..clear()
        ..addAll(model?.data ?? []);
      _isLoadingAllJobs = false;
    } else {
      _allJobs.addAll(model?.data ?? []);
      _isMoreAllJobs = false;
    }

    notifyListeners();
  }

  getFeaturedJobs() async {
    if (_isLoadingFeaturedJobs) {
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

    _isLoadingFeaturedJobs = true;
    notifyListeners();

    _featuredJobs
      ..clear()
      ..addAll(await _jobService.getFeaturedJobs(dio: _dioController!));

    _isLoadingFeaturedJobs = false;
    notifyListeners();
  }

  getRecentJobs() async {
    if (_isLoadingRecentJobs) {
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

    _isLoadingRecentJobs = true;
    notifyListeners();

    _recentJobs
      ..clear()
      ..addAll(await _jobService.getRecentJobs(dio: _dioController!));

    _isLoadingRecentJobs = false;
    notifyListeners();
  }

  Future<List<JobModel>> getRelatedJobs({required int jobCatId}) async {
    if (_connectivityController == null) {
      return [];
    }

    if (_dioController == null) {
      return [];
    }

    if (!(_connectivityController?.hasInternet ?? false)) {
      return [];
    }

    return await _jobService.getRelatedJobs(
      dio: _dioController!,
      jobCatId: jobCatId,
    );
  }

  Future<JobDetailModel?> getJobDetail({required String jobId}) async {
    if (_connectivityController == null) {
      return null;
    }

    if (_dioController == null) {
      return null;
    }

    if (!(_connectivityController?.hasInternet ?? false)) {
      return null;
    }

    return await _jobService.getJobDetail(
      dio: _dioController!,
      jobId: jobId,
    );
  }

  Future<String?> applyForJob({
    required String jobId,
    required String qualification,
    required String experience,
    String? cv,
    String? letter,
  }) async {
    if (_connectivityController == null) {
      return null;
    }

    if (_dioController == null) {
      return null;
    }

    if (!(_connectivityController?.hasInternet ?? false)) {
      return null;
    }

    return await _jobService.apply(
      dio: _dioController!,
      jobId: jobId,
      qualification: qualification,
      experience: experience,
      cv: cv,
      letter: letter,
    );
  }

  Future<List<JobModel>> searchJobs({
    int page = 1,
    String title = '',
    String category = '',
    String type = '',
    String level = '',
    String salary = '',
    String education = '',
    String experience = '',
  }) async {
    if (_connectivityController == null) {
      return [];
    }

    if (_dioController == null) {
      return [];
    }

    if (!(_connectivityController?.hasInternet ?? false)) {
      return [];
    }

    AllJobsResponseModel? model = await _jobService.getSearchedJobs(
      dio: _dioController!,
      page: page,
      title: title,
      category: category,
      type: type,
      level: level,
      salary: salary,
      education: education,
      experience: experience,
    );

    return model?.data ?? [];
  }

  /// Data
  bool _isLoadingAllJobs = false;
  bool get isLoadingAllJobs => _isLoadingAllJobs;

  bool _isMoreAllJobs = false;
  bool get isMoreAllJobs => _isMoreAllJobs;

  bool _canLoadMoreAllJobs = true;
  bool get canLoadMoreAllJobs => _canLoadMoreAllJobs;

  int _allPage = 1;
  final List<JobModel> _allJobs = [];
  List<JobModel> get allJobs => _allJobs;

  bool _isLoadingFeaturedJobs = false;
  bool get isLoadingFeaturedJobs => _isLoadingFeaturedJobs;

  final List<FeaturedJobData> _featuredJobs = [];
  List<FeaturedJobData> get featuredJobs => _featuredJobs;

  bool _isLoadingRecentJobs = false;
  bool get isLoadingRecentJobs => _isLoadingRecentJobs;

  final List<JobModel> _recentJobs = [];
  List<JobModel> get recentJobs => _recentJobs;
}
