import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slice_job/app_setup/dio/interceptors/dio_helper.dart';
import 'package:slice_job/app_setup/hive/hive_setup.dart';
import 'package:slice_job/core/models/authentication/login_response.dart';

final authRepositoryRef = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(ref);
});

abstract class AuthRepository {
  Future<AuthData?> getSession();
  Future<void> setSession(AuthData session);
}

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(Ref ref) : _ref = ref;
  final Ref _ref;

  DioHelper get _api => _ref.read(dioHelper);
  HiveDB get hive => _ref.read(hiveProvider);

  @override
  Future<AuthData?> getSession() async {
    try {
      final session = await hive.getSession();
      return session;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> setSession(AuthData session) {
    return hive.setSession(session);
  }
}
