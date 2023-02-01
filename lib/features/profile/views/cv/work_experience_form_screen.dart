import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:slice_job/app/entities/base_state.dart';
import 'package:slice_job/app/entities/failure.dart';
import 'package:slice_job/constants/app_colors.dart';
import 'package:slice_job/core/models/experience.dart';
import 'package:slice_job/core/widgets/slicejob_input_fields.dart';
import 'package:slice_job/features/profile/provider/cv_provider.dart';
import 'package:slice_job/features/profile/views/profile_authenticated_view.dart';
import 'package:slice_job/helpers/constants.dart';
import 'package:slice_job/helpers/extensions/context_extension.dart';
import 'package:slice_job/helpers/util/util.dart';

String jobTitleKey = 'jobTitle';
String companyKey = 'company';
String locationKey = 'location';
String fromMonthKey = 'fromMonth';
String fromYearKey = 'fromYear';
String toMonthKey = 'toMonth';
String toYearKey = 'toYear';
String workDescKey = 'workDesc';

final addWorkExperienceRef =
    StateNotifierProvider.autoDispose<CVProvider, BaseState>((ref) {
  return CVProvider(ref: ref);
});

class WorkExperienceFormScreen extends ConsumerStatefulWidget {
  final Experience? experience;

  const WorkExperienceFormScreen({
    Key? key,
    this.experience,
  }) : super(key: key);

  @override
  ConsumerState<WorkExperienceFormScreen> createState() =>
      _WorkExperienceFormScreenState();
}

class _WorkExperienceFormScreenState
    extends ConsumerState<WorkExperienceFormScreen> {
  final List<String> _years = [
    for (int i = 1950; i <= DateTime.now().year; i += 1) i.toString()
  ];

  final formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    final exp = widget.experience;
    if (exp != null) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        formKey.currentState
          ?..fields[jobTitleKey]?.didChange(exp.jobTitle)
          ..fields[companyKey]?.didChange(exp.company)
          ..fields[locationKey]?.didChange(exp.location)
          ..fields[fromMonthKey]?.didChange(exp.fromMonth)
          ..fields[fromYearKey]?.didChange(exp.fromYear)
          ..fields[toMonthKey]?.didChange(exp.toMonth)
          ..fields[toYearKey]?.didChange(exp.toYear)
          ..fields[workDescKey]?.didChange(exp.workDescription);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  _add() async {
    if (formKey.currentState?.saveAndValidate() ?? false) {
      FocusScope.of(context).requestFocus(FocusNode());
      final formValue = formKey.currentState!.value;
      final data = <String, String?>{
        'id': widget.experience?.id,
        'job_title': formValue[jobTitleKey],
        'company': formValue[companyKey],
        'location': formValue[locationKey],
        'from_month': formValue[fromMonthKey],
        'from_year': formValue[fromYearKey],
        'to_month': formValue[toMonthKey],
        'to_year': formValue[toYearKey],
        'work_description': formValue[workDescKey],
      };
      ref.read(addWorkExperienceRef.notifier).addExperience(
            data,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final expId = widget.experience?.id;
    ref.listen<BaseState>(
      addWorkExperienceRef,
      (previous, next) {
        if (next is BaseLoading) {
          context.showUpdatingCVInfoDialog(expId == null
              ? 'Adding New Experience!'
              : 'Updating Experience!');
        } else {
          ref.read(profileRef.notifier).getProfileExperience();
          context.pop();
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

    return Material(
      color: AppColors.white,
      child: Scaffold(
        backgroundColor: AppColors.primary.withOpacity(0.1),
        appBar: AppBar(
          title: Text(
            '${widget.experience != null ? 'Update' : 'Add'} CV Work Experience',
          ),
        ),
        body: FormBuilder(
          key: formKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SliceJobTextField(
                    fieldKey: jobTitleKey,
                    formKey: formKey,
                    hint: 'Job Title',
                    validator: FormBuilderValidators.required(
                        errorText: 'Job Title required!'),
                  ),
                  verticalSpacer(15.h),
                  SliceJobTextField(
                    fieldKey: companyKey,
                    formKey: formKey,
                    hint: 'Company',
                    validator: FormBuilderValidators.required(
                        errorText: 'Company Name required!'),
                  ),
                  verticalSpacer(15.h),
                  SliceJobTextField(
                    fieldKey: locationKey,
                    formKey: formKey,
                    hint: 'Location',
                    validator: FormBuilderValidators.required(
                        errorText: 'Location required!'),
                  ),
                  verticalSpacer(15.h),
                  SliceJobDropdown(
                    fieldKey: fromMonthKey,
                    items: months,
                    formKey: formKey,
                    hint: 'From Month',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'Pick Start Month!'),
                    ]),
                  ),
                  verticalSpacer(15.h),
                  SliceJobDropdown(
                    fieldKey: fromYearKey,
                    items: _years,
                    formKey: formKey,
                    hint: 'From Year',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'Pick Start Year!'),
                    ]),
                  ),
                  verticalSpacer(15.h),
                  SliceJobDropdown(
                    fieldKey: toMonthKey,
                    items: ['Present', ...months],
                    formKey: formKey,
                    hint: 'To Month',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'Pick End Month!'),
                    ]),
                  ),
                  verticalSpacer(15.h),
                  SliceJobDropdown(
                    fieldKey: toYearKey,
                    items: ['Present', ..._years],
                    formKey: formKey,
                    hint: 'To Year',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'Pick End Year!'),
                    ]),
                  ),
                  verticalSpacer(15.h),
                  SliceJobTextField(
                    maxLines: 6,
                    maxLength: 4000,
                    fieldKey: workDescKey,
                    formKey: formKey,
                    hint:
                        'Work Description (Press enter for list the job description)',
                    validator: FormBuilderValidators.required(
                        errorText: 'Job Description required!'),
                  ),
                  verticalSpacer(15.h),
                  MaterialButton(
                    onPressed: _add,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: AppColors.primary,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minWidth: double.infinity,
                    height: 56.0,
                    elevation: 0.0,
                    child: Text(
                      widget.experience != null ? 'Update' : 'Add',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 60.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
