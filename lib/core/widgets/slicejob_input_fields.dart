import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ionicons/ionicons.dart';
import 'package:slice_job/constants/app_colors.dart';
import 'package:slice_job/helpers/util/decoration_util.dart';

class SliceJobTextField extends StatelessWidget {
  const SliceJobTextField({
    super.key,
    required this.fieldKey,
    required this.formKey,
    required this.hint,
    required this.validator,
    this.isDense = false,
    this.errorText,
  });

  final String fieldKey;
  final GlobalKey<FormBuilderState> formKey;
  final String hint;
  final String? Function(String?)? validator;
  final bool isDense;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: fieldKey,
      validator: validator,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
      ),
      decoration: getFormInputDecoration(
        suffix: Ionicons.close,
        prefix: null,
        hint: hint,
        isDense: isDense,
        onTapSuffix: () {
          formKey.currentState?.fields[fieldKey]?.didChange('');
        },
        errorText: errorText,
      ),
    );
  }
}

class SliceJobPasswordField extends StatelessWidget {
  SliceJobPasswordField({
    super.key,
    required this.fieldKey,
    required this.hint,
    this.validator,
    this.isDense = false,
    this.errorText,
    this.autoValidation = false,
  });

  ValueNotifier<bool> togglePassword = ValueNotifier<bool>(false);
  final String fieldKey;
  final String hint;
  final bool isDense;
  final String? errorText;
  final String? Function(String?)? validator;
  final bool autoValidation;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: togglePassword,
      builder: (context, value, child) {
        return FormBuilderTextField(
          name: fieldKey,
          obscureText: !value,
          autovalidateMode: AutovalidateMode.always,
          validator: validator ??
              FormBuilderValidators.compose([
                FormBuilderValidators.minLength(6,
                    errorText: 'Password must have at least 6 characters.'),
                FormBuilderValidators.maxLength(64,
                    errorText:
                        'Password must not be larger than 64 characters.'),
              ]),
          decoration: getFormInputDecoration(
            suffixColor: AppColors.primary,
            suffix: value ? Ionicons.eye_off_outline : Ionicons.eye_outline,
            prefix: null,
            hint: hint,
            isDense: isDense,
            onTapSuffix: () {
              togglePassword.value = !value;
            },
          ),
        );
      },
    );
  }
}

class SliceJobCehckBox extends StatelessWidget {
  const SliceJobCehckBox({
    super.key,
    required this.fieldKey,
    required this.text,
    this.mandatory = false,
    this.errorText,
  });

  final String fieldKey;
  final Widget text;
  final bool mandatory;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return FormBuilderCheckbox(
      name: fieldKey,
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 0,
        vertical: 0,
      ),
      initialValue: true,
      decoration: const InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 0,
          vertical: 0,
        ),
        border: InputBorder.none,
      ),
      onChanged: (value) {
        //
      },
      title: text,
      validator: mandatory
          ? FormBuilderValidators.equal(
              true,
              errorText: errorText,
            )
          : null,
    );
  }
}

class SliceJobDropdown extends StatelessWidget {
  const SliceJobDropdown({
    super.key,
    required this.fieldKey,
    required this.formKey,
    required this.hint,
    required this.validator,
    this.isDense = false,
    this.errorText,
    required this.items,
    this.onChanged,
  });

  final String fieldKey;
  final GlobalKey<FormBuilderState> formKey;
  final String hint;
  final String? Function(String?)? validator;
  final bool isDense;
  final String? errorText;
  final List<String?> items;
  final Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return FormBuilderDropdown<String>(
      name: fieldKey,
      validator: validator,
      alignment: Alignment.centerLeft,
      items: items
          .where((element) => element != null)
          .map((item) => DropdownMenuItem(
                alignment: AlignmentDirectional.centerStart,
                value: item,
                child: Text(
                  item!,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ))
          .toList(),
          onChanged: onChanged,
      decoration: getFormInputDecoration(
        suffix: null,
        prefix: null,
        hint: hint,
        isDense: isDense,
        onTapSuffix: () {
          formKey.currentState?.fields[fieldKey]?.didChange('');
        },
        errorText: errorText,
      ),
    );
  }
}

class SliceJobDatePicker extends StatelessWidget {
  const SliceJobDatePicker({
    super.key,
    required this.fieldKey,
    required this.formKey,
    required this.hint,
    required this.validator,
    this.isDense = false,
    this.errorText,
  });

  final String fieldKey;
  final GlobalKey<FormBuilderState> formKey;
  final String hint;
  final String? Function(DateTime?)? validator;
  final bool isDense;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return FormBuilderDateTimePicker(
      name: fieldKey,
      validator: validator,
      firstDate: DateTime(1970),
      lastDate: DateTime.now(),
      inputType: InputType.date,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
      ),
      decoration: getFormInputDecoration(
        suffix: null,
        prefix: null,
        hint: hint,
        isDense: isDense,
        onTapSuffix: () {
          formKey.currentState?.fields[fieldKey]?.didChange('');
        },
        errorText: errorText,
      ),
    );
  }
}
