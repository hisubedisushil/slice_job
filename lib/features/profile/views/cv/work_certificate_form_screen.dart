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

String certificateKey = 'certificate';
String fromMonthKey = 'fromMonth';
String fromYearKey = 'fromYear';
String toMonthKey = 'toMonth';
String toYearKey = 'toYear';
String descKey = 'desc';

final addRef = StateNotifierProvider.autoDispose<CVProvider, BaseState>((ref) {
  return CVProvider(ref: ref);
});

class WorkCertificateFormScreen extends ConsumerStatefulWidget {
  final Certificate? certificate;

  const WorkCertificateFormScreen({
    Key? key,
    this.certificate,
  }) : super(key: key);

  @override
  ConsumerState<WorkCertificateFormScreen> createState() =>
      _WorkCertificateFormScreenState();
}

class _WorkCertificateFormScreenState
    extends ConsumerState<WorkCertificateFormScreen> {
  final formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    final cert = widget.certificate;
    if (cert != null) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        formKey.currentState
          ?..fields[certificateKey]?.didChange(cert.title)
          ..fields[fromMonthKey]?.didChange(cert.issueMonth)
          ..fields[fromYearKey]?.didChange(cert.issueYear)
          ..fields[toMonthKey]?.didChange(cert.expireMonth)
          ..fields[toYearKey]?.didChange(cert.expireYear)
          ..fields[descKey]?.didChange(cert.description);
      });
    }
  }

  _add() async {
    if (formKey.currentState?.saveAndValidate() ?? false) {
      FocusScope.of(context).requestFocus(FocusNode());
      final formValue = formKey.currentState!.value;
      final data = <String, String?>{
        'id': widget.certificate?.id,
        'title': formValue[certificateKey],
        'issue_month': formValue[fromMonthKey],
        'issue_year': formValue[fromYearKey],
        'expire_month': formValue[toMonthKey],
        'expire_year': formValue[toYearKey],
        'description': formValue[descKey],
      };
      ref.read(addRef.notifier).addCertificate(
            data,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final eduId = widget.certificate?.id;
    ref.listen<BaseState>(
      addRef,
      (previous, next) {
        if (next is BaseLoading) {
          context.showUpdatingCVInfoDialog(eduId == null
              ? 'Adding New Certificate!'
              : 'Updating Certificate!');
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
            '${widget.certificate != null ? 'Update' : 'Add'} CV Certificate',
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
                    fieldKey: certificateKey,
                    formKey: formKey,
                    hint: 'Title',
                    validator: FormBuilderValidators.required(
                        errorText: 'Certificate Title required!'),
                  ),
                  verticalSpacer(15.h),
                  SliceJobDropdown(
                    fieldKey: fromMonthKey,
                    items: months,
                    formKey: formKey,
                    hint: 'Issue Month',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'Pick Issued Month!'),
                    ]),
                  ),
                  verticalSpacer(15.h),
                  SliceJobDropdown(
                    fieldKey: fromYearKey,
                    items: years,
                    formKey: formKey,
                    hint: 'Issue Year',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'Pick Issued Year!'),
                    ]),
                  ),
                  verticalSpacer(15.h),
                  SliceJobDropdown(
                    fieldKey: toMonthKey,
                    items: ['Present', ...months],
                    formKey: formKey,
                    hint: 'Expire Month',
                    validator: null,
                  ),
                  verticalSpacer(15.h),
                  SliceJobDropdown(
                    fieldKey: toYearKey,
                    items: ['Present', ...years],
                    formKey: formKey,
                    hint: 'Expire Year',
                    validator: null,
                  ),
                  verticalSpacer(15.h),
                  SliceJobTextField(
                    maxLines: 6,
                    maxLength: 4000,
                    fieldKey: descKey,
                    formKey: formKey,
                    hint: 'Certificate Description',
                    validator: null,
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
                      widget.certificate != null ? 'Update' : 'Add',
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
