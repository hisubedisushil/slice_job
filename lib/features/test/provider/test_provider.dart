import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slice_job/app/entities/base_state.dart';
import 'package:slice_job/app/entities/failure.dart';
import 'package:slice_job/core/models/base_response.dart';
import 'package:slice_job/core/models/test/test_response.dart';
import 'package:slice_job/features/test/repository/test_repository.dart';

class TestProvider extends StateNotifier<BaseState> {
  TestProvider({
    required Ref ref,
  })  : _repository = ref.read(testRepositoryRef),
        super(
          const BaseState.initial(),
        );

  final TestRepository _repository;

  Future<void> getTestCategories() async {
    state = const BaseState.loading();
    final result = await _repository.getTestCategories();
    if (result is BaseResponse<List<TestCategory>>) {
      state = BaseState.success(data: result.data);
    } else {
      state = BaseState.error(result.data as Failure);
    }
  }
}
