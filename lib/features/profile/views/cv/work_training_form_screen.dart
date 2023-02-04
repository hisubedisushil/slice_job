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

String trainingKey = 'training';
String fromMonthKey = 'fromMonth';
String fromYearKey = 'fromYear';
String toMonthKey = 'toMonth';
String toYearKey = 'toYear';

final addRef = StateNotifierProvider.autoDispose<CVProvider, BaseState>((ref) {
  return CVProvider(ref: ref);
});

class WorkTrainingFormScreen extends ConsumerStatefulWidget {
  final Training? training;

  const WorkTrainingFormScreen({
    Key? key,
    this.training,
  }) : super(key: key);

  @override
  ConsumerState<WorkTrainingFormScreen> createState() =>
      _WorkTrainingFormScreenState();
}

class _WorkTrainingFormScreenState
    extends ConsumerState<WorkTrainingFormScreen> {
  final formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    final edu = widget.training;
    if (edu != null) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        formKey.currentState
          ?..fields[trainingKey]?.didChange(edu.title)
          ..fields[fromMonthKey]?.didChange(edu.startMonth)
          ..fields[fromYearKey]?.didChange(edu.startYear)
          ..fields[toMonthKey]?.didChange(edu.endMonth)
          ..fields[toYearKey]?.didChange(edu.endYear);
      });
    }
  }

  _add() async {
    if (formKey.currentState?.saveAndValidate() ?? false) {
      FocusScope.of(context).requestFocus(FocusNode());
      final formValue = formKey.currentState!.value;
      final data = <String, String?>{
        'id': widget.training?.id,
        'title': formValue[trainingKey],
        'start_month': formValue[fromMonthKey],
        'start_year': formValue[fromYearKey],
        'end_month': formValue[toMonthKey],
        'end_year': formValue[toYearKey],
      };
      ref.read(addRef.notifier).addTraining(
            data,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final eduId = widget.training?.id;
    ref.listen<BaseState>(
      addRef,
      (previous, next) {
        if (next is BaseLoading) {
          context.showUpdatingCVInfoDialog(
              eduId == null ? 'Adding New Training!' : 'Updating Training!');
        } else {
          ref.read(profileRef.notifier).getProfileTraining();
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
            '${widget.training != null ? 'Update' : 'Add'} CV Training',
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
                    fieldKey: trainingKey,
                    formKey: formKey,
                    hint: 'Training',
                    validator: FormBuilderValidators.required(
                        errorText: 'Training Title required!'),
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
                    items: years,
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
                    items: ['Present', ...years],
                    formKey: formKey,
                    hint: 'To Year',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'Pick End Year!'),
                    ]),
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
                      widget.training != null ? 'Update' : 'Add',
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
