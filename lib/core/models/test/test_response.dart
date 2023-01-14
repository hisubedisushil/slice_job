// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'test_response.freezed.dart';
part 'test_response.g.dart';

@freezed
class TestCategory with _$TestCategory {
  const factory TestCategory({
    required final String id,
    final String? type,
    final String? name,
    final String? slug,
    final String? description,
    final String? image,
    final String? metaTitle,
    final String? metaKeywords,
    final String? metaDescription,
    final String? metastatusTitle,
    final String? testField,
  }) = _TestCategory;

  factory TestCategory.fromJson(Map<String, dynamic> json) =>
      _$TestCategoryFromJson(json);
}


