// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'job_search.freezed.dart';
part 'job_search.g.dart';

@freezed
class JobSearch with _$JobSearch {
  const factory JobSearch({
    final String? jobTitle,
    final String? jobCategory,
    final String? jobType,
    final String? careerLevel,
    final String? jobSalary,
    final String? educationLevel,
    final String? experience,
  }) = _JobSearch;

  factory JobSearch.fromJson(Map<String, dynamic> json) =>
      _$JobSearchFromJson(json);
}

extension JobSearchX on JobSearch {
  int filterCount() {
    final filterPropMap = toJson();
    final filterPropertyCount = filterPropMap.entries
        .where((element) => element.key != 'job_title')
        .length;
    return filterPropertyCount;
  }
}
