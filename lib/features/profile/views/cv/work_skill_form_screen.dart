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
import 'package:slice_job/helpers/constants.dart';
import 'package:slice_job/helpers/extensions/context_extension.dart';
import 'package:slice_job/helpers/util/util.dart';

String skillKey = 'skill';
String expLevelKey = 'expLevel';

final addSkillRef =
    StateNotifierProvider.autoDispose<CVProvider, BaseState>((ref) {
  return CVProvider(ref: ref);
});

class WorkSkillFormScreen extends ConsumerStatefulWidget {
  final Skill? skill;

  const WorkSkillFormScreen({
    Key? key,
    this.skill,
  }) : super(key: key);

  @override
  ConsumerState<WorkSkillFormScreen> createState() =>
      _WorkSkillFormScreenState();
}

class _WorkSkillFormScreenState extends ConsumerState<WorkSkillFormScreen> {
  final formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    final skill = widget.skill;
    if (skill != null) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        formKey.currentState
          ?..fields[skillKey]?.didChange(skill.skill)
          ..fields[expLevelKey]?.didChange(skill.level);
      });
    }
  }

  _add() async {
    if (formKey.currentState?.saveAndValidate() ?? false) {
      FocusScope.of(context).requestFocus(FocusNode());
      final formValue = formKey.currentState!.value;
      final data = <String, String?>{
        'id': widget.skill?.id,
        'skill': formValue[skillKey],
        'level': formValue[expLevelKey],
      };
      ref.read(addSkillRef.notifier).addSkill(
            data,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final eduId = widget.skill?.id;
    ref.listen<BaseState>(
      addSkillRef,
      (previous, next) {
        if (next is BaseLoading) {
          context.showUpdatingCVInfoDialog(
              eduId == null ? 'Adding New Skill!' : 'Updating Skill!');
        } else {
          context.pop();
          context.pop(true);
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
            '${widget.skill != null ? 'Update' : 'Add'} CV Skill',
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
                    fieldKey: skillKey,
                    formKey: formKey,
                    hint: 'Skill',
                    validator: FormBuilderValidators.required(
                        errorText: 'Job Title required!'),
                  ),
                  verticalSpacer(15.h),
                  SliceJobDropdown(
                    fieldKey: expLevelKey,
                    items: expLevels,
                    formKey: formKey,
                    hint: 'Select Experience Level',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'Experience Level required!'),
                    ]),
                    isDense: false,
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
                      widget.skill != null ? 'Update' : 'Add',
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
