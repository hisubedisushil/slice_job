import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:intl/intl.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_colors.dart';
import '../../../controllers/profile_controller.dart';
import '../../../models/training_model.dart';

class WorkTrainingFormView extends StatefulWidget {
  final TrainingModel? training;

  const WorkTrainingFormView({
    Key? key,
    this.training,
  }) : super(key: key);

  @override
  State<WorkTrainingFormView> createState() => _WorkTrainingFormViewState();
}

class _WorkTrainingFormViewState extends State<WorkTrainingFormView> {
  final _title = TextEditingController();
  final _startDate = TextEditingController();
  final _endDate = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.training != null) {
      _title.text = widget.training?.title ?? '';
      _startDate.text = '${widget.training?.startYear ?? ''}'
          '-${widget.training?.startMonth ?? ''}';
      _endDate.text = '${widget.training?.endYear ?? ''}'
          '-${widget.training?.endMonth ?? ''}';
    }
  }

  @override
  void dispose() {
    _title.dispose();
    _startDate.dispose();
    _endDate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      child: Scaffold(
        backgroundColor: AppColors.primary.withOpacity(0.1),
        appBar: AppBar(
          title: Text(
            '${widget.training != null ? 'Update' : 'Add'} CV Training',
          ),
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
                      'Training Title',
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
                  controller: _title,
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
                    FocusScope.of(context).requestFocus(FocusNode());

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
                    FocusScope.of(context).requestFocus(FocusNode());

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
                MaterialButton(
                  onPressed: _add,
                  child: Text(
                    widget.training != null ? 'Update' : 'Add',
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
        context.read<ProfileController>().postTraining(
              id: widget.training?.id,
              title: _title.text,
              startMonth: from.length == 2 ? from[1] : '',
              startYear: from.length == 2 ? from[0] : '',
              endMonth: to.length == 2 ? from[1] : '',
              endYear: to.length == 2 ? from[0] : '',
            ),
      ),
    );
    log(result.toString());

    if (result.isEmpty) {
      await PanaraInfoDialog.showAnimatedGrow(
        context,
        title: "Success",
        message: "Training Saved Successfully.",
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
