import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ionicons/ionicons.dart';
import 'package:slice_job/app/entities/app_entities.dart';
import 'package:slice_job/app_setup/routes/router.dart';
import 'package:slice_job/core/widgets/slicejob_input_fields.dart';
import 'package:slice_job/features/auth/provider/auth_provider.dart';
import 'package:slice_job/helpers/extensions/context_extension.dart';

import '/constants/app_colors.dart';

String emailOrPhoneKey = 'emailOrPhone';

final forgotPasswordRef =
    StateNotifierProvider.autoDispose<AuthProvider, AuthState>((ref) {
  return AuthProvider(ref: ref);
});

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void dispose() {
    super.dispose();
  }

  _submit() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      FocusScope.of(context).requestFocus(FocusNode());
      final formValue = _formKey.currentState!.value;
      ref
          .read(forgotPasswordRef.notifier)
          .forgotPassword(formValue[emailOrPhoneKey]);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(
      forgotPasswordRef,
      (previous, next) {
        if (next.error != null) {
          ref.read(forgotPasswordRef.notifier).resetError();
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
          context.pushReplacementNamed(resetPasswordRoute,
              extra: _formKey.currentState!.value[emailOrPhoneKey]);
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
                      'Forget Password',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    SliceJobTextField(
                      fieldKey: emailOrPhoneKey,
                      formKey: _formKey,
                      hint: 'Email Or Phone',
                      validator: (value) {
                        final input = (value ?? '').trim();
                        if (input.isEmpty) {
                          return 'Please Enter email or phone!';
                        }

                        final isEmail =
                            FormBuilderValidators.email().call(value);
                        if (isEmail == null) {
                          return null;
                        }
                        final phone = int.tryParse(input);
                        if (phone != null) {
                          if (input.length == 10) {
                            return null;
                          } else {
                            return 'Enter 10 digits mobile number!';
                          }
                        }
                        return 'Please Enter valid email or phone number!';
                      },
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
                                  ref.watch(forgotPasswordRef).isAuthenticating;
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
                                        'Submit',
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
