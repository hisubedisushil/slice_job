import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ionicons/ionicons.dart';
import 'package:slice_job/app/entities/base_state.dart';
import 'package:slice_job/app/entities/failure.dart';
import 'package:slice_job/app_setup/routes/router.dart';
import 'package:slice_job/constants/app_colors.dart';
import 'package:slice_job/core/models/job_detail.dart';
import 'package:slice_job/core/widgets/slicejob_input_fields.dart';
import 'package:slice_job/features/jobs/provider/job_provider.dart';
import 'package:slice_job/helpers/extensions/context_extension.dart';
import 'package:slice_job/helpers/extensions/padding_extensions.dart';
import 'package:slice_job/helpers/util/util.dart';

String qualificationKey = 'qualification';
String experienceKey = 'experience';

String cvErrorText = 'Pick your CV file to apply for the job!';
String coverErrorText = 'Pick your Cover letter to apply for the job!';

final applyRef =
    StateNotifierProvider.autoDispose<JobProvider, BaseState>((ref) {
  return JobProvider(ref: ref);
});

class JobApplyScreen extends ConsumerStatefulWidget {
  final JobDetail jobDetail;

  const JobApplyScreen({Key? key, required this.jobDetail}) : super(key: key);

  @override
  ConsumerState<JobApplyScreen> createState() => _JobApplyScreenState();
}

class _JobApplyScreenState extends ConsumerState<JobApplyScreen> {
  final formKey = GlobalKey<FormBuilderState>();
  ValueNotifier<String?> cvError = ValueNotifier<String?>(null);
  ValueNotifier<String?> cvFile = ValueNotifier<String?>(null);
  ValueNotifier<String?> coverFile = ValueNotifier<String?>(null);
  ValueNotifier<String?> coverError = ValueNotifier<String?>(null);

  Future<void> _submit() async {
    if (cvFile.value == null) {
      cvError.value = cvErrorText;
    } else {
      cvError.value = null;
    }
    if (coverFile.value == null) {
      coverError.value = coverErrorText;
    } else {
      coverError.value = null;
    }
    if ((formKey.currentState?.saveAndValidate() ?? false) &&
        cvFile.value != null &&
        coverFile.value != null) {
      FocusScope.of(context).requestFocus(FocusNode());
      final cvFilePart = await MultipartFile.fromFile(cvFile.value!);
      final coverFilePart = await MultipartFile.fromFile(coverFile.value!);
      final formValue = formKey.currentState!.value;
      final data = <String, dynamic>{
        'id': widget.jobDetail.jobKey,
        'qualification': formValue[qualificationKey],
        'experience': formValue[experienceKey],
        'cv': cvFilePart,
        'letter': coverFilePart,
      };
      ref.read(applyRef.notifier).applyJob(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    final educationLevels = ref.read(jobEducationLevelsRef);
    final experienceLevels = ref.read(jobExperienceLevelsRef);
    ref.listen<BaseState>(
      applyRef,
      (previous, next) {
        if (next is BaseLoading) {
          context.showUpdatingCVInfoDialog('Applying to job!');
        } else {
          context.pop();
          if (next is BaseSuccess) {
            final message = next.data as String;
            context.pushReplacementNamed(jobApplySuccessRoute,
                extra: widget.jobDetail);
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
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.jobDetail.jobTittle}',
              ),
            ],
          ),
        ),
        body: FormBuilder(
          key: formKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Upload your CV',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        InkWell(
                          onTap: () async {
                            final result = await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowedExtensions: ['pdf'],
                            );
                            if (result != null) {
                              log(result.files.single.size.toString());
                              cvFile.value = result.files.single.path;
                              cvError.value = null;
                            } else {
                              coverFile.value = null;
                              cvError.value = cvErrorText;
                            }
                          },
                          child: Container(
                            height: 120.0,
                            width: double.infinity,
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: AppColors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: AppColors.grey.withOpacity(0.4),
                                width: 2.0,
                                style: BorderStyle.solid,
                              ),
                            ),
                            child: ValueListenableBuilder<String?>(
                                valueListenable: cvFile,
                                builder: (context, value, child) {
                                  final cvFile = value;

                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (cvFile != null)
                                        Text(
                                          (cvFile).split('/').last,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.black,
                                          ),
                                        ),
                                      if (cvFile == null)
                                        Icon(
                                          Ionicons.document_attach_outline,
                                          color: AppColors.primary,
                                          size: 40.0,
                                        ),
                                      if (cvFile == null)
                                        Text(
                                          '(Doc/Docx or PDF only, and maximum file size allowed is 500 KB)',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: AppColors.grey,
                                          ),
                                        ),
                                      ValueListenableBuilder<String?>(
                                        valueListenable: cvError,
                                        builder: (context, value, child) {
                                          return value != null
                                              ? Text(
                                                  value,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: AppColors.red
                                                        .withRed(200),
                                                  ),
                                                ).pT(15.h)
                                              : const SizedBox();
                                        },
                                      ),
                                    ],
                                  );
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                  verticalSpacer(15.h),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Upload your Cover Letter',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        InkWell(
                          onTap: () async {
                            final result = await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowedExtensions: ['pdf', 'docx', 'doc'],
                            );
                            if (result != null) {
                              log(result.files.single.size.toString());
                              coverFile.value = result.files.single.path;
                              coverError.value = null;
                            } else {
                              coverFile.value = null;
                              coverError.value = coverErrorText;
                            }
                          },
                          child: Container(
                            height: 120.0,
                            width: double.infinity,
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: AppColors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: AppColors.grey.withOpacity(0.4),
                                width: 2.0,
                                style: BorderStyle.solid,
                              ),
                            ),
                            child: ValueListenableBuilder<String?>(
                                valueListenable: coverFile,
                                builder: (context, value, child) {
                                  final coverFile = value;
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (coverFile != null)
                                        Text(
                                          (coverFile).split('/').last,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.black,
                                          ),
                                        ),
                                      if (coverFile == null)
                                        Icon(
                                          Ionicons.document_attach_outline,
                                          color: AppColors.primary,
                                          size: 40.0,
                                        ),
                                      if (coverFile == null)
                                        Text(
                                          '(Doc/Docx or PDF only, and maximum file size allowed is 500 KB)',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: AppColors.grey,
                                          ),
                                        ),
                                      ValueListenableBuilder<String?>(
                                        valueListenable: coverError,
                                        builder: (context, value, child) {
                                          return value != null
                                              ? Text(
                                                  value,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: AppColors.red
                                                        .withRed(200),
                                                  ),
                                                ).pT(15.h)
                                              : const SizedBox();
                                        },
                                      ),
                                    ],
                                  );
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                  verticalSpacer(30.h),
                  SliceJobDropdown(
                    fieldKey: qualificationKey,
                    items: educationLevels.map((e) => e.name).toList(),
                    formKey: formKey,
                    hint: 'Your Qualification Level',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'Pick your qualification level!'),
                    ]),
                  ),
                  verticalSpacer(20.h),
                  SliceJobDropdown(
                    fieldKey: experienceKey,
                    items: experienceLevels.map((e) => e.name).toList(),
                    formKey: formKey,
                    hint: 'Your Job Experience',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'Pick your experience level!'),
                    ]),
                  ),
                  verticalSpacer(20.h),
                  MaterialButton(
                    onPressed: _submit,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: AppColors.primary,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minWidth: double.infinity,
                    height: 56.0,
                    elevation: 0.0,
                    child: Text(
                      'Submit',
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
