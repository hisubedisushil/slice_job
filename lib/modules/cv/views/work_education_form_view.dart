import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:intl/intl.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_colors.dart';
import '../../../controllers/general_controller.dart';
import '../../../controllers/profile_controller.dart';
import '../../../models/country_model.dart';
import '../../../models/education_model.dart';

class WorkEducationFormView extends StatefulWidget {
  final EducationModel? education;

  const WorkEducationFormView({
    Key? key,
    this.education,
  }) : super(key: key);

  @override
  State<WorkEducationFormView> createState() => _WorkEducationFormViewState();
}

class _WorkEducationFormViewState extends State<WorkEducationFormView> {
  final _degree = TextEditingController();
  final _field = TextEditingController();
  final _institution = TextEditingController();
  final _city = TextEditingController();
  final _startDate = TextEditingController();
  final _endDate = TextEditingController();
  CountryModel? _country;

  @override
  void initState() {
    super.initState();

    if (widget.education != null) {
      _degree.text = widget.education?.degree ?? '';
      _field.text = widget.education?.field ?? '';
      _institution.text = widget.education?.institution ?? '';
      _city.text = widget.education?.city ?? '';
      _startDate.text = '${widget.education?.startYear ?? ''}'
          '-${widget.education?.startMonth ?? ''}';
      _endDate.text = '${widget.education?.endYear ?? ''}'
          '-${widget.education?.endMonth ?? ''}';
      try {
        _country = context.read<GeneralController>().countries.firstWhere(
              (e) => widget.education?.country == e.name,
            );
      } catch (e) {}
    }
  }

  @override
  void dispose() {
    _degree.dispose();
    _field.dispose();
    _institution.dispose();
    _city.dispose();
    _startDate.dispose();
    _endDate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final generalController = context.read<GeneralController>();

    return Material(
      color: AppColors.white,
      child: Scaffold(
        backgroundColor: AppColors.primary.withOpacity(0.1),
        appBar: AppBar(
          title: const Text('Add Education'),
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
                      'Degree',
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
                  controller: _degree,
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
                      'Field of Study',
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
                  controller: _field,
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
                      'Institution',
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
                  controller: _institution,
                  // validator: (value) {
                  //   if (((value ?? '').length < 10)) {
                  //     return 'Mobile number must have 10 digits.';
                  //   }
                  //   return null;
                  // },
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
                        'Country',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const Divider(),
                      DropdownButton<CountryModel>(
                        value: _country,
                        items: generalController.countries.map((item) {
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
                          _country = value;
                          setState(() {});
                        },
                        hint: Text(
                          'Select country',
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
                TextFormField(
                  decoration: InputDecoration(
                    label: const Text(
                      'City',
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
                  controller: _city,
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
        context.read<ProfileController>().postEducation(
              id: widget.education?.id,
              degree: _degree.text,
              field: _field.text,
              institution: _institution.text,
              country: _country?.name ?? '',
              city: _city.text,
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
        message: "Education Saved Successfully.",
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
