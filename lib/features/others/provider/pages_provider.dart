import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slice_job/app/entities/base_state.dart';
import 'package:slice_job/app/entities/failure.dart';
import 'package:slice_job/core/models/base_response.dart';
import 'package:slice_job/core/models/others/about.dart';
import 'package:slice_job/core/models/others/contact.dart';
import 'package:slice_job/core/models/others/faq.dart';
import 'package:slice_job/features/others/repository/pages_repository.dart';

class PagesProvider extends StateNotifier<BaseState> {
  PagesProvider({
    required Ref ref,
  })  : _repository = ref.read(pagesRepositoryRef),
        super(const BaseState.initial());

  final PagesRepository _repository;
  Future<void> getAboutInfo() async {
    state = const BaseState.loading();
    final result = await _repository.getAboutInfo();
    if (result is BaseResponse<About>) {
      state = BaseState.success(data: result.data);
    } else {
      state = BaseState.error(result.data as Failure);
    }
  }

  Future<void> getContactInfo() async {
    state = const BaseState.loading();
    final result = await _repository.getContactInfo();
    if (result is BaseResponse<Contact>) {
      state = BaseState.success(data: result.data);
    } else {
      state = BaseState.error(result.data as Failure);
    }
  }

  Future<void> getFaqs() async {
    state = const BaseState.loading();
    final result = await _repository.getFaqs();
    if (result is BaseResponse<List<Faq>>) {
      state = BaseState.success(data: result.data);
    } else {
      state = BaseState.error(result.data as Failure);
    }
  }

  Future<void> getPrivacyPolicy() async {
    state = const BaseState.loading();
    final result = await _repository.getPrivacyPolicy();
    if (result is BaseResponse<About>) {
      state = BaseState.success(data: result.data);
    } else {
      state = BaseState.error(result.data as Failure);
    }
  }

  Future<void> getTermsInfo() async {
    state = const BaseState.loading();
    final result = await _repository.getTermsInfo();
    if (result is BaseResponse<About>) {
      state = BaseState.success(data: result.data);
    } else {
      state = BaseState.error(result.data as Failure);
    }
  }
}
