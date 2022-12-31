import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slice_job/app/entities/base_state.dart';
import 'package:slice_job/app/entities/failure.dart';
import 'package:slice_job/core/models/base_response.dart';
import 'package:slice_job/core/models/company.dart';
import 'package:slice_job/core/models/job.dart';
import 'package:slice_job/core/models/job_detail.dart';
import 'package:slice_job/features/jobs/repository/job_repository.dart';

class JobProvider extends StateNotifier<BaseState> {
  JobProvider({
    required Ref ref,
  })  : _repository = ref.read(jobRepositoryRef),
        super(const BaseState.initial());

  final JobRepository _repository;

  Future<void> getFeaturedJobs() async {
    state = const BaseState.loading();
    final result = await _repository.getFeaturedJobs();
    if (result is BaseResponse<List<Company>>) {
      state = BaseState.success(data: result.data);
    } else {
      state = BaseState.error(result.data as Failure);
    }
  }

  Future<void> getRecentJobs() async {
    state = const BaseState.loading();
    final result = await _repository.getRecentJobs();
    if (result is BaseResponse<List<Job>>) {
      state = BaseState.success(data: result.data);
    } else {
      state = BaseState.error(result.data as Failure);
    }
  }

  Future<void> getJobDetail({
    required String jobKey,
  }) async {
    state = const BaseState.loading();
    final result = await _repository.getJobDetail(jobKey);
    if (result is BaseResponse<JobDetail>) {
      state = BaseState.success(data: result.data);
    } else {
      state = BaseState.error(result.data as Failure);
    }
  }

  Future<void> getJobsByCategory({
    required String jobCategoryId,
    int page = 0,
  }) async {
    state = const BaseState.loading();
    final result = await _repository.getJobsByCategory(
      jobCategoryId: jobCategoryId,
      page: page,
    );
    if (result is BaseResponsePaginated<List<Job>>) {
      state = BaseState.success(data: result.data);
    } else {
      state = BaseState.error(result.data as Failure);
    }
  }
}
