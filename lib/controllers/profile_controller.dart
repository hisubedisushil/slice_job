import 'package:flutter/material.dart';

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

  /// Data
  bool _isLoadingProfile = false;
  bool get isLoadingProfile => _isLoadingProfile;

  ProfileModel? _profile;
  ProfileModel? get profile => _profile;
}
