import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:ionicons/ionicons.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_colors.dart';
import '../../../controllers/general_controller.dart';
import '../../../controllers/job_controller.dart';
import '../../../models/job_detail_model.dart';
import '../../../models/job_type_model.dart';
import 'job_success_view.dart';

class JobApplyView extends StatefulWidget {
  final JobDetailModel jobDetail;

  const JobApplyView({Key? key, required this.jobDetail}) : super(key: key);

  @override
  State<JobApplyView> createState() => _JobApplyViewState();
}

class _JobApplyViewState extends State<JobApplyView> {
  String? _cvFile;
  String? _coverFile;
  JobTypeModel? _selectedEducation;
  JobTypeModel? _selectedExperience;

  @override
  Widget build(BuildContext context) {
    final generalController = context.watch<GeneralController>();
    return Material(
      color: AppColors.white,
      child: Scaffold(
        backgroundColor: AppColors.primary.withOpacity(0.1),
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Solution Architect-Executive',
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: AppColors.white,
                  ),
                  padding: const EdgeInsets.all(10.0),
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
                            allowedExtensions: ['pdf', 'docx', 'doc'],
                          );

                          if (result != null) {
                            _cvFile = result.files.single.path;
                          } else {
                            _cvFile = null;
                          }
                          setState(() {});
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (_cvFile != null)
                                Text(
                                  (_cvFile ?? '').split('/').last,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.black,
                                  ),
                                ),
                              if (_cvFile == null)
                                Icon(
                                  Ionicons.document_attach_outline,
                                  color: AppColors.primary,
                                  size: 40.0,
                                ),
                              if (_cvFile == null)
                                Text(
                                  '(Doc/Docx or PDF only, and maximum file size allowed is 500 KB)',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: AppColors.grey,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: AppColors.white,
                  ),
                  padding: const EdgeInsets.all(10.0),
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
                            _coverFile = result.files.single.path;
                          } else {
                            _coverFile = null;
                          }
                          setState(() {});
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (_coverFile != null)
                                Text(
                                  (_coverFile ?? '').split('/').last,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.black,
                                  ),
                                ),
                              if (_coverFile == null)
                                Icon(
                                  Ionicons.document_attach_outline,
                                  color: AppColors.primary,
                                  size: 40.0,
                                ),
                              if (_coverFile == null)
                                Text(
                                  '(Doc/Docx or PDF only, and maximum file size allowed is 500 KB)',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: AppColors.grey,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: AppColors.white,
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Your Qualification Level',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const Divider(),
                      DropdownButton<JobTypeModel>(
                        value: _selectedEducation,
                        items: generalController.educationLevels.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(
                              item.name ?? '',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: AppColors.black,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          _selectedEducation = value;
                          setState(() {});
                        },
                        hint: Text(
                          'Select your Qualification Level',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.grey,
                          ),
                        ),
                        isExpanded: true,
                        underline: Container(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: AppColors.white,
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Your Job Experiences',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const Divider(),
                      DropdownButton<JobTypeModel>(
                        value: _selectedExperience,
                        items: generalController.experienceLevels.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(
                              item.name ?? '',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: AppColors.black,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          _selectedExperience = value;
                          setState(() {});
                        },
                        hint: Text(
                          'Select your Job Experiences',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.grey,
                          ),
                        ),
                        isExpanded: true,
                        underline: Container(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                MaterialButton(
                  onPressed: _submit,
                  // onPressed: () {
                  //   Navigator.pushReplacement(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (cxt) => const JobSuccessView(),
                  //     ),
                  //   );
                  // },
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: AppColors.primary,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  minWidth: double.infinity,
                  height: 56.0,
                  elevation: 0.0,
                ),
                const SizedBox(height: 60.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _submit() async {
    FocusScope.of(context).requestFocus(FocusNode());

    if (_selectedEducation == null) {
      await PanaraInfoDialog.showAnimatedGrow(
        context,
        title: "Qualification Not Selected",
        message: "Please select Qualification level to apply for job.",
        buttonText: 'Okay',
        onTapDismiss: () => Navigator.pop(context),
        panaraDialogType: PanaraDialogType.error,
        barrierDismissible: true,
      );
      return;
    }

    if (_selectedExperience == null) {
      await PanaraInfoDialog.showAnimatedGrow(
        context,
        title: "Experience Not Selected",
        message: "Please select your job experience to apply for job.",
        buttonText: 'Okay',
        onTapDismiss: () => Navigator.pop(context),
        panaraDialogType: PanaraDialogType.error,
        barrierDismissible: true,
      );
      return;
    }

    String result = await showDialog(
      context: context,
      builder: (context) => FutureProgressDialog(
        context.read<JobController>().applyForJob(
              jobId: widget.jobDetail.jobKey ?? '',
              qualification: _selectedEducation?.name ?? '',
              experience: _selectedExperience?.name ?? '',
              cv: _cvFile,
              letter: _coverFile,
            ),
      ),
    );
    log(result.toString());
    if (result.isEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (cxt) => const JobSuccessView(),
        ),
      );
    } else {
      await PanaraInfoDialog.showAnimatedGrow(
        context,
        title: "Failed",
        message: "$result Please try again.",
        buttonText: 'Okay',
        onTapDismiss: () => Navigator.pop(context),
        panaraDialogType: PanaraDialogType.error,
        barrierDismissible: true,
      );
      return;
    }
  }
}
