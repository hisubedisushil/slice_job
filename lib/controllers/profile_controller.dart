import 'package:flutter/material.dart';

import '../models/appled_job_model.dart';
import '../models/profile_model.dart';
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
      getAppliedJobs();
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

  Future<bool> updateProfile({
    required String firstName,
    required String lastName,
    required String dob,
    required String nationality,
    required String gender,
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

  /// Data
  bool _isLoadingProfile = false;
  bool get isLoadingProfile => _isLoadingProfile;

  ProfileModel? _profile;
  ProfileModel? get profile => _profile;

  final List<AppliedJobModel> _appliedJobs = [];
  List<AppliedJobModel> get appliedJobs => _appliedJobs;
}
