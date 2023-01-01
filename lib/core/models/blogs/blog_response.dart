// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'blog_response.freezed.dart';
part 'blog_response.g.dart';

@freezed
class Blog with _$Blog {
  const factory Blog({
    required final String id,
    final String? title,
    final String? subTitle,
    final String? shortDesc,
    final String? detailDesc,
    final String? slug,
    final String? image,
    final String? type,
    final String? articleBy,
    final String? byDesc,
    final String? addDate,
    final String? categoryId,
    final String? categoryName,
    final String? link,
  }) = _Blog;

  factory Blog.fromJson(Map<String, dynamic> json) => _$BlogFromJson(json);
}
