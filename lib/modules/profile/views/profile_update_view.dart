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
import '../../../models/job_type_model.dart';

class ProfileUpdateView extends StatefulWidget {
  const ProfileUpdateView({Key? key}) : super(key: key);

  @override
  State<ProfileUpdateView> createState() => _ProfileUpdateViewState();
}

class _ProfileUpdateViewState extends State<ProfileUpdateView> {
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _dob = TextEditingController();
  final _nationality = TextEditingController();
  final _city = TextEditingController();
  final _mobile = TextEditingController();
  CountryModel? _country;
  String? _gender;
  JobTypeModel? _qualification;
  JobTypeModel? _experience;

  List<String> _genders = ['Male', 'Female', 'Other'];

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    final profile = context.read<ProfileController>().profile;
    final general = context.read<GeneralController>();
    _firstName.text = profile?.firstName ?? '';
    _lastName.text = profile?.lastName ?? '';
    _dob.text = profile?.dob ?? '';
    _nationality.text = profile?.nationality ?? '';
    _city.text = profile?.currCity ?? '';
    _mobile.text = profile?.mobileNumber ?? '';
    try {
      _gender = _genders.firstWhere(
        (e) => profile?.gender == e,
      );
    } catch (e) {}
    try {
      _country = general.countries.firstWhere(
        (e) => profile?.currCountry == e.name,
      );
    } catch (e) {}
    try {
      _qualification = general.educationLevels.firstWhere(
        (e) => profile?.qualification == e.name,
      );
    } catch (e) {}
    try {
      _experience = general.experienceLevels.firstWhere(
        (e) => profile?.experience == e.name,
      );
    } catch (e) {}
  }

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _dob.dispose();
    _nationality.dispose();
    _city.dispose();
    _mobile.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final generalController = context.watch<GeneralController>();

    return Material(
      color: AppColors.white,
      child: Scaffold(
        backgroundColor: AppColors.primary.withOpacity(0.1),
        appBar: AppBar(
          title: const Text('Update Profile'),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: TextFormField(
                        decoration: InputDecoration(
                          label: const Text(
                            'First Name',
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
                        validator: (value) {
                          if (((value ?? '').isEmpty)) {
                            return 'Please enter first name.';
                          }
                          return null;
                        },
                        controller: _firstName,
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: TextFormField(
                        decoration: InputDecoration(
                          label: const Text(
                            'Last Name',
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
                        validator: (value) {
                          if (((value ?? '').isEmpty)) {
                            return 'Please enter last name.';
                          }
                          return null;
                        },
                        controller: _lastName,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                InkWell(
                  onTap: () async {
                    DateTime? d = await showDatePicker(
                      context: context,
                      initialDate: _dob.text == ''
                          ? DateTime.now()
                          : DateFormat('yyyy-MM-dd').parse(_dob.text),
                      firstDate: DateTime(1990),
                      lastDate: DateTime(2100),
                    );

                    if (d != null) {
                      _dob.text = '${d.year}-${d.month}-${d.day}';
                    }
                  },
                  child: TextFormField(
                    decoration: InputDecoration(
                      label: const Text(
                        'Date Of Birth',
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
                    controller: _dob,
                  ),
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    label: const Text(
                      'Mobile Number',
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
                  keyboardType: TextInputType.phone,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _mobile,
                  validator: (value) {
                    if (((value ?? '').length < 10)) {
                      return 'Mobile number must have 10 digits.';
                    }
                    return null;
                  },
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
                        'Current Country',
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
                          if (mounted) {
                            setState(() {});
                          }
                        },
                        hint: Text(
                          'Select your current country',
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
                        'Gender',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const Divider(),
                      DropdownButton<String>(
                        value: _gender,
                        items: _genders.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(
                              item,
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: AppColors.black,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          _gender = value;
                          if (mounted) {
                            setState(() {});
                          }
                        },
                        hint: Text(
                          'Select your gender',
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
                      'Current City',
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
                  validator: (value) {
                    if (((value ?? '').isEmpty)) {
                      return 'Please enter current city.';
                    }
                    return null;
                  },
                  controller: _city,
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    label: const Text(
                      'Nationality',
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
                  controller: _nationality,
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
                        'Qualification',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const Divider(),
                      DropdownButton<JobTypeModel>(
                        value: _qualification,
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
                          _qualification = value;
                          if (mounted) {
                            setState(() {});
                          }
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
                        'Job Experiences',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const Divider(),
                      DropdownButton<JobTypeModel>(
                        value: _experience,
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
                          _experience = value;
                          if (mounted) {
                            setState(() {});
                          }
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
                  onPressed: _update,
                  child: Text(
                    'Update',
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

  _update() async {
    FocusScope.of(context).requestFocus(FocusNode());

    if (_firstName.text.isEmpty) {
      await PanaraInfoDialog.showAnimatedGrow(
        context,
        title: "Invalid First Name",
        message: "Please enter first name.",
        buttonText: 'Okay',
        onTapDismiss: () => Navigator.pop(context),
        panaraDialogType: PanaraDialogType.error,
        barrierDismissible: true,
      );
      return;
    }

    if (_lastName.text.isEmpty) {
      await PanaraInfoDialog.showAnimatedGrow(
        context,
        title: "Invalid Last Name",
        message: "Please enter last name.",
        buttonText: 'Okay',
        onTapDismiss: () => Navigator.pop(context),
        panaraDialogType: PanaraDialogType.error,
        barrierDismissible: true,
      );
      return;
    }

    if (_mobile.text.length < 10) {
      await PanaraInfoDialog.showAnimatedGrow(
        context,
        title: "Invalid Mobile Number",
        message: "Mobile number must have 10 digits.",
        buttonText: 'Okay',
        onTapDismiss: () => Navigator.pop(context),
        panaraDialogType: PanaraDialogType.error,
        barrierDismissible: true,
      );
      return;
    }

    if (_dob.text.isEmpty) {
      await PanaraInfoDialog.showAnimatedGrow(
        context,
        title: "Invalid Date of Birth",
        message: "Please select your date of birth.",
        buttonText: 'Okay',
        onTapDismiss: () => Navigator.pop(context),
        panaraDialogType: PanaraDialogType.error,
        barrierDismissible: true,
      );
      return;
    }

    if (_nationality.text.isEmpty) {
      await PanaraInfoDialog.showAnimatedGrow(
        context,
        title: "Invalid Nationality",
        message: "Please enter your nationality.",
        buttonText: 'Okay',
        onTapDismiss: () => Navigator.pop(context),
        panaraDialogType: PanaraDialogType.error,
        barrierDismissible: true,
      );
      return;
    }

    if (_gender == null) {
      await PanaraInfoDialog.showAnimatedGrow(
        context,
        title: "Invalid Gender",
        message: "Please select your gender.",
        buttonText: 'Okay',
        onTapDismiss: () => Navigator.pop(context),
        panaraDialogType: PanaraDialogType.error,
        barrierDismissible: true,
      );
      return;
    }

    if (_country == null) {
      await PanaraInfoDialog.showAnimatedGrow(
        context,
        title: "Invalid Country",
        message: "Please select your current country.",
        buttonText: 'Okay',
        onTapDismiss: () => Navigator.pop(context),
        panaraDialogType: PanaraDialogType.error,
        barrierDismissible: true,
      );
      return;
    }

    if (_city.text.isEmpty) {
      await PanaraInfoDialog.showAnimatedGrow(
        context,
        title: "Invalid City",
        message: "Please enter your current city.",
        buttonText: 'Okay',
        onTapDismiss: () => Navigator.pop(context),
        panaraDialogType: PanaraDialogType.error,
        barrierDismissible: true,
      );
      return;
    }

    if (_qualification == null) {
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

    if (_experience == null) {
      await PanaraInfoDialog.showAnimatedGrow(
        context,
        title: "Experience Not Selected",
        message: "Please select your total job experience to apply for job.",
        buttonText: 'Okay',
        onTapDismiss: () => Navigator.pop(context),
        panaraDialogType: PanaraDialogType.error,
        barrierDismissible: true,
      );
      return;
    }

    bool result = await showDialog(
      context: context,
      builder: (context) => FutureProgressDialog(
        context.read<ProfileController>().updateProfile(
              firstName: _firstName.text,
              lastName: _lastName.text,
              dob: _dob.text,
              nationality: _nationality.text,
              gender: _gender ?? '',
              currentCountry: _country?.name ?? '',
              currentCity: _city.text,
              qualification: _qualification?.name ?? '',
              experience: _experience?.name ?? '',
              mobile: _mobile.text,
            ),
      ),
    );
    log(result.toString());

    if (result) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Your profile is successfully updated.',
            textAlign: TextAlign.center,
          ),
          backgroundColor: AppColors.green,
        ),
      );
    } else {
      await PanaraInfoDialog.showAnimatedGrow(
        context,
        title: "Update Failed",
        message: "Oops! Something went wrong. Please try again.",
        buttonText: 'Okay',
        onTapDismiss: () => Navigator.pop(context),
        panaraDialogType: PanaraDialogType.error,
        barrierDismissible: true,
      );
    }
  }
}
