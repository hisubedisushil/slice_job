// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'blog_category.freezed.dart';
part 'blog_category.g.dart';

@freezed
class BlogCategory with _$BlogCategory {
  const factory BlogCategory({
    required final String id,
    final String? parentId,
    final String? catName,
    final String? catSlug,
    final String? date,
    final String? status,
    final String? testField,
  }) = _BlogCategory;

  factory BlogCategory.fromJson(Map<String, dynamic> json) =>
      _$BlogCategoryFromJson(json);
}
