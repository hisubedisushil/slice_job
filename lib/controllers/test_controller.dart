import 'package:flutter/material.dart';

import '../models/answer_model.dart';
import '../models/test_category_model.dart';
import '../models/test_finish_response_model.dart';
import '../models/test_start_response_model.dart';
import '../services/test_service.dart';
import 'authentication_controller.dart';
import 'connectivity_controller.dart';
import 'dio_controller.dart';

class TestController with ChangeNotifier {
  final ConnectivityController? _connectivityController;
  final AuthenticationController? _authenticationController;
  final DioController? _dioController;

  final _testService = TestService.service;

  TestController(
    this._connectivityController,
    this._authenticationController,
    this._dioController,
  ) {
    if (_connectivityController != null &&
        _authenticationController != null &&
        _dioController != null) {
      getTestCategories();
    }
  }

  getTestCategories() async {
    if (_isLoadingCategories) {
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

    _isLoadingCategories = true;
    try {
      notifyListeners();
    } catch (e) {}

    final model = await _testService.getTestCategories(
      dio: _dioController!,
    );

    if (model != null) {
      _categories
        ..clear()
        ..addAll(model.data ?? []);
    }

    _isLoadingCategories = false;
    try {
      notifyListeners();
    } catch (e) {}
  }

  Future<TestStartResponseModel?> getTestStart({
    required String categoryId,
  }) async {
    if (_connectivityController == null) {
      return null;
    }

    if (_dioController == null) {
      return null;
    }

    if (!(_connectivityController?.hasInternet ?? false)) {
      return null;
    }

    return await _testService.testStart(
      dio: _dioController!,
      category: categoryId,
    );
  }

  Future<TestFinishResponseModel?> getTestFinish({
    required String categoryId,
    required String entranceSet,
    required List<AnswerModel> answers,
  }) async {
    if (_connectivityController == null) {
      return null;
    }

    if (_dioController == null) {
      return null;
    }

    if (!(_connectivityController?.hasInternet ?? false)) {
      return null;
    }

    List<Map<String, dynamic>> results = [];
    for (final ans in answers) {
      results.add({
        "id": ans.id,
        "qno": ans.qno,
        "question": ans.question,
        "answer": ans.answer,
        "option": ans.option,
        "txt": ans.txt,
      });
    }

    return await _testService.testFinish(
      dio: _dioController!,
      requestBody: {
        "category_id": categoryId,
        "entrance_set": entranceSet,
        "entrance_result": results,
      },
    );
  }

  /// Data
  bool _isLoadingCategories = false;
  bool get isLoadingCategories => _isLoadingCategories;

  final List<TestCategoryModel> _categories = [];
  List<TestCategoryModel> get categories => _categories;
}
