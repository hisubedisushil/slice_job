import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:slice_job/app/entities/base_state.dart';
import 'package:slice_job/app/entities/failure.dart';
import 'package:slice_job/constants/app_colors.dart';
import 'package:slice_job/core/models/country.dart';
import 'package:slice_job/core/models/job.dart';
import 'package:slice_job/core/models/profile/profile_response.dart';
import 'package:slice_job/core/widgets/slicejob_input_fields.dart';
import 'package:slice_job/features/jobs/provider/job_provider.dart';
import 'package:slice_job/features/profile/provider/profile_provider.dart';
import 'package:slice_job/features/profile/views/profile_authenticated_view.dart';
import 'package:slice_job/helpers/extensions/context_extension.dart';
import 'package:slice_job/helpers/util/util.dart';

final profileUpdateRef =
    StateNotifierProvider.autoDispose<ProfileProvider, BaseState>((ref) {
  return ProfileProvider(ref: ref);
});

String firstNameKey = 'firstName';
String lastNameKey = 'lastName';
String dobKey = 'dob';
String phoneKey = 'phone';
String countryKey = 'country';
String genderKey = 'gender';
String cityKey = 'city';
String nationalityKey = 'nationality';
String qualificationKey = 'qualification';
String experienceKey = 'experience';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({
    Key? key,
    required this.profile,
  }) : super(key: key);

  final Profile profile;

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final List<String> _genders = ['Male', 'Female', 'Other'];
  final List<Country> _countries = [];
  final List<JobType> _experiences = [];
  final List<JobType> _qualifications = [];

  @override
  void initState() {
    super.initState();
    _countries.addAll(ref.read(countriesRef.notifier).state);
    _experiences.addAll(ref.read(jobExperienceLevelsRef.notifier).state);
    _qualifications.addAll(ref.read(jobEducationLevelsRef.notifier).state);
    initFields();
  }

  void initFields() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _formKey.currentState?.fields[firstNameKey]
          ?.didChange(widget.profile.firstName);
      _formKey.currentState?.fields[lastNameKey]
          ?.didChange(widget.profile.lastName);
      _formKey.currentState?.fields[dobKey]
          ?.didChange(DateTime.tryParse(widget.profile.dob ?? ''));
      _formKey.currentState?.fields[phoneKey]
          ?.didChange(widget.profile.mobileNumber);
      _formKey.currentState?.fields[cityKey]
          ?.didChange(widget.profile.currCity);
      _formKey.currentState?.fields[nationalityKey]
          ?.didChange(widget.profile.nationality);
      final initialCountry = _countries.firstWhereOrNull(
          (element) => element.name == widget.profile.currCountry);
      if (initialCountry != null) {
        _formKey.currentState?.fields[countryKey]
            ?.didChange(initialCountry.name);
      }
      final initialGender = _genders
          .firstWhereOrNull((element) => element == widget.profile.gender);
      if (initialGender != null) {
        _formKey.currentState?.fields[genderKey]?.didChange(initialGender);
      }
      final initialQualification = _qualifications.firstWhereOrNull(
          (element) => element.name == widget.profile.qualification);
      if (initialQualification != null) {
        _formKey.currentState?.fields[qualificationKey]
            ?.didChange(initialQualification.name);
      }
      final initialExperience = _experiences.firstWhereOrNull(
          (element) => element.name == widget.profile.experience);
      if (initialExperience != null) {
        _formKey.currentState?.fields[experienceKey]
            ?.didChange(initialExperience.name);
      }
    });
  }

  _update() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      FocusScope.of(context).requestFocus(FocusNode());
      final formValue = _formKey.currentState!.value;
      final dob = formValue[dobKey].toString();
      ref.read(profileUpdateRef.notifier).updateProfile(
            firstName: formValue[firstNameKey],
            lastName: formValue[lastNameKey],
            dob: dob,
            nationality: formValue[nationalityKey],
            gender: formValue[genderKey],
            country: formValue[countryKey],
            city: formValue[cityKey],
            qualification: formValue[qualificationKey],
            experience: formValue[experienceKey],
            mobileNumber: formValue[phoneKey],
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<BaseState>(
      profileUpdateRef,
      (previous, next) {
        if (next is BaseLoading) {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    verticalSpacer(20.h),
                    const CircularProgressIndicator(),
                    verticalSpacer(20.h),
                    const Text('Updating profile information...'),
                    verticalSpacer(20.h),
                  ],
                ),
              );
            },
          );
        } else {
          ref.read(profileRef.notifier).getProfile();
          Navigator.of(context).pop();
          if (next is BaseSuccess) {
            final data = next.data as String;
            context.pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  data,
                ),
              ),
            );
          }
          if (next is BaseError) {
            final err = next.data as Failure;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  err.reason,
                ),
              ),
            );
          }
        }
      },
    );
    return Material(
      color: AppColors.white,
      child: Scaffold(
        backgroundColor: AppColors.primary.withOpacity(0.1),
        appBar: AppBar(
          title: const Text('Update Profile'),
        ),
        body: FormBuilder(
          key: _formKey,
          child: SingleChildScrollView(
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
                  SliceJobTextField(
                    fieldKey: phoneKey,
                    formKey: _formKey,
                    hint: 'Mobile Number',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'Mobile number required!'),
                      FormBuilderValidators.equalLength(10,
                          errorText: 'Mobile number must be 10 characters!'),
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
                    hint: 'Select your current Country',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'Country required!'),
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
                      FormBuilderValidators.required(
                          errorText: 'Gender required!'),
                    ]),
                    isDense: false,
                  ),
                  verticalSpacer(15.h),
                  SliceJobTextField(
                    fieldKey: cityKey,
                    formKey: _formKey,
                    hint: 'Current City',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'City required!'),
                    ]),
                    isDense: false,
                  ),
                  verticalSpacer(15.h),
                  SliceJobTextField(
                    fieldKey: nationalityKey,
                    formKey: _formKey,
                    hint: 'Nationality',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'Nationality required!'),
                    ]),
                    isDense: false,
                  ),
                  verticalSpacer(15.h),
                  SliceJobDropdown(
                    fieldKey: qualificationKey,
                    items:
                        _qualifications.map((element) => element.name).toList(),
                    formKey: _formKey,
                    hint: 'Select your Qualification Level',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'Qualification required!'),
                    ]),
                    isDense: false,
                  ),
                  verticalSpacer(15.h),
                  SliceJobDropdown(
                    fieldKey: experienceKey,
                    items: _experiences.map((element) => element.name).toList(),
                    formKey: _formKey,
                    hint: 'Select your Experience Level',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'Experience required!'),
                    ]),
                    isDense: false,
                  ),
                  verticalSpacer(15.h),
                  MaterialButton(
                    onPressed: _update,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: AppColors.primary,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minWidth: double.infinity,
                    height: 56.0,
                    elevation: 0.0,
                    child: Text(
                      'Update',
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
