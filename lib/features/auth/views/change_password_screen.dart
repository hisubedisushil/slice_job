import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slice_job/app/entities/base_state.dart';
import 'package:slice_job/app/entities/failure.dart';
import 'package:slice_job/constants/app_colors.dart';
import 'package:slice_job/core/widgets/slicejob_input_fields.dart';
import 'package:slice_job/features/profile/provider/profile_provider.dart';
import 'package:slice_job/helpers/extensions/context_extension.dart';
import 'package:slice_job/helpers/util/util.dart';

String oldPasswordKey = 'oldPassword';
String passwordKey = 'password';
String rePasswordKey = 're-password';

final changePasswordRef =
    StateNotifierProvider.autoDispose<ProfileProvider, BaseState>((ref) {
  return ProfileProvider(ref: ref);
});

class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  void _update() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      FocusScope.of(context).requestFocus(FocusNode());
      final formValue = _formKey.currentState!.value;
      ref.read(changePasswordRef.notifier).changePassword(
            oldPassword: formValue[oldPasswordKey],
            password: formValue[passwordKey],
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<BaseState>(
      changePasswordRef,
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
                    const Text('Updating new password...'),
                    verticalSpacer(20.h),
                  ],
                ),
              );
            },
          );
        } else {
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
          title: const Text('Change Password'),
        ),
        body: FormBuilder(
          key: _formKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SliceJobPasswordField(
                    fieldKey: oldPasswordKey,
                    hint: 'Old Password',
                    errorText: 'Password must have at least 6 characters.',
                    isDense: true,
                  ),
                  verticalSpacer(15.h),
                  SliceJobPasswordField(
                    fieldKey: passwordKey,
                    hint: 'New Password',
                    errorText: 'Password must have at least 6 characters.',
                    isDense: true,
                  ),
                  verticalSpacer(15.h),
                  SliceJobPasswordField(
                    fieldKey: rePasswordKey,
                    hint: 'Re-type New Password',
                    autoValidation: true,
                    validator: (p0) {
                      final input = (p0 ?? '').trim();
                      if (input.isEmpty || input.length < 5) {
                        return 'Password must have at least 6 characters.';
                      }
                      final originalPassword =
                          (_formKey.currentState?.fields[passwordKey]?.value ??
                                  '')
                              .toString()
                              .trim();
                      final isDuplicate = input == originalPassword;

                      if (isDuplicate) {
                        return null;
                      } else {
                        return 'Passwords doesn\'t match!';
                      }
                    },
                    isDense: true,
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
                      'Change',
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
