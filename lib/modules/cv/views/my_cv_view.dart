import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_colors.dart';
import '../../../controllers/general_controller.dart';
import '../../../controllers/profile_controller.dart';
import '../../../models/certificate_model.dart';
import '../../../models/city_model.dart';
import '../../../models/country_model.dart';
import '../../../models/cv_basic_model.dart';
import '../../../models/education_model.dart';
import '../../../models/experience_model.dart';
import '../../../models/job_category_model.dart';
import '../../../models/job_title_model.dart';
import '../../../models/job_type_model.dart';
import '../../../models/language_model.dart';
import '../../../models/skill_model.dart';
import '../../../models/training_model.dart';
import '../widgets/title_bar_widget.dart';
import 'work_certificate_form_view.dart';
import 'work_education_form_view.dart';
import 'work_experience_form_view.dart';
import 'work_language_form_view.dart';
import 'work_skill_form_view.dart';
import 'work_training_form_view.dart';

class MyCVView extends StatefulWidget {
  const MyCVView({Key? key}) : super(key: key);

  @override
  State<MyCVView> createState() => _MyCVViewState();
}

class _MyCVViewState extends State<MyCVView> {
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _dob = TextEditingController();
  String? _gender;
  CountryModel? _nationality;
  String? _maritalStatus;
  CountryModel? _currentLocation;
  CityModel? _currentCity;

  final _email = TextEditingController();
  final _mobile = TextEditingController();
  final _website = TextEditingController();

  JobCategoryModel? _jobRole;
  JobTitleModel? _jobTitle;
  JobTypeModel? _careerLevel;
  JobTypeModel? _jobType;
  final _targetSalary = TextEditingController();
  String? _currency;

  final List<String> _genders = ['Male', 'Female', 'Other'];
  final List<String> _maritalStatusTypes = ['Male', 'Female', 'Other'];
  final List<String> _currencyFormats = ['USD', 'NRP'];
  List<JobTitleModel> _jobTitles = [];
  List<CityModel> _cities = [];

