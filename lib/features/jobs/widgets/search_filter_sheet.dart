import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:slice_job/constants/app_colors.dart';
import 'package:slice_job/core/models/job.dart';
import 'package:slice_job/core/models/job_category.dart';
import 'package:slice_job/features/jobs/models/job_search.dart';
import 'package:slice_job/features/jobs/provider/job_provider.dart';
import 'package:slice_job/helpers/constants.dart';
import 'package:slice_job/helpers/extensions/padding_extensions.dart';
import 'package:slice_job/helpers/util/decoration_util.dart';
import 'package:slice_job/helpers/util/util.dart';

class SearchFilterSheet extends ConsumerStatefulWidget {
  final JobSearch filterData;

  final Function(JobSearch) onFilter;

  const SearchFilterSheet({
    Key? key,
    required this.filterData,
    required this.onFilter,
  }) : super(key: key);

  @override
  ConsumerState<SearchFilterSheet> createState() => _SearchFilterSheetState();
}

class _SearchFilterSheetState extends ConsumerState<SearchFilterSheet> {
  final _formKey = GlobalKey<FormBuilderState>();
  late final JobSearch filterData;
  @override
  void initState() {
    super.initState();
    filterData = widget.filterData;
  }

  void _clearFieldByName(String name) {
    _formKey.currentState!.fields[name]?.reset();
  }

  void _onClearAll() {
    const jobSearch = JobSearch();
    final jobSearchMap = jobSearch.toJson();
    for (var field in jobSearchMap.entries) {
      _clearFieldByName(field.key);
    }
    widget.onFilter(const JobSearch());
  }

  JobType? _getFieldValue(String name) {
    return _formKey.currentState!.fields[name]?.value as JobType;
  }

  void _onApplyFilter() {
    final filteredDataMap = <String, dynamic>{};
    filterData.toMap().entries.forEach((entry) {
      final a = _getFieldValue(entry.key)?.name;
      filteredDataMap.putIfAbsent(entry.key, () => a);
    });
    final filteredData = JobSearch.fromJson(filteredDataMap);
    widget.onFilter(
      filteredData,
    );
  }

