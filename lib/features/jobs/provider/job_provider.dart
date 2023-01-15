import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slice_job/app/entities/base_state.dart';
import 'package:slice_job/app/entities/failure.dart';
import 'package:slice_job/core/models/base_response.dart';
import 'package:slice_job/core/models/company.dart';
import 'package:slice_job/core/models/country.dart';
import 'package:slice_job/core/models/job.dart';
import 'package:slice_job/core/models/job_category.dart';
import 'package:slice_job/core/models/job_detail.dart';
import 'package:slice_job/features/job_category/repository/job_category_repository.dart';
import 'package:slice_job/features/jobs/models/job_search.dart';
import 'package:slice_job/features/jobs/repository/job_repository.dart';

final jobTypesRef = StateProvider<List<JobType>>((ref) {
  return [];
});
final jobCareerLevelsRef = StateProvider<List<JobType>>((ref) {
  return [];
});
final jobSalariesRef = StateProvider<List<JobType>>((ref) {
  return [];
});
final jobEducationLevelsRef = StateProvider<List<JobType>>((ref) {
  return [];
});
final jobExperienceLevelsRef = StateProvider<List<JobType>>((ref) {
  return [];
});
final allCategoriesRef = StateProvider<List<JobCategory>>((ref) {
  return [];
});
final countriesRef = StateProvider<List<Country>>((ref) {
  return [];
});

class JobProvider extends StateNotifier<BaseState> {
  JobProvider({
    required this.ref,
  })  : _repository = ref.read(jobRepositoryRef),
        _jobCategoryrepository = ref.read(jobCategoryRepositoryRef),
        super(const BaseState.initial());

  final Ref ref;

  final JobRepository _repository;
  final JobCategoryRepository _jobCategoryrepository;

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
    int page = 1,
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

  Future<void> searchJobs({
    int page = 1,
    required JobSearch search,
  }) async {
    state = const BaseState.loading();
    final result = await _repository.searchJobs(
      page: page,
      search: search,
    );
    if (result is BaseResponsePaginated<List<Job>>) {
      state = BaseState.success(data: result);
    } else {
      state = BaseState.error(result);
    }
  }

  Future<void> getJobTypes() async {
    final result = await _repository.getJobTypes();
    if (result is BaseResponse<List<JobType>>) {
      ref.read(jobTypesRef).addAll(result.data);
    } else {}
  }

  Future<void> getJobCareerLevels() async {
    final result = await _repository.getJobCareerLevels();
    if (result is BaseResponse<List<JobType>>) {
      ref.read(jobCareerLevelsRef).addAll(result.data);
    } else {}
  }

  Future<void> getJobSalaries() async {
    final result = await _repository.getJobSalaries();
    if (result is BaseResponse<List<JobType>>) {
      ref.read(jobSalariesRef).addAll(result.data);
    } else {}
  }

  Future<void> getJobEducationLevels() async {
    final result = await _repository.getJobEducationLevels();
    if (result is BaseResponse<List<JobType>>) {
      ref.read(jobEducationLevelsRef).addAll(result.data);
    } else {}
  }

  Future<void> getJobExperienceLevels() async {
    final result = await _repository.getJobExperienceLevels();
    if (result is BaseResponse<List<JobType>>) {
      ref.read(jobExperienceLevelsRef).addAll(result.data);
    } else {}
  }

  Future<void> getJobCategories() async {
    final result = await _jobCategoryrepository.getJobCategories();
    if (result is BaseResponse<List<JobCategory>>) {
      ref.read(allCategoriesRef).addAll(result.data);
    } else {}
  }

  Future<void> getFilterProperties() async {
    getJobCategories();
    getJobTypes();
    getJobCareerLevels();
    getJobSalaries();
    getJobEducationLevels();
    getJobExperienceLevels();
    getCountries();
  }

  Future<void> getCountries() async {
    final result = await _repository.getCountries();
    if (result is BaseResponse<List<Country>>) {
      ref.read(countriesRef).addAll(result.data);
    } else {}
  }
}
