import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:slice_job/app/entities/failure.dart';
import 'package:slice_job/core/models/authentication/login_response.dart';

part 'app_entities.freezed.dart';

@freezed
class AppState with _$AppState {
  const factory AppState.initial() = AppStarted;
  const factory AppState.authenticated(AuthData data) = Authenticated;
  const factory AppState.unAuthenticated({
    Failure? failure,
  }) = UnAuthenticated;
}

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    required final bool isInitial,
    required final bool isAuthenticating,
    required final bool isAuthenticated,
    final AuthData? authData,
  }) = _AuthState;
}
