import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:intl/intl.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_colors.dart';
import '../../../controllers/profile_controller.dart';
import '../../../models/experience_model.dart';

class WorkExperienceFormView extends StatefulWidget {
  final ExperienceModel? experience;

  const WorkExperienceFormView({
    Key? key,
    this.experience,
  }) : super(key: key);

  @override
  State<WorkExperienceFormView> createState() => _WorkExperienceFormViewState();
}

class _WorkExperienceFormViewState extends State<WorkExperienceFormView> {
  final _jobTitle = TextEditingController();
  final _company = TextEditingController();
  final _location = TextEditingController();
  final _startDate = TextEditingController();
  final _endDate = TextEditingController();
  final _description = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.experience != null) {
      _jobTitle.text = widget.experience?.jobTitle ?? '';
      _company.text = widget.experience?.company ?? '';
      _location.text = widget.experience?.location ?? '';
      _startDate.text = '${widget.experience?.fromYear ?? ''}'
          '-${widget.experience?.fromMonth ?? ''}';
      _endDate.text = '${widget.experience?.toYear ?? ''}'
          '-${widget.experience?.toMonth ?? ''}';
      _description.text = widget.experience?.workDescription ?? '';
    }
  }

  @override
  void dispose() {
    _jobTitle.dispose();
    _company.dispose();
    _location.dispose();
    _startDate.dispose();
    _endDate.dispose();
    _description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      child: Scaffold(
        backgroundColor: AppColors.primary.withOpacity(0.1),
        appBar: AppBar(
          title: const Text('Add Work Experience'),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    label: const Text(
                      'Job Title',
                    ),
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    fillColor: AppColors.white.withOpacity(0.8),
                    hintStyle: TextStyle(
                      color: AppColors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                    filled: true,
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _jobTitle,
                  // validator: (value) {
                  //   if (((value ?? '').length < 10)) {
                  //     return 'Mobile number must have 10 digits.';
                  //   }
                  //   return null;
                  // },
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    label: const Text(
                      'Company',
                    ),
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    fillColor: AppColors.white.withOpacity(0.8),
                    hintStyle: TextStyle(
                      color: AppColors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                    filled: true,
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _company,
                  // validator: (value) {
                  //   if (((value ?? '').length < 10)) {
                  //     return 'Mobile number must have 10 digits.';
                  //   }
                  //   return null;
                  // },
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    label: const Text(
                      'Location',
                    ),
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    fillColor: AppColors.white.withOpacity(0.8),
                    hintStyle: TextStyle(
                      color: AppColors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                    filled: true,
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _location,
                  // validator: (value) {
                  //   if (((value ?? '').length < 10)) {
                  //     return 'Mobile number must have 10 digits.';
                  //   }
                  //   return null;
                  // },
                ),
                const SizedBox(height: 10.0),
                InkWell(
                  onTap: () async {
                    DateTime? d = await showDatePicker(
                      context: context,
                      initialDate: _startDate.text == ''
                          ? DateTime.now()
                          : DateFormat('yyyy-MM').parse(_startDate.text),
                      firstDate: DateTime(1990),
                      lastDate: DateTime(2100),
                    );

                    if (d != null) {
                      _startDate.text = '${d.year}-${d.month}';
                    }
                  },
                  child: TextFormField(
                    decoration: InputDecoration(
                      label: const Text(
                        'Start Date',
                      ),
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      fillColor: AppColors.white.withOpacity(0.8),
                      hintStyle: TextStyle(
                        color: AppColors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                      filled: true,
                    ),
                    keyboardType: TextInputType.datetime,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    enabled: false,
                    controller: _startDate,
                  ),
                ),
                const SizedBox(height: 10.0),
                InkWell(
                  onTap: () async {
                    DateTime? d = await showDatePicker(
                      context: context,
                      initialDate: _endDate.text == ''
                          ? DateTime.now()
                          : DateFormat('yyyy-MM').parse(_endDate.text),
                      firstDate: DateTime(1990),
                      lastDate: DateTime(2100),
                    );

                    if (d != null) {
                      _endDate.text = '${d.year}-${d.month}';
                    }
                  },
                  child: TextFormField(
                    decoration: InputDecoration(
                      label: const Text(
                        'End Date',
                      ),
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      fillColor: AppColors.white.withOpacity(0.8),
                      hintStyle: TextStyle(
                        color: AppColors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                      filled: true,
                    ),
                    keyboardType: TextInputType.datetime,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    enabled: false,
                    controller: _endDate,
                  ),
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  minLines: 2,
                  maxLines: 6,
                  maxLength: 4000,
                  decoration: InputDecoration(
                    label: const Text(
                      'Work Description (Press enter for list the job description)',
                    ),
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    fillColor: AppColors.white.withOpacity(0.8),
                    hintStyle: TextStyle(
                      color: AppColors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                    filled: true,
                  ),
                  keyboardType: TextInputType.multiline,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _description,
                  // validator: (value) {
                  //   if (((value ?? '').length < 10)) {
                  //     return 'Mobile number must have 10 digits.';
                  //   }
                  //   return null;
                  // },
                ),
                const SizedBox(height: 10.0),
                MaterialButton(
                  onPressed: _add,
                  child: Text(
                    'Add',
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

  _add() async {
    FocusScope.of(context).requestFocus(FocusNode());
    List<String> from = _startDate.text.split('-');
    List<String> to = _endDate.text.split('-');

    String result = await showDialog(
      context: context,
      builder: (context) => FutureProgressDialog(
        context.read<ProfileController>().postExperience(
              id: widget.experience?.id,
              jobTitle: _jobTitle.text,
              company: _company.text,
              location: _location.text,
              fromMonth: from.length == 2 ? from[1] : '',
              fromYear: from.length == 2 ? from[0] : '',
              toMonth: to.length == 2 ? to[1] : '',
              toYear: to.length == 2 ? to[0] : '',
              description: _description.text,
            ),
      ),
    );
    log(result.toString());

    if (result.isEmpty) {
      await PanaraInfoDialog.showAnimatedGrow(
        context,
        title: "Success",
        message: "Work Experience Saved Successfully.",
        buttonText: 'Okay',
        onTapDismiss: () => Navigator.pop(context),
        panaraDialogType: PanaraDialogType.success,
        barrierDismissible: true,
      );
      Navigator.pop(context);
    } else {
      await PanaraInfoDialog.showAnimatedGrow(
        context,
        title: "Failed",
        message: result,
        buttonText: 'Okay',
        onTapDismiss: () => Navigator.pop(context),
        panaraDialogType: PanaraDialogType.error,
        barrierDismissible: true,
      );
      return;
    }
  }
}
