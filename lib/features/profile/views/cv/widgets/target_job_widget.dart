import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:slice_job/app/entities/base_state.dart';
import 'package:slice_job/app/entities/failure.dart';
import 'package:slice_job/constants/app_colors.dart';
import 'package:slice_job/core/models/job.dart';
import 'package:slice_job/core/models/job_category.dart';
import 'package:slice_job/core/widgets/slicejob_input_fields.dart';
import 'package:slice_job/features/jobs/provider/job_provider.dart';
import 'package:slice_job/features/profile/provider/cv_provider.dart';
import 'package:slice_job/features/profile/widgets/section_bar_widget.dart';
import 'package:slice_job/helpers/constants.dart';
import 'package:slice_job/helpers/extensions/context_extension.dart';
import 'package:slice_job/helpers/util/util.dart';

// Target job Keys
String jobRoleKey = 'jobRole';
String jobTitleKey = 'jobTitle';
String careerLevelKey = 'careerLevel';
String jobTypeKey = 'jobType';
String targetSalaryKey = 'targetSalary';
String currencyKey = 'currency';

final updateTargetJobInfoRef =
    StateNotifierProvider.autoDispose<CVProvider, BaseState>((ref) {
  return CVProvider(ref: ref);
});
final getJobTitleRef =
    StateNotifierProvider.autoDispose<CVProvider, BaseState>((ref) {
  return CVProvider(ref: ref);
});

class TargetJobWidget extends ConsumerStatefulWidget {
  const TargetJobWidget({super.key});

  @override
  ConsumerState<TargetJobWidget> createState() => _TargetJobWidgetState();
}

class _TargetJobWidgetState extends ConsumerState<TargetJobWidget> {
  final _targetJobFormKey = GlobalKey<FormBuilderState>();
  final List<JobCategory> _jobRoles = [];
  final List<JobType> _jobTypes = [];
  final List<JobType> _careerLevels = [];

  @override
  void initState() {
    super.initState();
    initCVTargetJob();
  }

