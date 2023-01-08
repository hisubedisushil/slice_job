import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slice_job/app/entities/failure.dart';
import 'package:slice_job/app/urls.dart';
import 'package:slice_job/app_setup/dio/dio_util.dart';
import 'package:slice_job/app_setup/dio/interceptors/dio_helper.dart';
import 'package:slice_job/core/models/base_response.dart';
import 'package:slice_job/core/models/others/about.dart';
import 'package:slice_job/core/models/others/contact.dart';
import 'package:slice_job/core/models/others/faq.dart';

final pagesRepositoryRef = Provider<PagesRepository>((ref) {
  return PagesRepositoryImpl(ref);
});

abstract class PagesRepository {
  Future<BaseResponse> getAboutInfo();
  Future<BaseResponse> getContactInfo();
  Future<BaseResponse> getFaqs();
  Future<BaseResponse> getPrivacyPolicy();
  Future<BaseResponse> getTermsInfo();
}

class PagesRepositoryImpl implements PagesRepository {
  PagesRepositoryImpl(Ref ref) : _ref = ref;
  final Ref _ref;

  DioHelper get _api => _ref.read(dioHelper);

  @override
  Future<BaseResponse> getAboutInfo() async {
    final response = await _api.request<Map<String, dynamic>>(
      reqType: DIO_METHOD.GET,
      endpoint: aboutEndpoint,
      authType: AuthType.NONE,
    );
    return response.fold((s) {
      if (s['status']) {
        final data = BaseResponse.fromJson(
          s,
          (p0) {
            final json = p0 as Map<String, dynamic>;
            final aboutInfo = About.fromJson(json);
            return aboutInfo;
          },
        );
        return data;
      } else {
        final message = s['message'] as String;
        final failure = Failure(
          message,
          FailureType.response,
        );
        return BaseResponse(status: false, message: message, data: failure);
      }
    }, (f) {
      final errorMessage = f.reason;
      return BaseResponse(status: false, message: errorMessage, data: f);
    });
  }

  @override
  Future<BaseResponse> getContactInfo() async {
    final response = await _api.request<Map<String, dynamic>>(
      reqType: DIO_METHOD.GET,
      endpoint: contactUsEndpoint,
      authType: AuthType.NONE,
    );
    return response.fold((s) {
      if (s['status']) {
        final data = BaseResponse.fromJson(
          s,
          (p0) {
            final json = p0 as Map<String, dynamic>;
            final contactInfo = Contact.fromJson(json);
            return contactInfo;
          },
        );
        return data;
      } else {
        final message = s['message'] as String;
        final failure = Failure(
          message,
          FailureType.response,
        );
        return BaseResponse(status: false, message: message, data: failure);
      }
    }, (f) {
      final errorMessage = f.reason;
      return BaseResponse(status: false, message: errorMessage, data: f);
    });
  }

  @override
  Future<BaseResponse> getFaqs() async {
    final response = await _api.request<Map<String, dynamic>>(
      reqType: DIO_METHOD.GET,
      endpoint: faqsEndpoint,
      authType: AuthType.NONE,
    );
    return response.fold((s) {
      if (s['status']) {
        final data = BaseResponse.fromJson(
          s,
          (p0) {
            final json = p0 as List<dynamic>;
            final faqs = json.map((e) => Faq.fromJson(e)).toList();
            return faqs;
          },
        );
        return data;
      } else {
        final message = s['message'] as String;
        final failure = Failure(
          message,
          FailureType.response,
        );
        return BaseResponse(status: false, message: message, data: failure);
      }
    }, (f) {
      final errorMessage = f.reason;
      return BaseResponse(status: false, message: errorMessage, data: f);
    });
  }

  @override
  Future<BaseResponse> getPrivacyPolicy() async {
    final response = await _api.request<Map<String, dynamic>>(
      reqType: DIO_METHOD.GET,
      endpoint: policyEndpoint,
      authType: AuthType.NONE,
    );
    return response.fold((s) {
      if (s['status']) {
        final data = BaseResponse.fromJson(
          s,
          (p0) {
            final json = p0 as Map<String, dynamic>;
            final privacyInfo = About.fromJson(json);
            return privacyInfo;
          },
        );
        return data;
      } else {
        final message = s['message'] as String;
        final failure = Failure(
          message,
          FailureType.response,
        );
        return BaseResponse(status: false, message: message, data: failure);
      }
    }, (f) {
      final errorMessage = f.reason;
      return BaseResponse(status: false, message: errorMessage, data: f);
    });
  }

  @override
  Future<BaseResponse> getTermsInfo() async {
    final response = await _api.request<Map<String, dynamic>>(
      reqType: DIO_METHOD.GET,
      endpoint: termsEndpoint,
      authType: AuthType.NONE,
    );
    return response.fold((s) {
      if (s['status']) {
        final data = BaseResponse.fromJson(
          s,
          (p0) {
            final json = p0 as Map<String, dynamic>;
            final termsInfo = About.fromJson(json);
            return termsInfo;
          },
        );
        return data;
      } else {
        final message = s['message'] as String;
        final failure = Failure(
          message,
          FailureType.response,
        );
        return BaseResponse(status: false, message: message, data: failure);
      }
    }, (f) {
      final errorMessage = f.reason;
      return BaseResponse(status: false, message: errorMessage, data: f);
    });
  }
}
