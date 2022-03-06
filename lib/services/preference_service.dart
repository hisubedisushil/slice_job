import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_preferences.dart';
import '../models/login_response_model.dart';

class PreferenceService {
  static PreferenceService service = PreferenceService();

  SharedPreferences? _sharedPreferences;

  _initSharedPreferences() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  setUser(LoginResponseData model) async {
    await _initSharedPreferences();
    _sharedPreferences?.setString(
      AppPreferences.apiToken,
      model.token ?? '',
    );

    _sharedPreferences?.setString(
      AppPreferences.appUser,
      dataToJson(model),
    );

    _sharedPreferences?.setBool(
      AppPreferences.isLogin,
      true,
    );
  }

  clearPreferences() async {
    await _initSharedPreferences();
    _sharedPreferences?.clear();
  }

  Future<bool> get isLogin async {
    await _initSharedPreferences();
    return _sharedPreferences?.getBool(AppPreferences.isLogin) ?? false;
  }

  Future<String> get token async {
    await _initSharedPreferences();
    return _sharedPreferences?.getString(AppPreferences.apiToken) ?? '';
  }

  Future<LoginResponseData> get appUser async {
    await _initSharedPreferences();
    return dataFromJson(
      _sharedPreferences?.getString(AppPreferences.appUser) ?? '{}',
    );
  }
}
