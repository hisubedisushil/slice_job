import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slice_job/app/entities/base_state.dart';
import 'package:slice_job/app/entities/failure.dart';
import 'package:slice_job/core/models/base_response.dart';
import 'package:slice_job/core/models/cv/cv_basic.dart';
import 'package:slice_job/core/models/job.dart';
import 'package:slice_job/features/profile/repository/cv_repository.dart';

final cvBasicRef = StateProvider<CVBasic?>((ref) {
  return;
});

class CVProvider extends StateNotifier<BaseState> {
  CVProvider({
    required this.ref,
  })  : _repository = ref.read(cvRepositoryRef),
        super(
          const BaseState.initial(),
        );

  final Ref ref;

  final CVRepository _repository;

  Future<void> updateCVBasicInfo(Map<String, String> data) async {
    state = const BaseState.loading();
    final result = await _repository.updateCVBasicInfo(data);
    if (result is BaseResponse<bool>) {
      state = BaseState.success(data: result.message);
    } else {
      state = BaseState.error(result.data as Failure);
    }
  }

  Future<void> updateCVContactInfo(Map<String, String> data) async {
    state = const BaseState.loading();
    final result = await _repository.updateCVContactInfo(data);
    if (result is BaseResponse<bool>) {
      state = BaseState.success(data: result.message);
    } else {
      state = BaseState.error(result.data as Failure);
    }
  }

  Future<void> getCVBasicInfo() async {
    final result = await _repository.getCVBasicInfo();
    if (result is BaseResponse<CVBasic>) {
      ref.read(cvBasicRef.notifier).state = result.data;
    }
  }

  Future<void> getJobTitles(String categoryId) async {
    state = const BaseState.loading();
    final result = await _repository.getJobTitles(categoryId);
    if (result is BaseResponse<List<JobTitle>>) {
      state = BaseState.success(data: result.data);
    } else {
      state = BaseState.error(result.data as Failure);
    }
  }

  Future<void> updateCVTargetJob(Map<String, String> data) async {
    state = const BaseState.loading();
    final result = await _repository.updateCVTargetJob(data);
    if (result is BaseResponse<bool>) {
      state = BaseState.success(data: result.message);
    } else {
      state = BaseState.error(result.data as Failure);
    }
  }

  Future<void> addExperience(Map<String, String?> data) async {
    state = const BaseState.loading();
    final result = await _repository.addExperience(data);
    if (result is BaseResponse<bool>) {
      state = BaseState.success(data: result.message);
    } else {
      state = BaseState.error(result.data as Failure);
    }
  }
}
