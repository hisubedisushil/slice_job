import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ionicons/ionicons.dart';
import 'package:slice_job/app_setup/routes/router.dart';
import 'package:slice_job/constants/app_colors.dart';
import 'package:slice_job/core/models/country.dart';
import 'package:slice_job/core/widgets/slicejob_input_fields.dart';
import 'package:slice_job/features/auth/views/register_screen.dart';
import 'package:slice_job/features/profile/provider/profile_provider.dart';
import 'package:slice_job/features/profile/widgets/section_bar_widget.dart';
import 'package:slice_job/helpers/extensions/context_extension.dart';
import 'package:slice_job/helpers/util/util.dart';
import 'package:slice_job/packages/panara_dialogs/panara_dialogs.dart';

String firstNameKey = 'firstName';
String lastNameKey = 'lastName';
String dobKey = 'dob';
String phoneKey = 'phone';
String nationalityKey = 'nationality';
String countryKey = 'country';
String maritalStatusKey = 'maritualStatus';
String genderKey = 'gender';
String cityKey = 'city';
String qualificationKey = 'qualification';
String experienceKey = 'experience';
String twoWheelersLiscenseKey = 'twoWheelersLiscense';
String twoWheelerKey = 'twoWheeler';
String websiteKey = 'website';
String jobRoleKey = 'jobRole';
String jobTitleKey = 'jobTitle';
String careerLevelKey = 'careerLevel';
String jobTypeKey = 'jobType';
String targetSalaryKey = 'targetSalary';
String currencyKey = 'currency';

final List<String> yesNo = ['Yes', 'No'];

class ViewCVScreen extends ConsumerStatefulWidget {
  const ViewCVScreen({super.key});

  @override
  ConsumerState<ViewCVScreen> createState() => _ViewCVScreenState();
}

