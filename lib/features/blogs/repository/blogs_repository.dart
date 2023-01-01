import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slice_job/app/entities/failure.dart';
import 'package:slice_job/app/urls.dart';
import 'package:slice_job/app_setup/dio/dio_util.dart';
import 'package:slice_job/app_setup/dio/interceptors/dio_helper.dart';
import 'package:slice_job/core/models/base_response.dart';
import 'package:slice_job/core/models/blogs/blog_category.dart';
import 'package:slice_job/core/models/blogs/blog_response.dart';

final blogsRepositoryRef = Provider<BlogsRepository>((ref) {
  return BlogsRepositoryImpl(ref);
});

abstract class BlogsRepository {
  Future<BaseResponsePaginated> getAllBlogs({
    required int page,
  });
  Future<BaseResponse> getBlogDetail(String blogId);
  Future<BaseResponse> getBlogCategory();
  Future<BaseResponsePaginated> getBlogsByCategory({
    required String blogCategoryId,
    required int page,
  });
}

class BlogsRepositoryImpl implements BlogsRepository {
  BlogsRepositoryImpl(Ref ref) : _ref = ref;
  final Ref _ref;

  DioHelper get _api => _ref.read(dioHelper);

  @override
  Future<BaseResponsePaginated> getAllBlogs({
    required int page,
  }) async {
    final response = await _api.request<Map<String, dynamic>>(
      reqType: DIO_METHOD.GET,
      endpoint: getAllBlogsEndpoint,
      authType: AuthType.NONE,
      queryParam: {
        'page': page,
      },
    );

    return response.fold((s) {
      if (s['status']) {
        final data = BaseResponsePaginated.fromJson(
          s,
          (p0) {
            final json = p0 as List<dynamic>;
            final blogsList = json.map((e) => Blog.fromJson(e)).toList();
            return blogsList;
          },
        );
        return data;
      } else {
        final message = s['message'] as String;
        final failure = Failure(
          message,
          FailureType.response,
        );
        return BaseResponsePaginated(
          status: false,
          message: message,
          data: failure,
          page: '1',
          total: '0',
        );
      }
    }, (f) {
      final errorMessage = f.reason;
      return BaseResponsePaginated(
        status: false,
        message: errorMessage,
        data: f,
        page: '1',
        total: '0',
      );
    });
  }

  @override
  Future<BaseResponse> getBlogDetail(String blogId) async {
    final response = await _api.request<Map<String, dynamic>>(
      reqType: DIO_METHOD.GET,
      endpoint: blogDetailEndpoint,
      authType: AuthType.NONE,
      queryParam: {
        'id': blogId,
      },
    );
    return response.fold((s) {
      if (s['status']) {
        final data = BaseResponse.fromJson(
          s,
          (p0) {
            final json = p0 as Map<String, dynamic>;
            final blogDetail = Blog.fromJson(json);
            return blogDetail;
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
  Future<BaseResponse> getBlogCategory() async {
    final response = await _api.request<Map<String, dynamic>>(
      reqType: DIO_METHOD.GET,
      endpoint: blogCategoryEndpoint,
      authType: AuthType.NONE,
    );

    return response.fold((s) {
      if (s['status']) {
        final data = BaseResponse.fromJson(
          s,
          (p0) {
            final json = p0 as List<dynamic>;
            final blogCategoryList =
                json.map((e) => BlogCategory.fromJson(e)).toList();
            return blogCategoryList;
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
  Future<BaseResponsePaginated> getBlogsByCategory({
    required String blogCategoryId,
    required int page,
  }) async {
    final response = await _api.request<Map<String, dynamic>>(
      reqType: DIO_METHOD.GET,
      endpoint: getBlogsByCategoryEndpoint,
      authType: AuthType.NONE,
      queryParam: {
        'page': page,
        'category_id': blogCategoryId,
      },
    );

    return response.fold((s) {
      if (s['status']) {
        final data = BaseResponsePaginated.fromJson(
          s,
          (p0) {
            final json = p0 as List<dynamic>;
            final blogsList = json.map((e) => Blog.fromJson(e)).toList();
            return blogsList;
          },
        );
        return data;
      } else {
        final message = s['message'] as String;
        final failure = Failure(
          message,
          FailureType.response,
        );
        return BaseResponsePaginated(
          status: false,
          message: message,
          data: failure,
          page: page.toString(),
          total: '0',
        );
      }
    }, (f) {
      final errorMessage = f.reason;
      return BaseResponsePaginated(
        status: false,
        message: errorMessage,
        data: f,
        page: page.toString(),
        total: '0',
      );
    });
  }
}
