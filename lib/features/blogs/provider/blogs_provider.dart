import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slice_job/app/entities/base_state.dart';
import 'package:slice_job/app/entities/failure.dart';
import 'package:slice_job/core/models/base_response.dart';
import 'package:slice_job/core/models/blogs/blog_category.dart';
import 'package:slice_job/core/models/blogs/blog_response.dart';
import 'package:slice_job/features/blogs/repository/blogs_repository.dart';

class BlogsProvider extends StateNotifier<BaseState> {
  BlogsProvider({
    required Ref ref,
  })  : _repository = ref.read(blogsRepositoryRef),
        super(const BaseState.initial());

  final BlogsRepository _repository;

  Future<void> getAllBlogs({
    int page = 0,
  }) async {
    state = const BaseState.loading();
    final result = await _repository.getAllBlogs(
      page: page,
    );
    if (result is BaseResponsePaginated<List<Blog>>) {
      state = BaseState.success(data: result);
    } else {
      state = BaseState.error(result.data as Failure);
    }
  }

  Future<void> getBlogDetail({
    required String blogId,
  }) async {
    state = const BaseState.loading();
    final result = await _repository.getBlogDetail(blogId);
    if (result is BaseResponse<Blog>) {
      state = BaseState.success(data: result.data);
    } else {
      state = BaseState.error(result.data as Failure);
    }
  }

  Future<void> getBlogCategory() async {
    state = const BaseState.loading();
    final result = await _repository.getBlogCategory();
    if (result is BaseResponse<List<BlogCategory>>) {
      state = BaseState.success(data: result.data);
    } else {
      state = BaseState.error(result.data as Failure);
    }
  }

  Future<void> getBlogsByCategory({
    required String blogCategoryId,
    int page = 0,
  }) async {
    state = const BaseState.loading();
    final result = await _repository.getBlogsByCategory(
      blogCategoryId: blogCategoryId,
      page: page,
    );
    if (result is BaseResponsePaginated<List<Blog>>) {
      state = BaseState.success(data: result);
    } else {
      state = BaseState.error(result);
    }
  }
}
