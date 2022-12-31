import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slice_job/app/entities/base_state.dart';
import 'package:slice_job/app/entities/failure.dart';
import 'package:slice_job/core/models/base_response.dart';
import 'package:slice_job/core/models/job_category.dart';
import 'package:slice_job/features/job_category/repository/job_category_repository.dart';

class JobCategoryProvider extends StateNotifier<BaseState> {
  JobCategoryProvider({
    required Ref ref,
  })  : _repository = ref.read(jobCategoryRepositoryRef),
        super(const BaseState.initial());

  final JobCategoryRepository _repository;

  Future<void> getFeaturedJobCategories() async {
    state = const BaseState.loading();
    final result = await _repository.getFeaturedJobCategories();
    if (result is BaseResponse<List<JobCategory>>) {
      state = BaseState.success(data: result.data);
    } else {
      state = BaseState.error(result.data as Failure);
    }
  }
}