class _ViewCVScreenState extends ConsumerState<ViewCVScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final List<String> _genders = ['Male', 'Female', 'Other'];
  final List<String> _maritalStatus = ['Married', 'Unmarried', 'Unspecified'];
  final List<Country> _countries = [];
  final List<City> _cities = [];
  final profileExperiences = [];
  final profileEducations = [];
  final profileSkills = [];
  final profileLanguages = [];
  final profileTrainings = [];
  final profileCertificates = [];
  String? _cvFile;

  @override
  void initState() {
    super.initState();
    profileExperiences.addAll(ref.read(profileExperienceRef.notifier).state);
    profileEducations.addAll(ref.read(profileEducationRef.notifier).state);
    profileSkills.addAll(ref.read(profileSkillRef.notifier).state);
    profileLanguages.addAll(ref.read(profileLanguageRef.notifier).state);
    profileTrainings.addAll(ref.read(profileTrainingRef.notifier).state);
    profileCertificates.addAll(ref.read(profileCertificateRef.notifier).state);
  }

  void _saveBasicInformation() {
    //
  }

  void _saveContactInformation() {
    //
  }

  void _saveTargetJobInformation() {
    //
  }

  void _downloadCV() {
    //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My CV'),
        actions: [
          IconButton(
            onPressed: _downloadCV,
            icon: const Icon(Ionicons.download_outline),
            tooltip: 'Download CV',
          ),
        ],
      ),
      body: FormBuilder(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 15.w,
            right: 15.w,
            top: 15.h,
            bottom: 50.h,
          ),
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SectionBarWidget(title: 'Basic Information'),
              verticalSpacer(15.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: SliceJobTextField(
                      fieldKey: firstNameKey,
                      formKey: _formKey,
                      hint: 'First Name',
                      validator: FormBuilderValidators.required(
                          errorText: 'Last Name required!'),
                      isDense: true,
                    ),
                  ),
                  horizontalSpacer(10.w),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: SliceJobTextField(
                      fieldKey: lastNameKey,
                      formKey: _formKey,
                      hint: 'Last Name',
                      validator: FormBuilderValidators.required(
                          errorText: 'Last Name required!'),
                      isDense: true,
                    ),
                  ),
                ],
              ),
              verticalSpacer(15.h),
              SliceJobDatePicker(
                fieldKey: dobKey,
                formKey: _formKey,
                hint: 'Date of Birth',
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: 'Date of Birth required!'),
                ]),
                isDense: false,
              ),
              verticalSpacer(15.h),
              SliceJobDropdown(
                fieldKey: genderKey,
                items: _genders,
                formKey: _formKey,
                hint: 'Select your Gender',
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: 'Gender required!'),
                ]),
                isDense: false,
              ),
              verticalSpacer(15.h),
              SliceJobDropdown(
                fieldKey: nationalityKey,
                items: _countries
                    .where((e) => e.name != null)
                    .map((element) => element.name)
                    .toList(),
                formKey: _formKey,
                hint: 'Select your Nationality',
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: 'Nationality required!'),
                ]),
                isDense: false,
              ),
              verticalSpacer(15.h),
              SliceJobDropdown(
                fieldKey: maritalStatusKey,
                items: _maritalStatus,
                formKey: _formKey,
                hint: 'Select your marital status',
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: 'Marital Status required!'),
                ]),
                isDense: false,
              ),
              verticalSpacer(15.h),
              SliceJobDropdown(
                fieldKey: countryKey,
                items: _countries
                    .where((e) => e.name != null)
                    .map((element) => element.name)
                    .toList(),
                formKey: _formKey,
                hint: 'Select your current country',
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: 'Country required!'),
                ]),
                isDense: false,
              ),
              verticalSpacer(15.h),
              SliceJobDropdown(
                fieldKey: cityKey,
                items: _cities
                    .where((e) => e.name != null)
                    .map((element) => element.name)
                    .toList(),
                formKey: _formKey,
                hint: 'Select your current city',
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: 'City required!'),
                ]),
                isDense: false,
              ),
              verticalSpacer(15.h),
              SliceJobDropdown(
                fieldKey: twoWheelersLiscenseKey,
                items: yesNo,
                formKey: _formKey,
                hint: 'Have two wheelers licence?',
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: 'Select answer!'),
                ]),
                isDense: false,
              ),
              verticalSpacer(15.h),
              SliceJobDropdown(
                fieldKey: twoWheelerKey,
                items: yesNo,
                formKey: _formKey,
                hint: 'Have two wheeler?',
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: 'Select answer!'),
                ]),
                isDense: false,
              ),
              verticalSpacer(20.h),
              Align(
                alignment: Alignment.center,
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
              verticalSpacer(20.h),
              const SectionBarWidget(title: 'Contact Information'),
              verticalSpacer(15.h),
              SliceJobTextField(
                fieldKey: emailKey,
                formKey: _formKey,
                hint: 'Email',
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: 'Email required!'),
                  FormBuilderValidators.email(errorText: 'Enter Valid Email!')
                ]),
              ),
              verticalSpacer(15.h),
              SliceJobTextField(
                fieldKey: phoneKey,
                formKey: _formKey,
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
                formKey: _formKey,
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
              verticalSpacer(20.h),
              const SectionBarWidget(title: 'Target Job'),
              verticalSpacer(15.h),
              SliceJobDropdown(
                fieldKey: jobRoleKey,
                items: _countries
                    .where((e) => e.name != null)
                    .map((element) => element.name)
                    .toList(),
                formKey: _formKey,
                hint: 'Job Role',
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: 'Select target job role!'),
                ]),
                isDense: false,
              ),
              verticalSpacer(15.h),
              SliceJobDropdown(
                fieldKey: jobTitleKey,
                items: _countries
                    .where((e) => e.name != null)
                    .map((element) => element.name)
                    .toList(),
                formKey: _formKey,
                hint: 'Desired Job Title',
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: 'Select target job title!'),
                ]),
                isDense: false,
              ),
              verticalSpacer(15.h),
              SliceJobDropdown(
                fieldKey: careerLevelKey,
                items: _countries
                    .where((e) => e.name != null)
                    .map((element) => element.name)
                    .toList(),
                formKey: _formKey,
                hint: 'Career Level',
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: 'Select target career level!'),
                ]),
                isDense: false,
              ),
              verticalSpacer(15.h),
              SliceJobDropdown(
                fieldKey: jobTypeKey,
                items: _countries
                    .where((e) => e.name != null)
                    .map((element) => element.name)
                    .toList(),
                formKey: _formKey,
                hint: 'Job Type',
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: 'Select target job type!'),
                ]),
                isDense: false,
              ),
              verticalSpacer(15.h),
              SliceJobDropdown(
                fieldKey: targetSalaryKey,
                items: _countries
                    .where((e) => e.name != null)
                    .map((element) => element.name)
                    .toList(),
                formKey: _formKey,
                hint: 'Target Salary',
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: 'Select target salary!'),
                ]),
                isDense: false,
              ),
              verticalSpacer(15.h),
              SliceJobDropdown(
                fieldKey: currencyKey,
                items: _countries
                    .where((e) => e.name != null)
                    .map((element) => element.name)
                    .toList(),
                formKey: _formKey,
                hint: 'Currency Format',
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: 'Select currency format!'),
                ]),
                isDense: false,
              ),
              verticalSpacer(20.h),
              Align(
                alignment: Alignment.center,
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
              verticalSpacer(20.h),
              SectionBarWidget(
                title: 'Work Experience',
                onTap: () {
                  context.pushNamed(workExperienceFormRoute);
                },
              ),
              verticalSpacer(15.h),
              profileExperiences.isNotEmpty
                  ? ListView.separated(
                      itemBuilder: (cxt, index) {
                        final work = profileExperiences[index];
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
                                      value: 1,
                                      child: Text("Edit"),
                                    ),
                                    const PopupMenuItem(
                                      value: 2,
                                      child: Text("Delete"),
                                    ),
                                  ],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  onSelected: (value) async {
                                    if (value == 2) {
                                      await PanaraConfirmDialog
                                          .showAnimatedGrow(
                                        context,
                                        title: 'Confirmation',
                                        message:
                                            'Do you want to delete this  item?',
                                        cancelButtonText: 'No',
                                        confirmButtonText: 'Yes',
                                        onTapCancel: () =>
                                            Navigator.pop(context),
                                        onTapConfirm: () {
                                          Navigator.pop(context);
                                          // _deleteWork(work: work);
                                        },
                                        panaraDialogType:
                                            PanaraDialogType.warning,
                                        barrierDismissible: true,
                                      );
                                    } else {
                                      context
                                          .pushNamed(workExperienceFormRoute);
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
                                  '${work.fromMonth} ${work.fromYear} '
                                  'to '
                                  '${work.toMonth} ${work.toYear}',
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
                      itemCount: profileExperiences.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    )
                  : const Text(
                      'Your work experiences will show up here.\nAdd your work experiences.',
                      textAlign: TextAlign.center,
                    ),
              verticalSpacer(15.h),
              SectionBarWidget(
                title: 'Education (Upload highest degree at last)',
                onTap: () {
                  context.pushNamed(workEducationFormRoute);
                },
              ),
              verticalSpacer(15.h),
              profileEducations.isNotEmpty
                  ? ListView.separated(
                      itemBuilder: (cxt, index) {
                        final education = profileEducations[index];
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
                                      value: 1,
                                      child: Text("Edit"),
                                    ),
                                    const PopupMenuItem(
                                      value: 2,
                                      child: Text("Delete"),
                                    ),
                                  ],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  onSelected: (value) async {
                                    if (value == 2) {
                                      await PanaraConfirmDialog
                                          .showAnimatedGrow(
                                        context,
                                        title: 'Confirmation',
                                        message:
                                            'Do you want to delete this  item?',
                                        cancelButtonText: 'No',
                                        confirmButtonText: 'Yes',
                                        onTapCancel: () =>
                                            Navigator.pop(context),
                                        onTapConfirm: () {
                                          Navigator.pop(context);
                                          // _deleteEducation(education: education);
                                        },
                                        panaraDialogType:
                                            PanaraDialogType.warning,
                                        barrierDismissible: true,
                                      );
                                    } else {
                                      context.pushNamed(workEducationFormRoute);
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
                                  '${education.startMonth} ${education.startYear} '
                                  'to '
                                  '${education.endMonth} ${education.endYear}',
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
                      itemCount: profileEducations.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    )
                  : const Text(
                      'Your education will show up here.\nAdd your education qualifications.',
                      textAlign: TextAlign.center,
                    ),
              verticalSpacer(15.h),
              SectionBarWidget(
                title: 'Skills',
                onTap: () {
                  context.pushNamed(workEducationFormRoute);
                },
              ),
              verticalSpacer(15.h),
              profileSkills.isNotEmpty
                  ? ListView.separated(
                      itemBuilder: (cxt, index) {
                        final skill = profileSkills[index];
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
                                      value: 1,
                                      child: Text("Edit"),
                                    ),
                                    const PopupMenuItem(
                                      value: 2,
                                      child: Text("Delete"),
                                    ),
                                  ],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  onSelected: (value) async {
                                    if (value == 2) {
                                      await PanaraConfirmDialog
                                          .showAnimatedGrow(
                                        context,
                                        title: 'Confirmation',
                                        message:
                                            'Do you want to delete this  item?',
                                        cancelButtonText: 'No',
                                        confirmButtonText: 'Yes',
                                        onTapCancel: () =>
                                            Navigator.pop(context),
                                        onTapConfirm: () {
                                          Navigator.pop(context);
                                          // _deleteSkill(skill: skill);
                                        },
                                        panaraDialogType:
                                            PanaraDialogType.warning,
                                        barrierDismissible: true,
                                      );
                                    } else {
                                      context.pushNamed(workSkillFormRoute);
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
                      itemCount: profileSkills.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    )
                  : const Text(
                      'Your skills will show up here.\nAdd your skills.',
                      textAlign: TextAlign.center,
                    ),
              verticalSpacer(15.h),
              SectionBarWidget(
                title: 'Language',
                onTap: () {
                  context.pushNamed(workLanguageFormRoute);
                },
              ),
              verticalSpacer(15.h),
              profileLanguages.isNotEmpty
                  ? ListView.separated(
                      itemBuilder: (cxt, index) {
                        final language = profileLanguages[index];
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
                                      value: 1,
                                      child: Text("Edit"),
                                    ),
                                    const PopupMenuItem(
                                      value: 2,
                                      child: Text("Delete"),
                                    ),
                                  ],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  onSelected: (value) async {
                                    if (value == 2) {
                                      await PanaraConfirmDialog
                                          .showAnimatedGrow(
                                        context,
                                        title: 'Confirmation',
                                        message:
                                            'Do you want to delete this  item?',
                                        cancelButtonText: 'No',
                                        confirmButtonText: 'Yes',
                                        onTapCancel: () =>
                                            Navigator.pop(context),
                                        onTapConfirm: () {
                                          Navigator.pop(context);
                                          // _deleteLanguage(language: language);
                                        },
                                        panaraDialogType:
                                            PanaraDialogType.warning,
                                        barrierDismissible: true,
                                      );
                                    } else {
                                      context.pushNamed(workLanguageFormRoute);
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
                      itemCount: profileLanguages.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    )
                  : const Text(
                      'Your languages will show up here.\nAdd languages you know.',
                      textAlign: TextAlign.center,
                    ),
              verticalSpacer(15.h),
              SectionBarWidget(
                title: 'Training',
                onTap: () {
                  context.pushNamed(workTrainingFormRoute);
                },
              ),
              verticalSpacer(15.h),
              profileTrainings.isNotEmpty
                  ? ListView.separated(
                      itemBuilder: (cxt, index) {
                        final training = profileTrainings[index];
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
                                      value: 1,
                                      child: Text("Edit"),
                                    ),
                                    const PopupMenuItem(
                                      value: 2,
                                      child: Text("Delete"),
                                    ),
                                  ],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  onSelected: (value) async {
                                    if (value == 2) {
                                      await PanaraConfirmDialog
                                          .showAnimatedGrow(
                                        context,
                                        title: 'Confirmation',
                                        message:
                                            'Do you want to delete this  item?',
                                        cancelButtonText: 'No',
                                        confirmButtonText: 'Yes',
                                        onTapCancel: () =>
                                            Navigator.pop(context),
                                        onTapConfirm: () {
                                          Navigator.pop(context);
                                          // _deleteTraining(training: training);
                                        },
                                        panaraDialogType:
                                            PanaraDialogType.warning,
                                        barrierDismissible: true,
                                      );
                                    } else {
                                      context.pushNamed(workTrainingFormRoute);
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
                                  '${training.startMonth} ${training.startYear} '
                                  'to '
                                  '${training.endMonth} ${training.endYear}',
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
                      itemCount: profileTrainings.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    )
                  : const Text(
                      'Your trainings will show up here.\nAdd trainings you have taken.',
                      textAlign: TextAlign.center,
                    ),
              verticalSpacer(15.h),
              SectionBarWidget(
                title: 'Certificates',
                onTap: () {
                  context.pushNamed(workCertificateFormRoute);
                },
              ),
              verticalSpacer(15.h),
              profileCertificates.isNotEmpty
                  ? ListView.separated(
                      itemBuilder: (cxt, index) {
                        final certificate = profileCertificates[index];
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
                                      value: 1,
                                      child: Text("Edit"),
                                    ),
                                    const PopupMenuItem(
                                      value: 2,
                                      child: Text("Delete"),
                                    ),
                                  ],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  onSelected: (value) async {
                                    if (value == 2) {
                                      await PanaraConfirmDialog
                                          .showAnimatedGrow(
                                        context,
                                        title: 'Confirmation',
                                        message:
                                            'Do you want to delete this  item?',
                                        cancelButtonText: 'No',
                                        confirmButtonText: 'Yes',
                                        onTapCancel: () =>
                                            Navigator.pop(context),
                                        onTapConfirm: () {
                                          Navigator.pop(context);
                                          // _deleteCertificate(
                                          //     certificate: certificate);
                                        },
                                        panaraDialogType:
                                            PanaraDialogType.warning,
                                        barrierDismissible: true,
                                      );
                                    } else {
                                      context
                                          .pushNamed(workCertificateFormRoute);
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
                                  '${certificate.issueMonth} ${certificate.issueYear} '
                                  'to '
                                  '${certificate.expireMonth} ${certificate.expireYear}',
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
                      itemCount: profileCertificates.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    )
                  : const Text(
                      'Your certificates will show up here.\nAdd your certificates.',
                      textAlign: TextAlign.center,
                    ),
              verticalSpacer(15.h),
              SectionBarWidget(
                title: 'Original CV',
                onTap: () {
                  // context.pushNamed(workTrainingFormRoute);
                },
              ),
              verticalSpacer(15.h),
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
}
