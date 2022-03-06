import 'package:flutter/material.dart';

import '../models/login_response_model.dart';
import '../models/register_response_model.dart';
import '../services/authentication_service.dart';
import '../services/preference_service.dart';
import 'connectivity_controller.dart';
import 'dio_controller.dart';

class AuthenticationController with ChangeNotifier {
  final ConnectivityController? _connectivityController;
  final DioController? _dioController;

  final _authenticationService = AuthenticationService.service;
  final _preferenceService = PreferenceService.service;

  AuthenticationController(this._connectivityController, this._dioController) {
    if (_connectivityController != null && _dioController != null) {
      _initLogin();
    }
  }

  _initLogin() async {
    _isLoggedIn = await _preferenceService.isLogin;
    _appUser = await _preferenceService.appUser;
    notifyListeners();
  }

  Future<bool> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
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

    RegisterResponseData? model = await _authenticationService.register(
      dio: _dioController!,
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      rePassword: rePassword,
    );

    if (model == null) {
      return false;
    }

    return true;
  }

  Future<bool> login({
    required String email,
    required String password,
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

    LoginResponseData? model = await _authenticationService.login(
      dio: _dioController!,
      email: email,
      password: password,
    );

    if (model == null) {
      return false;
    }

    await _preferenceService.setUser(model);
    _initLogin();

    return true;
  }

  Future<bool> verify({
    required String email,
    required String pin,
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

    bool b = await _authenticationService.registerVerify(
      dio: _dioController!,
      email: email,
      code: pin,
    );

    return b;
  }

  Future<bool> logOut() async {
    if (_connectivityController == null) {
      return false;
    }

    if (_dioController == null) {
      return false;
    }

    if (!(_connectivityController?.hasInternet ?? false)) {
      return false;
    }

    bool b = await _authenticationService.logout(dio: _dioController!);

    if (b) {
      await _preferenceService.clearPreferences();
      _initLogin();
    }

    return b;
  }

  /// Data
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  LoginResponseData? _appUser;
  LoginResponseData? get appUser => _appUser;
}
