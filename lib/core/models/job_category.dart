import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:slice_job/core/models/job.dart';

part 'job_category.freezed.dart';
part 'job_category.g.dart';

@freezed
class JobCategory with _$JobCategory {
  const factory JobCategory({
    required final String id,
    required final String type,
    required final String name,
    required final String status,
  }) = _JobCategory;

  factory JobCategory.fromJson(Map<String, dynamic> json) =>
      _$JobCategoryFromJson(json);
}

extension JobCategoryX on JobCategory {
  JobType toJobType() {
    return JobType(
      id: id,
      name: name,
      status: status,
    );
  }
}
