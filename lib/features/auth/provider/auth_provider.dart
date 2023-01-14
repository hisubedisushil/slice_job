import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slice_job/app/entities/app_entities.dart';
import 'package:slice_job/app/entities/failure.dart';
import 'package:slice_job/core/models/authentication/login_response.dart';
import 'package:slice_job/core/models/authentication/user.dart';
import 'package:slice_job/core/models/base_response.dart';
import 'package:slice_job/features/auth/repository/auth_repository.dart';

class AuthProvider extends StateNotifier<AuthState> {
  AuthProvider({
    required Ref ref,
  })  : _repository = ref.read(authRepositoryRef),
        super(
          const AuthState(
            isInitial: true,
            isAuthenticating: false,
            isAuthenticated: false,
          ),
        );

  final AuthRepository _repository;

  Future<void> getSession() async {
    state = state.copyWith(
      isAuthenticating: true,
      isInitial: false,
    );
    final result = await _repository.getSession();
    state = state.copyWith(
      isAuthenticating: false,
      isAuthenticated: result != null,
      authData: result,
    );
  }

  Future<void> login({
    required String username,
    required String password,
  }) async {
    state = state.copyWith(
      isAuthenticating: true,
      isInitial: false,
    );
    final result = await _repository.login(username, password);
    if (result is BaseResponse<AuthData>) {
      state = state.copyWith(
        isAuthenticating: false,
        isAuthenticated: true,
        authData: result.data,
      );
    } else {
      state = state.copyWith(
        isAuthenticating: false,
        isAuthenticated: false,
        authData: null,
        error: result.data as Failure,
      );
    }
  }

  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
  }) async {
    state = state.copyWith(
      isAuthenticating: true,
      isInitial: false,
    );
    final result = await _repository.register(
      firstName,
      lastName,
      email,
      phone,
      password,
    );
    if (result is BaseResponse<User>) {
      state = state.copyWith(
        isAuthenticating: false,
        isAuthenticated: true,
        authData: null,
        user: result.data,
      );
    } else {
      state = state.copyWith(
        isAuthenticating: false,
        isAuthenticated: false,
        authData: null,
        user: null,
        error: result.data as Failure,
      );
    }
  }

   Future<void> verifyRegister({
    required String email,
    required String phone,
    required String code,
  }) async {
    state = state.copyWith(
      isAuthenticating: true,
      isInitial: false,
    );
    final result = await _repository.registerVerify(
      email,
      phone,
      code,
    );
    if (result is BaseResponse<User>) {
      state = state.copyWith(
        isAuthenticating: false,
        isAuthenticated: true,
        authData: null,
        user: result.data,
      );
    } else {
      state = state.copyWith(
        isAuthenticating: false,
        isAuthenticated: false,
        authData: null,
        user: null,
        error: result.data as Failure,
      );
    }
  }

  void resetError() {
    state = state.copyWith(
      isAuthenticating: false,
      isAuthenticated: false,
      authData: null,
      user: null,
      error: null,
    );
  }
}
