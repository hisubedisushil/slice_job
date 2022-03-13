import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pretty_json/pretty_json.dart';

import '../controllers/dio_controller.dart';
import '../models/blog_detail_response_model.dart';
import '../models/blog_model.dart';
import '../models/blogs_response_model.dart';

class BlogService {
  static BlogService service = BlogService();

  Future<BlogsResponseModel?> getAllBlogs({
    required DioController dio,
    int page = 1,
  }) async {
    try {
      Response response = await dio.dioClient.get('all-blogs?page=$page');
      log(
        prettyJson(response.data),
        name: 'Get All Blogs Response Page #$page',
      );
      if (response.statusCode == 200) {
        BlogsResponseModel model = blogsResponseModelFromJson(
          jsonEncode(response.data),
        );
        return model;
      } else {
        return null;
      }
    } on Exception catch (e, s) {
      log('Get All Blogs Error! Page #$page', stackTrace: s, error: e);
      return null;
    }
  }

  Future<BlogsResponseModel?> getBlogsByCategory({
    required DioController dio,
    int page = 1,
    required String categoryId,
  }) async {
    try {
      Response response = await dio.dioClient.get(
        'category-blogs?category_id=$categoryId&page=$page',
      );
      log(
        prettyJson(response.data),
        name: 'Get Blogs By Category Response Page #$page',
      );
      if (response.statusCode == 200) {
        BlogsResponseModel model = blogsResponseModelFromJson(
          jsonEncode(response.data),
        );
        return model;
      } else {
        return null;
      }
    } on Exception catch (e, s) {
      log('Get Blogs By Category Error! Page #$page', stackTrace: s, error: e);
      return null;
    }
  }

  Future<BlogModel?> getBlogDetail({
    required DioController dio,
    required String blogId,
  }) async {
    try {
      Response response = await dio.dioClient.post('blog-detail?id=$blogId');
      log(prettyJson(response.data), name: 'Get Blog Detail Response');
      if (response.statusCode == 200) {
        BlogDetailResponseModel model = blogDetailResponseModelFromJson(
          jsonEncode(response.data),
        );
        return model.data;
      } else {
        return null;
      }
    } on Exception catch (e, s) {
      log('Get Blog Detail Error!', stackTrace: s, error: e);
      return null;
    }
  }
}
