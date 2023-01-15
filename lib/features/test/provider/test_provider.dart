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

  Future<void> startTest(String category) async {
    state = const BaseState.loading();
    final result = await _repository.startTest(category);
    if (result is BaseResponse<Test>) {
      state = BaseState.success(data: result.data);
    } else {
      state = BaseState.error(result.data as Failure);
    }
  }

  Future<void> finishTest({
    required String entranceSet,
    required String categoryId,
    required List<Answer> answers,
  }) async {
    state = const BaseState.loading();
    final answersJson = answers.map((e) => e.toJson()).toList();
    final reqBody = <String, dynamic>{
      'category_id': categoryId,
      'entrance_set': entranceSet,
      'entrance_result': answersJson,
    };
    final result = await _repository.finishTest(reqBody);
    if (result is BaseResponse<TestResult>) {
      state = BaseState.success(data: result.data);
    } else {
      state = BaseState.error(result.data as Failure);
    }
  }
}
