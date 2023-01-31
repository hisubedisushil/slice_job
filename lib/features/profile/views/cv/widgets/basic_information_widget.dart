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
import 'package:slice_job/core/widgets/slicejob_input_fields.dart';
import 'package:slice_job/features/jobs/provider/job_provider.dart';
import 'package:slice_job/features/profile/provider/cv_provider.dart';
import 'package:slice_job/features/profile/widgets/section_bar_widget.dart';
import 'package:slice_job/helpers/extensions/context_extension.dart';
import 'package:slice_job/helpers/util/util.dart';

// Basic information Keys
String firstNameKey = 'firstName';
String lastNameKey = 'lastName';
String dobKey = 'dob';
String genderKey = 'gender';
String nationalityKey = 'nationality';
String maritalStatusKey = 'maritualStatus';
String countryKey = 'country';
String cityKey = 'city';
String twoWheelersLiscenseKey = 'twoWheelersLiscense';
String twoWheelerKey = 'twoWheeler';

final List<String> yesNo = ['Yes', 'No'];
final List<String> genders = ['Male', 'Female', 'Other'];
final List<String> maritalStatus = ['Married', 'Unmarried', 'Unspecified'];

final updateBasicInfoRef =
    StateNotifierProvider.autoDispose<CVProvider, BaseState>((ref) {
  return CVProvider(ref: ref);
});

final getCityRef =
    StateNotifierProvider.autoDispose<JobProvider, BaseState>((ref) {
  return JobProvider(ref: ref);
});

class BasicInformationWidget extends ConsumerStatefulWidget {
  const BasicInformationWidget({super.key});

  @override
  ConsumerState<BasicInformationWidget> createState() =>
      _BasicInformationWidgetState();
}

class _BasicInformationWidgetState
    extends ConsumerState<BasicInformationWidget> {
  final _basicInfoFormKey = GlobalKey<FormBuilderState>();
  final List<Country> _countries = [];

  @override
  void initState() {
    super.initState();
    initCVBasicInfo();
  }

  void initCVBasicInfo() {
    _countries.addAll(ref.read(countriesRef.notifier).state);
    final cvBasic = ref.read(cvBasicRef.notifier).state;
    if (cvBasic != null) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        final dob = DateTime(
          int.tryParse(cvBasic.birthYear ?? '') ?? 0,
          int.tryParse(cvBasic.birthMonth ?? '') ?? 0,
          int.tryParse(cvBasic.birthDay ?? '') ?? 0,
        );
        _basicInfoFormKey.currentState
          ?..fields[firstNameKey]?.didChange(cvBasic.firstName)
          ..fields[lastNameKey]?.didChange(cvBasic.lastName)
          ..fields[dobKey]?.didChange(dob)
          ..fields[genderKey]?.didChange(cvBasic.gender)
          ..fields[nationalityKey]?.didChange(cvBasic.nationality)
          ..fields[maritalStatusKey]?.didChange(cvBasic.maritalStatus)
          ..fields[countryKey]?.didChange(cvBasic.currentCountry)
          ..fields[cityKey]?.didChange(cvBasic.currentCity);
      });
    }
  }

  void _saveBasicInformation() {
    if (_basicInfoFormKey.currentState?.saveAndValidate() ?? false) {
      FocusScope.of(context).requestFocus(FocusNode());
      final formValue = _basicInfoFormKey.currentState!.value;
      final dob = formValue[dobKey] as DateTime;
      final data = <String, String>{
        'first_name': formValue[firstNameKey],
        'last_name': formValue[lastNameKey],
        'birth_day': dob.day.toString(),
        'birth_month': dob.month.toString(),
        'birth_year': dob.year.toString(),
        'gender': formValue[genderKey],
        'nationality': formValue[nationalityKey],
        'marital_status': formValue[maritalStatusKey],
        'current_country': formValue[countryKey],
        'current_city': formValue[cityKey],
        'have_licence': formValue[twoWheelersLiscenseKey],
        'have_vehicle': formValue[twoWheelerKey],
      };
      ref.read(updateBasicInfoRef.notifier).updateCVBasicInfo(
            data,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<BaseState>(
      updateBasicInfoRef,
      (previous, next) {
        if (next is BaseLoading) {
          context.showUpdatingCVInfoDialog('Updating CV Basic Information!');
        } else {
          context.pop();
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

    return FormBuilder(
      key: _basicInfoFormKey,
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
                  formKey: _basicInfoFormKey,
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
                  formKey: _basicInfoFormKey,
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
            formKey: _basicInfoFormKey,
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
            items: genders,
            formKey: _basicInfoFormKey,
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
            formKey: _basicInfoFormKey,
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
            items: maritalStatus,
            formKey: _basicInfoFormKey,
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
            formKey: _basicInfoFormKey,
            onChanged: (p0) {
              if (p0 != null) {
                final countryID =
                    _countries.firstWhereOrNull((e) => e.name == p0)?.id;
                if (countryID != null) {
                  ref.read(getCityRef.notifier).getCities(countryID);
                }
              }
            },
            hint: 'Select your current country',
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: 'Country required!'),
            ]),
            isDense: false,
          ),
          verticalSpacer(15.h),
          Consumer(
            builder: (context, ref, child) {
              bool isLoading = true;
              List<City> cities = [];
              ref.watch<BaseState>(getCityRef).maybeWhen(
                loading: () {
                  isLoading = true;
                },
                success: (data, extraData) {
                  isLoading = false;
                  cities = data as List<City>;
                },
                orElse: () {
                  isLoading = false;
                },
              );
              return Stack(
                children: [
                  SliceJobDropdown(
                    fieldKey: cityKey,
                    items: cities
                        .where((e) => e.name != null)
                        .map((element) => element.name)
                        .toList(),
                    formKey: _basicInfoFormKey,
                    hint: 'Select your current city',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'City required!'),
                    ]),
                    isDense: false,
                  ),
                  if (isLoading)
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Center(
                        child: SizedBox(
                          width: 30.w,
                          height: 30.w,
                          child: const CircularProgressIndicator(),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          verticalSpacer(15.h),
          SliceJobDropdown(
            fieldKey: twoWheelersLiscenseKey,
            items: yesNo,
            formKey: _basicInfoFormKey,
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
            formKey: _basicInfoFormKey,
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
        ],
      ),
    );
  }
}
