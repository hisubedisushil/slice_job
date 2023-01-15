import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slice_job/app/entities/base_state.dart';
import 'package:slice_job/app/entities/failure.dart';
import 'package:slice_job/core/models/base_response.dart';
import 'package:slice_job/core/models/profile/applied_job_response.dart';
import 'package:slice_job/core/models/profile/profile_response.dart';
import 'package:slice_job/features/profile/repository/profile_repository.dart';

class ProfileProvider extends StateNotifier<BaseState> {
  ProfileProvider({
    required Ref ref,
  })  : _repository = ref.read(profileRepositoryRef),
        super(
          const BaseState.initial(),
        );

  final ProfileRepository _repository;

  Future<void> getProfile() async {
    state = const BaseState.loading();
    final result = await _repository.getUserProfile();
    if (result is BaseResponse<Profile>) {
      state = BaseState.success(data: result.data);
    } else {
      state = BaseState.error(result.data as Failure);
    }
  }

  Future<void> uploadProfileImage(String profileImage) async {
    state = const BaseState.loading();
    final result = await _repository.uploadProfileImage(profileImage);
    if (result is BaseResponse<String>) {
      state = BaseState.success(data: result.data);
    } else {
      state = BaseState.error(result.data as Failure);
    }
  }

  Future<void> getAppliedJobs() async {
    state = const BaseState.loading();
    final result = await _repository.getAppliedJobs();
    if (result is BaseResponse<List<AppliedJobs>>) {
      state = BaseState.success(data: result.data);
    } else {
      state = BaseState.error(result.data as Failure);
    }
  }
}
