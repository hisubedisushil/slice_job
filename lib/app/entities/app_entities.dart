import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:slice_job/app/entities/failure.dart';

part 'app_entities.freezed.dart';

@freezed
class AppState<T> with _$AppState<T> {
  const factory AppState.started() = AppStarted<T>;
  const factory AppState.authenticated(T data,
      {@Default(false) bool isNavigate}) = Authenticated<T>;
  const factory AppState.unAuthenticated({
    Failure? failure,
    @Default(false) bool isNavigate,
  }) = UnAuthenticated<T>;
}
