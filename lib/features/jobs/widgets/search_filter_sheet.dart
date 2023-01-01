import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:slice_job/core/models/job.dart';
import 'package:slice_job/core/models/job_category.dart';
import 'package:slice_job/features/jobs/models/job_search.dart';
import 'package:slice_job/features/jobs/provider/job_provider.dart';
import 'package:slice_job/helpers/extensions/padding_extensions.dart';
import 'package:slice_job/helpers/util/decoration_util.dart';
import 'package:slice_job/helpers/util/util.dart';

import '../../../constants/app_colors.dart';

enum JobFilter {
  category,
  type,
  careerLevel,
  salary,
  educationLevel,
  experienceLevel,
}

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
  @override
  void initState() {
    final filterData = widget.filterData;
    super.initState();
  }

  void _clearFieldByName(String name) {
    _formKey.currentState!.fields[name]?.reset();
  }

  @override
  Widget build(BuildContext context) {
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
              options:
                  ref.read(allCategoriesRef).map((e) => e.toJobType()).toList(),
              name: JobFilter.category.name,
              hint: 'Select Job Category',
              labelIconData: Icons.widgets,
              onTapSuffix: () {
                _clearFieldByName(JobFilter.category.name);
              },
            ),
            verticalSpacer(25.h),
            FilterDropDownItem(
              options: ref.read(jobTypesRef),
              name: JobFilter.type.name,
              hint: 'Select Job Type',
              labelIconData: Icons.account_tree,
              onTapSuffix: () {
                _clearFieldByName(JobFilter.type.name);
              },
            ),
            verticalSpacer(25.h),
            FilterDropDownItem(
              options: ref.read(jobCareerLevelsRef),
              name: JobFilter.careerLevel.name,
              hint: 'Select Career Level',
              labelIconData: Ionicons.layers,
              onTapSuffix: () {
                _clearFieldByName(JobFilter.careerLevel.name);
              },
            ),
            verticalSpacer(25.h),
            FilterDropDownItem(
              options: ref.read(jobSalariesRef),
              name: JobFilter.salary.name,
              hint: 'Select Job Salary',
              labelIconData: Icons.paid,
              onTapSuffix: () {
                _clearFieldByName(JobFilter.salary.name);
              },
            ),
            verticalSpacer(25.h),
            FilterDropDownItem(
              options: ref.read(jobEducationLevelsRef),
              name: JobFilter.educationLevel.name,
              hint: 'Select Education Level',
              labelIconData: Ionicons.school,
              onTapSuffix: () {
                _clearFieldByName(JobFilter.educationLevel.name);
              },
            ),
            verticalSpacer(25.h),
            FilterDropDownItem(
              options: ref.read(jobExperienceLevelsRef),
              name: JobFilter.experienceLevel.name,
              hint: 'Select Experience Level',
              labelIconData: Icons.work_history,
              onTapSuffix: () {
                _clearFieldByName(JobFilter.experienceLevel.name);
              },
            ),
            verticalSpacer(30.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                children: [
                  Flexible(
                    child: MaterialButton(
                      onPressed: () {
                        //
                      },
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
                      onPressed: () {
                        //
                      },
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

class FilterDropDownItem extends StatelessWidget {
  const FilterDropDownItem({
    super.key,
    required this.options,
    required this.name,
    required this.hint,
    required this.labelIconData,
    required this.onTapSuffix,
  });

  final List<JobType> options;
  final String name;
  final String hint;
  final dynamic labelIconData;
  final Function() onTapSuffix;

  @override
  Widget build(BuildContext context) {
    return FormBuilderDropdown<JobType>(
      name: name,
      dropdownColor: Colors.white,
      decoration: getFormInputDecoration(
        prefix: null,
        suffix: Ionicons.close_circle,
        hint: hint,
        onTapSuffix: onTapSuffix,
        labelIconData: labelIconData,
      ),
      items: options.map((item) {
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