  void initCVTargetJob() {
    _jobRoles.addAll(ref.read(allCategoriesRef.notifier).state);
    _careerLevels.addAll(ref.read(jobCareerLevelsRef.notifier).state);
    _jobTypes.addAll(ref.read(jobTypesRef.notifier).state);
    final cvBasic = ref.read(cvBasicRef.notifier).state;
    if (cvBasic != null) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        _targetJobFormKey.currentState
          ?..fields[jobRoleKey]?.didChange(cvBasic.jobRole)
          ..fields[jobTitleKey]?.didChange(cvBasic.jobTitle)
          ..fields[careerLevelKey]?.didChange(cvBasic.careerLevel)
          ..fields[jobTypeKey]?.didChange(cvBasic.jobType)
          ..fields[targetSalaryKey]?.didChange(cvBasic.targetSalary)
          ..fields[currencyKey]?.didChange(cvBasic.targetSalaryCurrency);
      });
    }
  }

  void _saveTargetJobInformation() {
    if (_targetJobFormKey.currentState?.saveAndValidate() ?? false) {
      FocusScope.of(context).requestFocus(FocusNode());
      final formValue = _targetJobFormKey.currentState!.value;

      final data = <String, String>{
        'job_role': formValue[jobRoleKey],
        'job_title': formValue[jobTitleKey],
        'career_level': formValue[careerLevelKey],
        'job_type': formValue[jobTypeKey],
        'target_salary': formValue[targetSalaryKey],
        'target_salary_currency': formValue[currencyKey],
      };
      ref.read(updateTargetJobInfoRef.notifier).updateCVTargetJob(
            data,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<BaseState>(
      updateTargetJobInfoRef,
      (previous, next) {
        if (next is BaseLoading) {
          context.showUpdatingCVInfoDialog('Updating CV Target Job!');
        } else {
          context.pop();
          if (next is BaseSuccess) {
            final message = next.data as String;
            context.showSnackBar(message);
          }
          if (next is BaseError) {
            final data = next.data as Failure;
            context.showSnackBar(data.reason);
          }
        }
      },
    );
    ref.listen<BaseState>(getJobTitleRef, (previous, next) {
      if (next is BaseError) {
        final data = next.data as Failure;
        final selectedJobRole = _targetJobFormKey
            .currentState?.fields[jobRoleKey]?.value
            .toString()
            .trim();
        context.showSnackBar(
            data.reason.replaceFirst('.', ' for $selectedJobRole.'));
      }
    });
    return FormBuilder(
        key: _targetJobFormKey,
        child: Column(
          children: [
            const SectionBarWidget(title: 'Target Job'),
            verticalSpacer(15.h),
            SliceJobDropdown(
              fieldKey: jobRoleKey,
              items: _jobRoles.map((element) => element.name).toList(),
              formKey: _targetJobFormKey,
              hint: 'Job Role',
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(
                    errorText: 'Select target job role!'),
              ]),
              onChanged: (p0) {
                if (p0 != null) {
                  final categoryId =
                      _jobRoles.firstWhereOrNull((e) => e.name == p0)?.id;
                  if (categoryId != null) {
                    ref.read(getJobTitleRef.notifier).getJobTitles(categoryId);
                  }
                }
              },
              isDense: false,
            ),
            verticalSpacer(15.h),
            Consumer(
              builder: (context, ref, child) {
                bool isLoading = true;
                List<JobTitle> jobTitles = [];
                ref.watch<BaseState>(getJobTitleRef).maybeWhen(
                  loading: () {
                    isLoading = true;
                  },
                  success: (data, extraData) {
                    isLoading = false;
                    jobTitles = data as List<JobTitle>;
                  },
                  orElse: () {
                    isLoading = false;
                  },
                );
                return Stack(
                  children: [
                    SliceJobDropdown(
                      fieldKey: jobTitleKey,
                      items: jobTitles
                          .where((e) => e.title != null)
                          .map((element) => element.title)
                          .toList(),
                      formKey: _targetJobFormKey,
                      hint: 'Desired Job Title',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: 'Select target job title!'),
                      ]),
                      isDense: false,
                    ),
                    if (isLoading)
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Center(
                          child: SizedBox(
                            width: 30.w,
                            height: 30.w,
                            child: const CircularProgressIndicator(),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
            verticalSpacer(15.h),
            SliceJobDropdown(
              fieldKey: careerLevelKey,
              items: _careerLevels.map((element) => element.name).toList(),
              formKey: _targetJobFormKey,
              hint: 'Career Level',
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(
                    errorText: 'Select target career level!'),
              ]),
              isDense: false,
            ),
            verticalSpacer(15.h),
            SliceJobDropdown(
              fieldKey: jobTypeKey,
              items: _jobTypes.map((element) => element.name).toList(),
              formKey: _targetJobFormKey,
              hint: 'Job Type',
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(
                    errorText: 'Select target job type!'),
              ]),
              isDense: false,
            ),
            verticalSpacer(15.h),
            SliceJobTextField(
              fieldKey: targetSalaryKey,
              formKey: _targetJobFormKey,
              hint: 'Target Salary',
              validator: FormBuilderValidators.required(
                  errorText: 'Set a Target Salary!'),
              isDense: false,
            ),
            verticalSpacer(15.h),
            SliceJobDropdown(
              fieldKey: currencyKey,
              items: currencies,
              formKey: _targetJobFormKey,
              hint: 'Currency Format',
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(
                    errorText: 'Select currency format!'),
              ]),
              isDense: false,
            ),
            verticalSpacer(20.h),
            Align(
              alignment: Alignment.center,
              child: MaterialButton(
                onPressed: _saveTargetJobInformation,
                elevation: 0.0,
                color: AppColors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                height: 48.0,
                minWidth: 120.0,
                child: Text(
                  'Update',
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