  @override
  void initState() {
    super.initState();

    CVBasicModel? model = context.read<ProfileController>().cvBasic;
    if (model != null) {
      final general = context.read<GeneralController>();

      _firstName.text = model.firstName ?? '';
      _lastName.text = model.lastName ?? '';
      _dob.text = model.birthYear != null
          ? '${model.birthYear}-${model.birthMonth}-${model.birthDay}'
          : '';
      try {
        _gender = _genders.firstWhere(
          (e) => model.gender == e,
        );
      } catch (e) {}
      try {
        _nationality = general.countries.firstWhere(
          (e) => model.nationality == e.name,
        );
      } catch (e) {}
      try {
        _currentLocation = general.countries.firstWhere(
          (e) => model.currentCountry == e.name,
        );
      } catch (e) {}
      try {
        _cities.add(CityModel(name: model.currentCity ?? ''));
        _currentCity = _cities.first;
      } catch (e) {}

      _email.text = model.email ?? '';
      _mobile.text = model.contactNumber ?? '';
      _website.text = model.website ?? '';
      // _jobRole = model.website ?? '';
      // _jobTitle = model.website ?? '';
      try {
        _jobRole = general.allCategories.firstWhere(
          (e) => model.jobRole == e.name,
        );
      } catch (e) {}
      try {
        _jobTitles.add(JobTitleModel(title: model.jobRole ?? ''));
        _jobTitle = _jobTitles.first;
      } catch (e) {}
      // _careerLevel = model.website ?? '';
      try {
        _careerLevel = general.jobCareerLevels.firstWhere(
          (e) => model.careerLevel == e.name,
        );
      } catch (e) {}
      // _jobType = model.website ?? '';
      try {
        _jobType = general.jobTypes.firstWhere(
          (e) => model.jobType == e.name,
        );
      } catch (e) {}
      _targetSalary.text = model.targetSalary ?? '';
      // _currency = model.website ?? '';
      try {
        _currency = _currencyFormats.firstWhere(
          (e) => model.targetSalaryCurrency == e,
        );
      } catch (e) {}
    }
  }

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _dob.dispose();
    _email.dispose();
    _mobile.dispose();
    _website.dispose();
    _targetSalary.dispose();
    super.dispose();
  }

  _loadCity(country) async {
    _currentLocation = country;
    _currentCity = null;
    _cities.clear();
    setState(() {});
    _cities = await context
        .read<GeneralController>()
        .getCities(countryId: country.id ?? '');
    setState(() {});
  }

  _loadJobTitles(category) async {
    _jobRole = category;
    _jobTitle = null;
    _jobTitles.clear();
    setState(() {});
    _jobTitles = await context
        .read<GeneralController>()
        .getJobTitles(categoryId: category.id ?? '');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<ProfileController>();
    final general = context.watch<GeneralController>();
    return Material(
      color: AppColors.white,
      child: Scaffold(
        backgroundColor: AppColors.primary.withOpacity(0.1),
        appBar: AppBar(
          title: const Text('My CV'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Ionicons.eye_outline),
              tooltip: 'View CV',
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Ionicons.download_outline),
              tooltip: 'Download CV',
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 10.0,
            right: 10.0,
            top: 10.0,
            bottom: 60.0,
          ),
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              /// Basic
              const TitleBarWidget(title: 'Basic Information'),
              const SizedBox(height: 10.0),
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
                        setState(() {});
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
                      'Nationality',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    const Divider(),
                    DropdownButton<CountryModel>(
                      value: _nationality,
                      items: general.countries.map((item) {
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
                        _nationality = value;
                        setState(() {});
                      },
                      hint: Text(
                        'Select your nationality',
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
                      'Marital Status',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    const Divider(),
                    DropdownButton<String>(
                      value: _maritalStatus,
                      items: _maritalStatusTypes.map((item) {
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
                        _maritalStatus = value;
                        setState(() {});
                      },
                      hint: Text(
                        'Select your marital status',
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
                      'Current Location',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    const Divider(),
                    DropdownButton<CountryModel>(
                      value: _currentLocation,
                      items: general.countries.map((item) {
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
                      onChanged: _loadCity,
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
                    const Divider(),
                    DropdownButton<CityModel>(
                      value: _currentCity,
                      items: _cities.map((item) {
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
                        _currentCity = value;
                        setState(() {});
                      },
                      hint: Text(
                        'Select your current city',
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
              Align(
                alignment: Alignment.centerLeft,
                child: MaterialButton(
                  onPressed: _saveBasicInformation,
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
              const SizedBox(height: 20.0),

              /// Contact
              const TitleBarWidget(title: 'Contact Information'),
              const SizedBox(height: 10.0),
              TextFormField(
                decoration: InputDecoration(
                  label: const Text(
                    'Email',
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
                keyboardType: TextInputType.emailAddress,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  bool b = RegExp(
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                      .hasMatch(value ?? '');
                  if (!b) {
                    return 'Please enter valid email address';
                  }
                  return null;
                },
                controller: _email,
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
              TextFormField(
                decoration: InputDecoration(
                  label: const Text(
                    'Website',
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
                keyboardType: TextInputType.url,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _website,
              ),
              const SizedBox(height: 10.0),
              Align(
                alignment: Alignment.centerLeft,
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
              const SizedBox(height: 20.0),

              /// Target
              const TitleBarWidget(title: 'Target Job'),
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
                      'Job Role',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    const Divider(),
                    DropdownButton<JobCategoryModel>(
                      value: _jobRole,
                      items: general.allCategories.map((item) {
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
                      onChanged: _loadJobTitles,
                      hint: Text(
                        'Select target job role',
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
                      'Desired Job Title',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    const Divider(),
                    DropdownButton<JobTitleModel>(
                      value: _jobTitle,
                      items: _jobTitles.map((item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(
                            item.title ?? '',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        _jobTitle = value;
                        setState(() {});
                      },
                      hint: Text(
                        'Select target job title',
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
                      'Career Level',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    const Divider(),
                    DropdownButton<JobTypeModel>(
                      value: _careerLevel,
                      items: general.jobCareerLevels.map((item) {
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
                        _careerLevel = value;
                        setState(() {});
                      },
                      hint: Text(
                        'Select target career level',
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
                      'Job Type',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    const Divider(),
                    DropdownButton<JobTypeModel>(
                      value: _jobType,
                      items: general.jobTypes.map((item) {
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
                        _jobType = value;
                        setState(() {});
                      },
                      hint: Text(
                        'Select target job type',
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
                    'Target Salary',
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
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _targetSalary,
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
                      'Currency Format',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    const Divider(),
                    DropdownButton<String>(
                      value: _currency,
                      items: _currencyFormats.map((item) {
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
                        _currency = value;
                        setState(() {});
                      },
                      hint: Text(
                        'Select currency format',
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
              Align(
                alignment: Alignment.centerLeft,
                child: MaterialButton(
                  onPressed: _saveTargetJobInformation,
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
              const SizedBox(height: 20.0),

              /// Work
              TitleBarWidget(
                title: 'Work Experience',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const WorkExperienceFormView(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10.0),
              ListView.separated(
                itemBuilder: (cxt, index) {
                  final work = profile.experienceList[index];
                  return Material(
                    color: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      dense: true,
                      isThreeLine: true,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              work.jobTitle ?? '',
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          PopupMenuButton(
                            itemBuilder: (cxt) => [
                              const PopupMenuItem(
                                child: Text("Edit"),
                                value: 1,
                              ),
                              const PopupMenuItem(
                                child: Text("Delete"),
                                value: 2,
                              ),
                            ],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            onSelected: (value) async {
                              if (value == 2) {
                                await PanaraConfirmDialog.showAnimatedGrow(
                                  context,
                                  title: 'Confirmation',
                                  message: 'Do you want to delete this  item?',
                                  cancelButtonText: 'No',
                                  confirmButtonText: 'Yes',
                                  onTapCancel: () => Navigator.pop(context),
                                  onTapConfirm: () {
                                    Navigator.pop(context);
                                    _deleteWork(work: work);
                                  },
                                  panaraDialogType: PanaraDialogType.warning,
                                  barrierDismissible: true,
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => WorkExperienceFormView(
                                      experience: work,
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            work.location ?? '',
                            style: TextStyle(
                              color: AppColors.primary.withOpacity(0.7),
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${work.fromMonth}/${work.fromYear} '
                            '- '
                            '${work.toMonth}/${work.toYear}',
                            style: TextStyle(
                              color: AppColors.primary.withOpacity(0.7),
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '\u2713  ${work.workDescription}',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: AppColors.grey,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (cxt, index) {
                  return const SizedBox(height: 10.0);
                },
                itemCount: profile.experienceList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              ),

              /// Education
              TitleBarWidget(
                title: 'Education (Upload your highest degree at last.)',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const WorkEducationFormView(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10.0),
              ListView.separated(
                itemBuilder: (cxt, index) {
                  final education = profile.educationList[index];
                  return Material(
                    color: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      dense: true,
                      isThreeLine: true,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              education.degree ?? '',
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          PopupMenuButton(
                            itemBuilder: (cxt) => [
                              const PopupMenuItem(
                                child: Text("Edit"),
                                value: 1,
                              ),
                              const PopupMenuItem(
                                child: Text("Delete"),
                                value: 2,
                              ),
                            ],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            onSelected: (value) async {
                              if (value == 2) {
                                await PanaraConfirmDialog.showAnimatedGrow(
                                  context,
                                  title: 'Confirmation',
                                  message: 'Do you want to delete this  item?',
                                  cancelButtonText: 'No',
                                  confirmButtonText: 'Yes',
                                  onTapCancel: () => Navigator.pop(context),
                                  onTapConfirm: () {
                                    Navigator.pop(context);
                                    _deleteEducation(education: education);
                                  },
                                  panaraDialogType: PanaraDialogType.warning,
                                  barrierDismissible: true,
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => WorkEducationFormView(
                                      education: education,
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            education.field ?? '',
                            style: TextStyle(
                              color: AppColors.primary.withOpacity(0.7),
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${education.city ?? ' '}, '
                            '${education.country ?? ' '}',
                            style: TextStyle(
                              color: AppColors.primary.withOpacity(0.7),
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${education.startMonth}/${education.startYear} '
                            '- '
                            '${education.endMonth}/${education.endYear}',
                            style: TextStyle(
                              color: AppColors.primary.withOpacity(0.7),
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (cxt, index) {
                  return const SizedBox(height: 10.0);
                },
                itemCount: profile.educationList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              ),

              /// Skill
              TitleBarWidget(
                title: 'Skills',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const WorkSkillFormView(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10.0),
              ListView.separated(
                itemBuilder: (cxt, index) {
                  final skill = profile.skillList[index];
                  return Material(
                    color: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      dense: true,
                      isThreeLine: true,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              skill.skill ?? '',
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          PopupMenuButton(
                            itemBuilder: (cxt) => [
                              const PopupMenuItem(
                                child: Text("Edit"),
                                value: 1,
                              ),
                              const PopupMenuItem(
                                child: Text("Delete"),
                                value: 2,
                              ),
                            ],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            onSelected: (value) async {
                              if (value == 2) {
                                await PanaraConfirmDialog.showAnimatedGrow(
                                  context,
                                  title: 'Confirmation',
                                  message: 'Do you want to delete this  item?',
                                  cancelButtonText: 'No',
                                  confirmButtonText: 'Yes',
                                  onTapCancel: () => Navigator.pop(context),
                                  onTapConfirm: () {
                                    Navigator.pop(context);
                                    _deleteSkill(skill: skill);
                                  },
                                  panaraDialogType: PanaraDialogType.warning,
                                  barrierDismissible: true,
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => WorkSkillFormView(
                                      skill: skill,
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            skill.level ?? '',
                            style: TextStyle(
                              color: AppColors.primary.withOpacity(0.7),
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (cxt, index) {
                  return const SizedBox(height: 10.0);
                },
                itemCount: profile.skillList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              ),

              /// Language
              TitleBarWidget(
                title: 'Language',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const WorkLanguageFormView(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10.0),
              ListView.separated(
                itemBuilder: (cxt, index) {
                  final language = profile.languageList[index];
                  return Material(
                    color: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      dense: true,
                      isThreeLine: true,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              language.language ?? '',
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          PopupMenuButton(
                            itemBuilder: (cxt) => [
                              const PopupMenuItem(
                                child: Text("Edit"),
                                value: 1,
                              ),
                              const PopupMenuItem(
                                child: Text("Delete"),
                                value: 2,
                              ),
                            ],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            onSelected: (value) async {
                              if (value == 2) {
                                await PanaraConfirmDialog.showAnimatedGrow(
                                  context,
                                  title: 'Confirmation',
                                  message: 'Do you want to delete this  item?',
                                  cancelButtonText: 'No',
                                  confirmButtonText: 'Yes',
                                  onTapCancel: () => Navigator.pop(context),
                                  onTapConfirm: () {
                                    Navigator.pop(context);
                                    _deleteLanguage(language: language);
                                  },
                                  panaraDialogType: PanaraDialogType.warning,
                                  barrierDismissible: true,
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => WorkLanguageFormView(
                                      language: language,
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            language.level ?? '',
                            style: TextStyle(
                              color: AppColors.primary.withOpacity(0.7),
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (cxt, index) {
                  return const SizedBox(height: 10.0);
                },
                itemCount: profile.languageList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              ),

              /// Training
              TitleBarWidget(
                title: 'Training',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const WorkTrainingFormView(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10.0),
              ListView.separated(
                itemBuilder: (cxt, index) {
                  final training = profile.trainingList[index];
                  return Material(
                    color: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      dense: true,
                      isThreeLine: true,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              training.title ?? '',
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          PopupMenuButton(
                            itemBuilder: (cxt) => [
                              const PopupMenuItem(
                                child: Text("Edit"),
                                value: 1,
                              ),
                              const PopupMenuItem(
                                child: Text("Delete"),
                                value: 2,
                              ),
                            ],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            onSelected: (value) async {
                              if (value == 2) {
                                await PanaraConfirmDialog.showAnimatedGrow(
                                  context,
                                  title: 'Confirmation',
                                  message: 'Do you want to delete this  item?',
                                  cancelButtonText: 'No',
                                  confirmButtonText: 'Yes',
                                  onTapCancel: () => Navigator.pop(context),
                                  onTapConfirm: () {
                                    Navigator.pop(context);
                                    _deleteTraining(training: training);
                                  },
                                  panaraDialogType: PanaraDialogType.warning,
                                  barrierDismissible: true,
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => WorkTrainingFormView(
                                      training: training,
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${training.startMonth}/${training.startYear} '
                            '- '
                            '${training.endMonth}/${training.endYear}',
                            style: TextStyle(
                              color: AppColors.primary.withOpacity(0.7),
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (cxt, index) {
                  return const SizedBox(height: 10.0);
                },
                itemCount: profile.trainingList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              ),

              /// Certificates
              TitleBarWidget(
                title: 'Certificates',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const WorkCertificateFormView(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10.0),
              ListView.separated(
                itemBuilder: (cxt, index) {
                  final certificate = profile.certificateList[index];
                  return Material(
                    color: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      dense: true,
                      isThreeLine: true,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              certificate.title ?? '',
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          PopupMenuButton(
                            itemBuilder: (cxt) => [
                              const PopupMenuItem(
                                child: Text("Edit"),
                                value: 1,
                              ),
                              const PopupMenuItem(
                                child: Text("Delete"),
                                value: 2,
                              ),
                            ],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            onSelected: (value) async {
                              if (value == 2) {
                                await PanaraConfirmDialog.showAnimatedGrow(
                                  context,
                                  title: 'Confirmation',
                                  message: 'Do you want to delete this  item?',
                                  cancelButtonText: 'No',
                                  confirmButtonText: 'Yes',
                                  onTapCancel: () => Navigator.pop(context),
                                  onTapConfirm: () {
                                    Navigator.pop(context);
                                    _deleteCertificate(
                                        certificate: certificate);
                                  },
                                  panaraDialogType: PanaraDialogType.warning,
                                  barrierDismissible: true,
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => WorkCertificateFormView(
                                      certificate: certificate,
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${certificate.issueMonth}/${certificate.issueYear} '
                            '- '
                            '${certificate.expireMonth}/${certificate.expireYear}',
                            style: TextStyle(
                              color: AppColors.primary.withOpacity(0.7),
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '\u2713  ${certificate.description}',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: AppColors.grey,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (cxt, index) {
                  return const SizedBox(height: 10.0);
                },
                itemCount: profile.certificateList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              ),

              /// CV
              TitleBarWidget(
                title: 'Original CV',
                onTap: _saveOriginalCV,
              ),
              const SizedBox(height: 10.0),
              if (_cvFile != null)
                Material(
                  color: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    dense: true,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            _cvFile ?? '',
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        // PopupMenuButton(
                        //   itemBuilder: (cxt) => [
                        //     const PopupMenuItem(
                        //       child: Text("Delete"),
                        //       value: 2,
                        //     ),
                        //   ],
                        //   shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(10.0),
                        //   ),
                        //   onSelected: (value) {
                        //     if (value == 2) {
                        //       _deleteCertificate(certificate: certificate);
                        //     }
                        //   },
                        // ),
                      ],
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  _saveBasicInformation() async {
    FocusScope.of(context).requestFocus(FocusNode());

    String result = await showDialog(
      context: context,
      builder: (context) => FutureProgressDialog(
        context.read<ProfileController>().updateCVBasicInformation(
              firstName: _firstName.text,
              lastName: _lastName.text,
              birthDate: _dob.text,
              gender: _gender ?? '',
              nationality: _nationality?.name ?? '',
              maritalStatus: _maritalStatus ?? '',
              currentCountry: _currentLocation?.name ?? '',
              currentCity: _currentCity?.name ?? '',
            ),
      ),
    );
    log(result.toString());

    if (result.isEmpty) {
      await PanaraInfoDialog.showAnimatedGrow(
        context,
        title: "Success",
        message: "Basic Information Updated Successfully.",
        buttonText: 'Okay',
        onTapDismiss: () => Navigator.pop(context),
        panaraDialogType: PanaraDialogType.success,
        barrierDismissible: true,
      );
      return;
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

  _saveContactInformation() async {
    FocusScope.of(context).requestFocus(FocusNode());

    String result = await showDialog(
      context: context,
      builder: (context) => FutureProgressDialog(
        context.read<ProfileController>().updateCVContactInformation(
              email: _email.text,
              contactNumber: _mobile.text,
              website: _website.text,
            ),
      ),
    );
    log(result.toString());

    if (result.isEmpty) {
      await PanaraInfoDialog.showAnimatedGrow(
        context,
        title: "Success",
        message: "Contact Information Updated Successfully.",
        buttonText: 'Okay',
        onTapDismiss: () => Navigator.pop(context),
        panaraDialogType: PanaraDialogType.success,
        barrierDismissible: true,
      );
      return;
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

  _saveTargetJobInformation() async {
    FocusScope.of(context).requestFocus(FocusNode());

    String result = await showDialog(
      context: context,
      builder: (context) => FutureProgressDialog(
        context.read<ProfileController>().updateCVTargetJob(
              jobRoleId: _jobRole?.id ?? '',
              jobTitle: _jobTitle?.title ?? '',
              level: _careerLevel?.name ?? '',
              type: _jobType?.name ?? '',
              salary: _targetSalary.text,
              currency: _currency ?? '',
            ),
      ),
    );
    log(result.toString());

    if (result.isEmpty) {
      await PanaraInfoDialog.showAnimatedGrow(
        context,
        title: "Success",
        message: "Target Job Information Updated Successfully.",
        buttonText: 'Okay',
        onTapDismiss: () => Navigator.pop(context),
        panaraDialogType: PanaraDialogType.success,
        barrierDismissible: true,
      );
      return;
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

  _deleteWork({required ExperienceModel work}) async {
    FocusScope.of(context).requestFocus(FocusNode());

    String result = await showDialog(
      context: context,
      builder: (context) => FutureProgressDialog(
        context.read<ProfileController>().deleteExperience(id: work.id ?? ''),
      ),
    );
    log(result.toString());

    if (result.isEmpty) {
      await PanaraInfoDialog.showAnimatedGrow(
        context,
        title: "Success",
        message: "Work Experience Deleted Successfully.",
        buttonText: 'Okay',
        onTapDismiss: () => Navigator.pop(context),
        panaraDialogType: PanaraDialogType.success,
        barrierDismissible: true,
      );
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

  _deleteEducation({required EducationModel education}) async {
    FocusScope.of(context).requestFocus(FocusNode());

    String result = await showDialog(
      context: context,
      builder: (context) => FutureProgressDialog(
        context.read<ProfileController>().deleteEducation(
              id: education.id ?? '',
            ),
      ),
    );
    log(result.toString());

    if (result.isEmpty) {
      await PanaraInfoDialog.showAnimatedGrow(
        context,
        title: "Success",
        message: "Education Deleted Successfully.",
        buttonText: 'Okay',
        onTapDismiss: () => Navigator.pop(context),
        panaraDialogType: PanaraDialogType.success,
        barrierDismissible: true,
      );
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

  _deleteSkill({required SkillModel skill}) async {
    FocusScope.of(context).requestFocus(FocusNode());

    String result = await showDialog(
      context: context,
      builder: (context) => FutureProgressDialog(
        context.read<ProfileController>().deleteSkill(
              id: skill.id ?? '',
            ),
      ),
    );
    log(result.toString());

    if (result.isEmpty) {
      await PanaraInfoDialog.showAnimatedGrow(
        context,
        title: "Success",
        message: "Skill Deleted Successfully.",
        buttonText: 'Okay',
        onTapDismiss: () => Navigator.pop(context),
        panaraDialogType: PanaraDialogType.success,
        barrierDismissible: true,
      );
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

  _deleteLanguage({required LanguageModel language}) async {
    FocusScope.of(context).requestFocus(FocusNode());

    String result = await showDialog(
      context: context,
      builder: (context) => FutureProgressDialog(
        context.read<ProfileController>().deleteLanguage(
              id: language.id ?? '',
            ),
      ),
    );
    log(result.toString());

    if (result.isEmpty) {
      await PanaraInfoDialog.showAnimatedGrow(
        context,
        title: "Success",
        message: "Language Deleted Successfully.",
        buttonText: 'Okay',
        onTapDismiss: () => Navigator.pop(context),
        panaraDialogType: PanaraDialogType.success,
        barrierDismissible: true,
      );
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

  _deleteTraining({required TrainingModel training}) async {
    FocusScope.of(context).requestFocus(FocusNode());

    String result = await showDialog(
      context: context,
      builder: (context) => FutureProgressDialog(
        context.read<ProfileController>().deleteTraining(
              id: training.id ?? '',
            ),
      ),
    );
    log(result.toString());

    if (result.isEmpty) {
      await PanaraInfoDialog.showAnimatedGrow(
        context,
        title: "Success",
        message: "Training Deleted Successfully.",
        buttonText: 'Okay',
        onTapDismiss: () => Navigator.pop(context),
        panaraDialogType: PanaraDialogType.success,
        barrierDismissible: true,
      );
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

  _deleteCertificate({required CertificateModel certificate}) async {
    FocusScope.of(context).requestFocus(FocusNode());

    String result = await showDialog(
      context: context,
      builder: (context) => FutureProgressDialog(
        context.read<ProfileController>().deleteCertificate(
              id: certificate.id ?? '',
            ),
      ),
    );
    log(result.toString());

    if (result.isEmpty) {
      await PanaraInfoDialog.showAnimatedGrow(
        context,
        title: "Success",
        message: "Certificate Deleted Successfully.",
        buttonText: 'Okay',
        onTapDismiss: () => Navigator.pop(context),
        panaraDialogType: PanaraDialogType.success,
        barrierDismissible: true,
      );
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

  String? _cvFile;
  _saveOriginalCV() async {
    FocusScope.of(context).requestFocus(FocusNode());

    FilePickerResult? file = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (file != null) {
      _cvFile = (file.files.single.path ?? '').split('/').last;

      String result = await showDialog(
        context: context,
        builder: (context) => FutureProgressDialog(
          context
              .read<ProfileController>()
              .uploadOriginalCV(cv: file.files.single.path ?? ''),
        ),
      );
      log(result.toString());

      if (result.isEmpty) {
        await PanaraInfoDialog.showAnimatedGrow(
          context,
          title: "Success",
          message: "CV Updated Successfully.",
          buttonText: 'Okay',
          onTapDismiss: () => Navigator.pop(context),
          panaraDialogType: PanaraDialogType.success,
          barrierDismissible: true,
        );
        return;
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
}
