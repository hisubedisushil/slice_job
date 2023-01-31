import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pinput/pinput.dart';
import 'package:slice_job/app/entities/app_entities.dart';
import 'package:slice_job/app_setup/routes/router.dart';
import 'package:slice_job/constants/app_colors.dart';
import 'package:slice_job/core/widgets/slicejob_input_fields.dart';
import 'package:slice_job/features/auth/provider/auth_provider.dart';
import 'package:slice_job/helpers/extensions/context_extension.dart';
import 'package:slice_job/helpers/util/util.dart';

String passwordKey = 'password';
String rePasswordKey = 're-password';

final resetPasswordRef =
    StateNotifierProvider.autoDispose<AuthProvider, AuthState>((ref) {
  return AuthProvider(ref: ref);
});

class ResetPasswordScreen extends ConsumerStatefulWidget {
  final String email;

  const ResetPasswordScreen({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  ConsumerState<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _otp = TextEditingController();

  @override
  void dispose() {
    _otp.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      FocusScope.of(context).requestFocus(FocusNode());
      final formValue = _formKey.currentState!.value;
      ref.read(resetPasswordRef.notifier).resetPassword(
            email: widget.email,
            code: _otp.text,
            password: formValue[passwordKey],
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    ref.listen<AuthState>(
      resetPasswordRef,
      (previous, next) {
        if (next.error != null) {
          ref.read(resetPasswordRef.notifier).resetError();
          final errorMsg = next.error!.reason;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                errorMsg,
              ),
            ),
          );
        }
        if (next.isAuthenticated) {
          context.pushReplacementNamed(loginRoute);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'You have successfully reset password. '
                'Please login using new password.',
              ),
            ),
          );
        }
      },
    );
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FormBuilder(
            key: _formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Reset Password',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'Check your email or phone and enter '
                        'verification code below to reset your password.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Pinput(
                      controller: _otp,
                      length: 6,
                      validator: (value) {
                        final input = (value ?? '').trim();
                        if (input.isEmpty) {
                          return 'Please Enter otp you received in email or phone!';
                        }
                        if (input.length == 6) {
                          return null;
                        } else {
                          return 'Enter 6 digits otp!';
                        }
                      },
                      defaultPinTheme: PinTheme(
                        width: (width - 20) / 6,
                        height: (width - 20) / 6,
                        textStyle: TextStyle(
                          fontSize: 32.0,
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                          height: 0.75,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primary),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: EdgeInsets.zero,
                        margin: EdgeInsets.zero,
                      ),
                    ),
                    const SizedBox(height: 40.0),
                    SliceJobPasswordField(
                      fieldKey: passwordKey,
                      hint: 'Password',
                      errorText: 'Password must have at least 6 characters.',
                      isDense: true,
                    ),
                    verticalSpacer(15.h),
                    SliceJobPasswordField(
                      fieldKey: rePasswordKey,
                      hint: 'Re-type Password',
                      autoValidation: true,
                      validator: (p0) {
                        final input = (p0 ?? '').trim();
                        if (input.isEmpty || input.length < 5) {
                          return 'Password must have at least 6 characters.';
                        }
                        final originalPassword = (_formKey
                                    .currentState?.fields[passwordKey]?.value ??
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
                    const SizedBox(height: 20.0),
                    Row(
                      children: [
                        Container(
                          height: 56.0,
                          width: 56.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: AppColors.red,
                          ),
                          child: IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(
                              Ionicons.arrow_back,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: Consumer(
                            builder: (context, ref, child) {
                              final isLoading =
                                  ref.watch(resetPasswordRef).isAuthenticating;
                              return MaterialButton(
                                onPressed: !isLoading ? _submit : () {},
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                color: AppColors.primary,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                minWidth: double.infinity,
                                height: 56.0,
                                elevation: 0.0,
                                child: isLoading
                                    ? SizedBox(
                                        width: 32.w,
                                        height: 32.w,
                                        child: CircularProgressIndicator(
                                          color: AppColors.kColorWhite,
                                        ),
                                      )
                                    : Text(
                                        'Reset',
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
