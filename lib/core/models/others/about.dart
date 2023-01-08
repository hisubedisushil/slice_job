// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'about.freezed.dart';
part 'about.g.dart';

@freezed
class About with _$About {
  const factory About({
    final String? id,
    final String? category,
    final String? postTitle,
    final String? postDesc,
    final String? updatedBy,
    final String? updatedDate,
    final String? status,
  }) = _About;

  factory About.fromJson(Map<String, dynamic> json) => _$AboutFromJson(json);
}
