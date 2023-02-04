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
import 'package:slice_job/core/models/experience.dart';
import 'package:slice_job/core/widgets/slicejob_input_fields.dart';
import 'package:slice_job/features/jobs/provider/job_provider.dart';
import 'package:slice_job/features/profile/provider/cv_provider.dart';
import 'package:slice_job/helpers/constants.dart';
import 'package:slice_job/helpers/extensions/context_extension.dart';
import 'package:slice_job/helpers/util/util.dart';

String degreeKey = 'degree';
String fieldOfStudyKey = 'fieldOfStudy';
String institutionKey = 'institution';
String countryKey = 'country';
String cityKey = 'city';
String fromMonthKey = 'fromMonth';
String fromYearKey = 'fromYear';
String toMonthKey = 'toMonth';
String toYearKey = 'toYear';

final addEducationRef =
    StateNotifierProvider.autoDispose<CVProvider, BaseState>((ref) {
  return CVProvider(ref: ref);
});

final getCityRef =
    StateNotifierProvider.autoDispose<JobProvider, BaseState>((ref) {
  return JobProvider(ref: ref);
});

class WorkEducationFormScreen extends ConsumerStatefulWidget {
  final Education? education;

  const WorkEducationFormScreen({
    Key? key,
    this.education,
  }) : super(key: key);

  @override
  ConsumerState<WorkEducationFormScreen> createState() =>
      _WorkEducationFormScreenState();
}

class _WorkEducationFormScreenState
    extends ConsumerState<WorkEducationFormScreen> {
  final formKey = GlobalKey<FormBuilderState>();
  final List<Country> _countries = [];

  @override
  void initState() {
    super.initState();
    _countries.addAll(ref.read(countriesRef.notifier).state);
    final edu = widget.education;
    if (edu != null) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        formKey.currentState
          ?..fields[degreeKey]?.didChange(edu.degree)
          ..fields[fieldOfStudyKey]?.didChange(edu.field)
          ..fields[institutionKey]?.didChange(edu.institution)
          ..fields[countryKey]?.didChange(edu.country)
          ..fields[cityKey]?.didChange(edu.city)
          ..fields[fromMonthKey]?.didChange(edu.startMonth)
          ..fields[fromYearKey]?.didChange(edu.startYear)
          ..fields[toMonthKey]?.didChange(edu.endMonth)
          ..fields[toYearKey]?.didChange(edu.endYear);
      });
    }
  }

  _add() async {
    if (formKey.currentState?.saveAndValidate() ?? false) {
      FocusScope.of(context).requestFocus(FocusNode());
      final formValue = formKey.currentState!.value;
      final data = <String, String?>{
        'id': widget.education?.id,
        'degree': formValue[degreeKey],
        'field': formValue[fieldOfStudyKey],
        'institution': formValue[institutionKey],
        'country': formValue[countryKey],
        'city': formValue[cityKey],
        'start_month': formValue[fromMonthKey],
        'start_year': formValue[fromYearKey],
        'end_month': formValue[toMonthKey],
        'end_year': formValue[toYearKey],
      };
      ref.read(addEducationRef.notifier).addEducation(
            data,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final eduId = widget.education?.id;
    ref.listen<BaseState>(
      addEducationRef,
      (previous, next) {
        if (next is BaseLoading) {
          context.showUpdatingCVInfoDialog(
              eduId == null ? 'Adding New Education!' : 'Updating Education!');
        } else {
          context.pop();
          context.pop(true);
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
    return Material(
      color: AppColors.white,
      child: Scaffold(
        backgroundColor: AppColors.primary.withOpacity(0.1),
        appBar: AppBar(
          title: Text(
            '${widget.education != null ? 'Update' : 'Add'} CV Education',
          ),
        ),
        body: FormBuilder(
          key: formKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SliceJobTextField(
                    fieldKey: degreeKey,
                    formKey: formKey,
                    hint: 'Degree',
                    validator: FormBuilderValidators.required(
                        errorText: 'Job Title required!'),
                  ),
                  verticalSpacer(15.h),
                  SliceJobTextField(
                    fieldKey: fieldOfStudyKey,
                    formKey: formKey,
                    hint: 'Field of Study',
                    validator: FormBuilderValidators.required(
                        errorText: 'Field of Study required!'),
                  ),
                  verticalSpacer(15.h),
                  SliceJobTextField(
                    fieldKey: institutionKey,
                    formKey: formKey,
                    hint: 'Institution',
                    validator: FormBuilderValidators.required(
                        errorText: 'Institution required!'),
                  ),
                  verticalSpacer(15.h),
                  SliceJobDropdown(
                    fieldKey: countryKey,
                    items: _countries
                        .where((e) => e.name != null)
                        .map((element) => element.name)
                        .toList(),
                    formKey: formKey,
                    onChanged: (p0) {
                      if (p0 != null) {
                        final countryID = _countries
                            .firstWhereOrNull((e) => e.name == p0)
                            ?.id;
                        if (countryID != null) {
                          ref.read(getCityRef.notifier).getCities(countryID);
                        }
                      }
                    },
                    hint: 'Select country of education',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'Country required!'),
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
                            formKey: formKey,
                            hint: 'Select city of education',
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
                    fieldKey: fromMonthKey,
                    items: months,
                    formKey: formKey,
                    hint: 'From Month',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'Pick Start Month!'),
                    ]),
                  ),
                  verticalSpacer(15.h),
                  SliceJobDropdown(
                    fieldKey: fromYearKey,
                    items: years,
                    formKey: formKey,
                    hint: 'From Year',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'Pick Start Year!'),
                    ]),
                  ),
                  verticalSpacer(15.h),
                  SliceJobDropdown(
                    fieldKey: toMonthKey,
                    items: ['Present', ...months],
                    formKey: formKey,
                    hint: 'To Month',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'Pick End Month!'),
                    ]),
                  ),
                  verticalSpacer(15.h),
                  SliceJobDropdown(
                    fieldKey: toYearKey,
                    items: ['Present', ...years],
                    formKey: formKey,
                    hint: 'To Year',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'Pick End Year!'),
                    ]),
                  ),
                  verticalSpacer(15.h),
                  MaterialButton(
                    onPressed: _add,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: AppColors.primary,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minWidth: double.infinity,
                    height: 56.0,
                    elevation: 0.0,
                    child: Text(
                      widget.education != null ? 'Update' : 'Add',
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
