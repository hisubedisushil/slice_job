import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:slice_job/app/entities/failure.dart';
part 'base_state.freezed.dart';

@freezed

///
class BaseState<T> with _$BaseState<T> {
  /// Auth initial state
  const factory BaseState.initial() = BaseInitial;

  /// Auth loading state
  const factory BaseState.loading() = BaseLoading;

  /// Auth error state
  const factory BaseState.error(Failure failure) = BaseError;

  /// Auth success state
  const factory BaseState.success({T? data, Map<String, dynamic>? extraData}) = BaseSuccess;
}