  @override
  Widget build(BuildContext context) {
    final jobCategoryOptions =
        ref.read(allCategoriesRef).map((e) => e.toJobType()).toList();
    final jobTypeOptions = ref.read(jobTypesRef);
    final careerLevelOptions = ref.read(jobCareerLevelsRef);
    final jobSalaryOptions = ref.read(jobSalariesRef);
    final educationLevelOptions = ref.read(jobEducationLevelsRef);
    final experienceLevelOptions = ref.read(jobExperienceLevelsRef);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: FormBuilder(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 15.0),
            Container(
              width: 120.0,
              height: 5.0,
              decoration: BoxDecoration(
                color: AppColors.grey,
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            verticalSpacer(30.h),
            FilterDropDownItem(
              options: jobCategoryOptions,
              name: fKeyJobCategory,
              hint: 'Select Job Category',
              labelIconData: Icons.widgets,
              onTapSuffix: () {
                _clearFieldByName(fKeyJobCategory);
              },
              onInitInitial: () {
                final initial = jobCategoryOptions.firstWhereOrNull(
                  (element) => element.name == filterData.jobCategory,
                );
                if (initial != null) {
                  _formKey.currentState!.fields[fKeyJobCategory]
                      ?.didChange(initial);
                }
              },
            ),
            verticalSpacer(25.h),
            FilterDropDownItem(
              options: jobTypeOptions,
              name: fKeyJobTypeKey,
              hint: 'Select Job Type',
              labelIconData: Icons.account_tree,
              onTapSuffix: () {
                _clearFieldByName(fKeyJobTypeKey);
              },
              onInitInitial: () {
                final initial = jobTypeOptions.firstWhereOrNull(
                  (element) => element.name == filterData.jobType,
                );
                if (initial != null) {
                  _formKey.currentState!.fields[fKeyJobTypeKey]
                      ?.didChange(initial);
                }
              },
            ),
            verticalSpacer(25.h),
            FilterDropDownItem(
              options: careerLevelOptions,
              name: fKeyCareerLevelKey,
              hint: 'Select Career Level',
              labelIconData: Ionicons.layers,
              onTapSuffix: () {
                _clearFieldByName(fKeyCareerLevelKey);
              },
              onInitInitial: () {
                final initial = careerLevelOptions.firstWhereOrNull(
                  (element) => element.name == filterData.careerLevel,
                );
                if (initial != null) {
                  _formKey.currentState!.fields[fKeyCareerLevelKey]
                      ?.didChange(initial);
                }
              },
            ),
            verticalSpacer(25.h),
            FilterDropDownItem(
              options: jobSalaryOptions,
              name: fKeyJobSalaryKey,
              hint: 'Select Job Salary',
              labelIconData: Icons.paid,
              onTapSuffix: () {
                _clearFieldByName(fKeyJobSalaryKey);
              },
              onInitInitial: () {
                final initial = jobSalaryOptions.firstWhereOrNull(
                  (element) => element.name == filterData.jobSalary,
                );
                if (initial != null) {
                  _formKey.currentState!.fields[fKeyJobSalaryKey]
                      ?.didChange(initial);
                }
              },
            ),
            verticalSpacer(25.h),
            FilterDropDownItem(
              options: educationLevelOptions,
              name: fKeyEducationLevelKey,
              hint: 'Select Education Level',
              labelIconData: Ionicons.school,
              onTapSuffix: () {
                _clearFieldByName(fKeyEducationLevelKey);
              },
              onInitInitial: () {
                final initial = educationLevelOptions.firstWhereOrNull(
                  (element) => element.name == filterData.educationLevel,
                );
                if (initial != null) {
                  _formKey.currentState!.fields[fKeyEducationLevelKey]
                      ?.didChange(initial);
                }
              },
            ),
            verticalSpacer(25.h),
            FilterDropDownItem(
              options: experienceLevelOptions,
              name: fKeyExperienceKey,
              hint: 'Select Experience Level',
              labelIconData: Icons.work_history,
              onTapSuffix: () {
                _clearFieldByName(fKeyExperienceKey);
              },
              onInitInitial: () {
                final initial = experienceLevelOptions.firstWhereOrNull(
                  (element) => element.name == filterData.experience,
                );
                if (initial != null) {
                  _formKey.currentState!.fields[fKeyExperienceKey]
                      ?.didChange(initial);
                }
              },
            ),
            verticalSpacer(30.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                children: [
                  Flexible(
                    child: MaterialButton(
                      onPressed: _onClearAll,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: AppColors.red.withRed(200),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      minWidth: double.infinity,
                      height: 48.0,
                      elevation: 0.0,
                      child: Text(
                        'Clear All',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  horizontalSpacer(10.w),
                  Flexible(
                    child: MaterialButton(
                      onPressed: _onApplyFilter,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: AppColors.primary,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      minWidth: double.infinity,
                      height: 48.0,
                      elevation: 0.0,
                      child: Text(
                        'Apply Filter',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom + 20.0,
            )
          ],
        ),
      ),
    );
  }
}

class FilterDropDownItem extends StatefulWidget {
  const FilterDropDownItem({
    super.key,
    required this.options,
    required this.name,
    required this.hint,
    required this.labelIconData,
    required this.onTapSuffix,
    required this.onInitInitial,
  });

  final List<JobType> options;
  final String name;
  final String hint;
  final dynamic labelIconData;
  final Function() onTapSuffix;
  final Function() onInitInitial;

  @override
  State<FilterDropDownItem> createState() => _FilterDropDownItemState();
}

class _FilterDropDownItemState extends State<FilterDropDownItem> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      widget.onInitInitial();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderDropdown<JobType>(
      name: widget.name,
      dropdownColor: Colors.white,
      decoration: getFormInputDecoration(
        prefix: null,
        suffix: Ionicons.close_circle,
        hint: widget.hint,
        onTapSuffix: widget.onTapSuffix,
        labelIconData: widget.labelIconData,
      ),
      items: widget.options.map((item) {
        return DropdownMenuItem(
          alignment: AlignmentDirectional.centerStart,
          value: item,
          child: Text(
            item.name,
            textAlign: TextAlign.start,
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w700,
            ),
          ),
        );
      }).toList(),
    ).pX(10.w);
  }
}
