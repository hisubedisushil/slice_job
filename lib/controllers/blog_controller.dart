import 'package:flutter/material.dart';

import '../models/blog_model.dart';
import '../models/blogs_response_model.dart';
import '../services/blog_service.dart';
import 'connectivity_controller.dart';
import 'dio_controller.dart';

class BlogController with ChangeNotifier {
  final ConnectivityController? _connectivityController;
  final DioController? _dioController;

  final _blogService = BlogService.service;

  BlogController(
    this._connectivityController,
    this._dioController,
  ) {
    if (_connectivityController != null && _dioController != null) {
      getAllBlogs();
    }
  }

  getAllBlogs({bool init = true}) async {
    if (_isLoadingAllBlogs) {
      return;
    }

    if (_isMoreBlogs) {
      return;
    }

    if (!_canLoadMoreBlogs && !init) {
      return;
    }

    if (_connectivityController == null) {
      return;
    }

    if (_dioController == null) {
      return;
    }

    if (!(_connectivityController?.hasInternet ?? false)) {
      return;
    }

    if (init) {
      _allPage = 1;
      _isLoadingAllBlogs = true;
    } else {
      _allPage++;
      _isMoreBlogs = true;
    }
    try {
      notifyListeners();
    } catch (e) {}

    BlogsResponseModel? model = await _blogService.getAllBlogs(
      dio: _dioController!,
      page: _allPage,
    );

    if ((model?.data ?? []).isNotEmpty) {
      _canLoadMoreBlogs = true;
    } else {
      _canLoadMoreBlogs = false;
    }

    if (init) {
      _allBlogs
        ..clear()
        ..addAll(model?.data ?? []);
      _isLoadingAllBlogs = false;
    } else {
      _allBlogs.addAll(model?.data ?? []);
      _isMoreBlogs = false;
    }

    try {
      notifyListeners();
    } catch (e) {}
  }

  Future<List<BlogModel>> searchBlogsByCategory({
    int page = 1,
    required String id,
  }) async {
    if (_connectivityController == null) {
      return [];
    }

    if (_dioController == null) {
      return [];
    }

    if (!(_connectivityController?.hasInternet ?? false)) {
      return [];
    }

    BlogsResponseModel? model = await _blogService.getBlogsByCategory(
      dio: _dioController!,
      page: page,
      categoryId: id,
    );

    return model?.data ?? [];
  }

  Future<BlogModel?> getBlogDetail({required String blogId}) async {
    if (_connectivityController == null) {
      return null;
    }

    if (_dioController == null) {
      return null;
    }

    if (!(_connectivityController?.hasInternet ?? false)) {
      return null;
    }

    return await _blogService.getBlogDetail(
      dio: _dioController!,
      blogId: blogId,
    );
  }

  /// Data
  bool _isLoadingAllBlogs = false;
  bool get isLoadingAllBlogs => _isLoadingAllBlogs;

  bool _isMoreBlogs = false;
  bool get isMoreBlogs => _isMoreBlogs;

  bool _canLoadMoreBlogs = true;
  bool get canLoadMoreBlogs => _canLoadMoreBlogs;

  int _allPage = 1;
  final List<BlogModel> _allBlogs = [];
  List<BlogModel> get allBlogs => _allBlogs;
}
