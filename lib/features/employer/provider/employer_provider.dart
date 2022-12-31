import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slice_job/app/entities/base_state.dart';
import 'package:slice_job/app/entities/failure.dart';
import 'package:slice_job/core/models/base_response.dart';
import 'package:slice_job/core/models/company.dart';
import 'package:slice_job/features/employer/repository/employer_repository.dart';

class EmployerProvider extends StateNotifier<BaseState> {
  EmployerProvider({
    required Ref ref,
  })  : _repository = ref.read(employerRepositoryRef),
        super(const BaseState.initial());

  final EmployerRepository _repository;

  Future<void> getTopEmployers() async {
    state = const BaseState.loading();
    final result = await _repository.getTopEmployers();
    if (result is BaseResponse<List<Company>>) {
      state = BaseState.success(data: result.data);
    } else {
      state = BaseState.error(result.data as Failure);
    }
  }
}
