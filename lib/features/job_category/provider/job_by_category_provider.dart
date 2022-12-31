import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slice_job/app/entities/base_state.dart';
import 'package:slice_job/app/entities/failure.dart';
import 'package:slice_job/core/models/base_response.dart';
import 'package:slice_job/core/models/job.dart';
import 'package:slice_job/features/jobs/repository/job_repository.dart';

class JobByCategoryProvider extends StateNotifier<BaseState> {
  JobByCategoryProvider({
    required Ref ref,
  })  : _repository = ref.read(jobRepositoryRef),
        super(const BaseState.initial());

  final JobRepository _repository;

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
      state = BaseState.success(data: result);
    } else {
      state = BaseState.error(result.data as Failure);
    }
  }
}
