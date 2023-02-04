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

String languageKey = 'language';
String expLevelKey = 'expLevel';

final addRef = StateNotifierProvider.autoDispose<CVProvider, BaseState>((ref) {
  return CVProvider(ref: ref);
});

class WorkLanguageFormScreen extends ConsumerStatefulWidget {
  final Language? language;

  const WorkLanguageFormScreen({
    Key? key,
    this.language,
  }) : super(key: key);

  @override
  ConsumerState<WorkLanguageFormScreen> createState() =>
      _WorkLanguageFormScreenState();
}

class _WorkLanguageFormScreenState
    extends ConsumerState<WorkLanguageFormScreen> {
  final formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    final lan = widget.language;
    if (lan != null) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        formKey.currentState
          ?..fields[languageKey]?.didChange(lan.language)
          ..fields[expLevelKey]?.didChange(lan.level);
      });
    }
  }

  _add() async {
    if (formKey.currentState?.saveAndValidate() ?? false) {
      FocusScope.of(context).requestFocus(FocusNode());
      final formValue = formKey.currentState!.value;
      final data = <String, String?>{
        'id': widget.language?.id,
        'language': formValue[languageKey],
        'level': formValue[expLevelKey],
      };
      ref.read(addRef.notifier).addLanguage(
            data,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final lanId = widget.language?.id;
    ref.listen<BaseState>(
      addRef,
      (previous, next) {
        if (next is BaseLoading) {
          context.showUpdatingCVInfoDialog(
              lanId == null ? 'Adding New Language!' : 'Updating Language!');
        } else {
          ref.read(profileRef.notifier).getProfileLanguage();
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
            '${widget.language != null ? 'Update' : 'Add'} CV  Language',
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
                    fieldKey: languageKey,
                    formKey: formKey,
                    hint: 'Language',
                    validator: FormBuilderValidators.required(
                        errorText: 'Language required!'),
                  ),
                  verticalSpacer(15.h),
                  SliceJobDropdown(
                    fieldKey: expLevelKey,
                    items: lanExpLevels,
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
                      widget.language != null ? 'Update' : 'Add',
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
