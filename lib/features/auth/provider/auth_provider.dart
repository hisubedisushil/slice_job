import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slice_job/app/entities/app_entities.dart';
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
}
