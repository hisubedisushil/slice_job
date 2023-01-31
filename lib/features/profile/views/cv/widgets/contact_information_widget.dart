import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:slice_job/app/entities/base_state.dart';
import 'package:slice_job/app/entities/failure.dart';
import 'package:slice_job/constants/app_colors.dart';
import 'package:slice_job/core/widgets/slicejob_input_fields.dart';
import 'package:slice_job/features/profile/provider/cv_provider.dart';
import 'package:slice_job/features/profile/widgets/section_bar_widget.dart';
import 'package:slice_job/helpers/extensions/context_extension.dart';
import 'package:slice_job/helpers/util/util.dart';

// Contact information Keys
String emailKey = 'email';
String phoneKey = 'phone';
String websiteKey = 'website';

final updateContactInfoRef =
    StateNotifierProvider.autoDispose<CVProvider, BaseState>((ref) {
  return CVProvider(ref: ref);
});

class ContactInformationWidget extends ConsumerStatefulWidget {
  const ContactInformationWidget({super.key});

  @override
  ConsumerState<ContactInformationWidget> createState() =>
      _ContactInformationWidgetState();
}

class _ContactInformationWidgetState
    extends ConsumerState<ContactInformationWidget> {
  final _contactInfoFormKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    initCVContactInfo();
  }

  void initCVContactInfo() {
    final cvContact = ref.read(cvBasicRef.notifier).state;
    if (cvContact != null) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        _contactInfoFormKey.currentState
          ?..fields[emailKey]?.didChange(cvContact.email)
          ..fields[phoneKey]?.didChange(cvContact.contactNumber)
          ..fields[websiteKey]?.didChange(cvContact.website);
      });
    }
  }

  void _saveContactInformation() {
    if (_contactInfoFormKey.currentState?.saveAndValidate() ?? false) {
      FocusScope.of(context).requestFocus(FocusNode());
      final formValue = _contactInfoFormKey.currentState!.value;
      final data = <String, String>{
        'email': formValue[emailKey],
        'contact_number': formValue[phoneKey],
        'website': formValue[websiteKey],
      };
      ref.read(updateContactInfoRef.notifier).updateCVContactInfo(
            data,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<BaseState>(
      updateContactInfoRef,
      (previous, next) {
        if (next is BaseLoading) {
          context.showUpdatingCVInfoDialog('Updating CV Contact Information!');
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
    return FormBuilder(
        key: _contactInfoFormKey,
        child: Column(
          children: [
            const SectionBarWidget(title: 'Contact Information'),
            verticalSpacer(15.h),
            SliceJobTextField(
              fieldKey: emailKey,
              formKey: _contactInfoFormKey,
              hint: 'Email',
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: 'Email required!'),
                FormBuilderValidators.email(errorText: 'Enter Valid Email!')
              ]),
            ),
            verticalSpacer(15.h),
            SliceJobTextField(
              fieldKey: phoneKey,
              formKey: _contactInfoFormKey,
              hint: 'Mobile',
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(
                    errorText: 'Mobile number required!'),
                FormBuilderValidators.equalLength(10,
                    errorText: 'Mobile number must be 10 characters!'),
              ]),
            ),
            verticalSpacer(15.h),
            SliceJobTextField(
              fieldKey: websiteKey,
              formKey: _contactInfoFormKey,
              hint: 'Website',
              validator: FormBuilderValidators.required(
                  errorText: 'Website required!'),
            ),
            verticalSpacer(20.h),
            Align(
              alignment: Alignment.center,
              child: MaterialButton(
                onPressed: _saveContactInformation,
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
