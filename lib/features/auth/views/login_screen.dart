import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ionicons/ionicons.dart';
import 'package:slice_job/app.dart';
import 'package:slice_job/app/entities/app_entities.dart';
import 'package:slice_job/app_setup/routes/router.dart';
import 'package:slice_job/constants/app_colors.dart';
import 'package:slice_job/core/widgets/slicejob_input_fields.dart';
import 'package:slice_job/features/auth/provider/auth_provider.dart';
import 'package:slice_job/helpers/extensions/context_extension.dart';

String emailOrPhoneKey = 'emailOrPhone';
String passwordKey = 'password';

final loginRef =
    StateNotifierProvider.autoDispose<AuthProvider, AuthState>((ref) {
  return AuthProvider(ref: ref);
});

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  ValueNotifier<bool> togglePassword = ValueNotifier<bool>(false);

  void _onLogin() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      FocusScope.of(context).requestFocus(FocusNode());
      final formValue = _formKey.currentState!.value;
      ref.read(loginRef.notifier).login(
            username: formValue[emailOrPhoneKey],
            password: formValue[passwordKey],
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(
      loginRef,
      (previous, next) {
        if (next.error != null) {
          ref.read(loginRef.notifier).resetError();
          final errorMsg = next.error!.reason;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                errorMsg,
              ),
            ),
          );
        }
        if (next.authData != null && next.isAuthenticated) {
          ref.read(authRef.notifier).getSession();
          context.pop();
        }
      },
    );
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: FormBuilder(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Login',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30.h),
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
                    SizedBox(height: 20.h),
                    SliceJobPasswordField(
                      fieldKey: passwordKey,
                      hint: 'Password',
                      errorText: 'Password must have at least 6 characters.',
                      isDense: true,
                    ),
                    SizedBox(height: 20.h),
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
                          child: Consumer(builder: (context, ref, child) {
                            final isLoading =
                                ref.watch(loginRef).isAuthenticating;
                            return MaterialButton(
                              onPressed: !isLoading ? _onLogin : () {},
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
                                      'Login',
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            );
                          }),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            context.pushNamed(forgotPasswordRoute);
                          },
                          child: Text(
                            'Forget Password?',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        Text(
                          'Don\'t have an account? ',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            context.pushReplacementNamed(registerRoute);
                          },
                          child: Text(
                            'Create New Account',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
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
