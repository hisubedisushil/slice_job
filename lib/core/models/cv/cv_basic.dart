// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'cv_basic.freezed.dart';
part 'cv_basic.g.dart';

@freezed
class CVBasic with _$CVBasic {
  const factory CVBasic({
    final String? id,
    final String? userId,
    final String? firstName,
    final String? lastName,
    final String? birthDay,
    final String? birthMonth,
    final String? birthYear,
    final String? gender,
    final String? nationality,
    final String? maritalStatus,
    final String? currentCountry,
    final String? currentCity,
    final String? email,
    final String? contactNumber,
    final String? website,
    final String? jobRole,
    final String? jobTitle,
    final String? careerLevel,
    final String? jobType,
    final String? targetSalary,
    final String? targetSalaryCurrency,
    final String? updateDate,
    final String? privacy,
    final String? testField,
  }) = _CVBasic;

  factory CVBasic.fromJson(Map<String, dynamic> json) =>
      _$CVBasicFromJson(json);
}
