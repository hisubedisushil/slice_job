import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ionicons/ionicons.dart';
import 'package:slice_job/app/entities/app_entities.dart';
import 'package:slice_job/app/urls.dart';
import 'package:slice_job/app_setup/routes/router.dart';
import 'package:slice_job/constants/app_colors.dart';
import 'package:slice_job/core/widgets/slicejob_input_fields.dart';
import 'package:slice_job/features/auth/provider/auth_provider.dart';
import 'package:slice_job/helpers/extensions/context_extension.dart';
import 'package:slice_job/helpers/util/inapp_webview.dart';
import 'package:slice_job/helpers/util/util.dart';

String firstNameKey = 'firstName';
String lastNameKey = 'lastName';
String phoneKey = 'phone';
String emailKey = 'email';
String passwordKey = 'password';
String rePasswordKey = 're-password';
String newsKey = 'news';
String promotionKey = 'promotion';
String agreementKey = 'agreement';

final registerRef =
    StateNotifierProvider.autoDispose<AuthProvider, AuthState>((ref) {
  return AuthProvider(ref: ref);
});

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final inAppBrowser = SliceJobAppBrowser();
  final _formKey = GlobalKey<FormBuilderState>();

  void _openBrowser(String url) {
    inAppBrowser.openUrl(url);
  }

  void _register() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      FocusScope.of(context).requestFocus(FocusNode());
      final formValue = _formKey.currentState!.value;
      ref.read(registerRef.notifier).register(
            firstName: formValue[firstNameKey],
            lastName: formValue[lastNameKey],
            email: formValue[emailKey],
            phone: formValue[phoneKey],
            password: formValue[passwordKey],
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(
      registerRef,
      (previous, next) {
        if (next.user != null) {
          context.pushReplacementNamed(
            verifyRoute,
            extra: next.user?.copyWith(
                phoneNumber: _formKey.currentState?.fields[phoneKey]?.value),
          );
        }
        if (next.error != null) {
          ref.read(registerRef.notifier).resetError();
          final errorMsg = next.error!.reason;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                errorMsg,
              ),
            ),
          );
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
                      'Jobseeker Registration',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    verticalSpacer(30.h),
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
                    SliceJobTextField(
                      fieldKey: emailKey,
                      formKey: _formKey,
                      hint: 'Email',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: 'Email required!'),
                        FormBuilderValidators.email(
                            errorText: 'Enter Valid Email!')
                      ]),
                      isDense: true,
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
                      isDense: true,
                    ),
                    verticalSpacer(15.h),
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
                    SizedBox(
                      height: 40.h,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SliceJobCehckBox(
                          fieldKey: newsKey,
                          text: RichText(
                            text: TextSpan(
                              text: 'Receive news & updates about the site',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                      child: SliceJobCehckBox(
                        fieldKey: promotionKey,
                        text: RichText(
                          text: TextSpan(
                            text: 'Receive Other Promotions & Special Offers',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SliceJobCehckBox(
                      fieldKey: agreementKey,
                      mandatory: true,
                      errorText:
                          'You must accept terms and conditions to continue!',
                      text: RichText(
                        text: TextSpan(
                          text: 'I have read and agreed to the ',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: AppColors.black,
                          ),
                          children: [
                            TextSpan(
                              text: ' Terms & Conditions ',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 14.0,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  _openBrowser(termsAndConditionsUrl);
                                },
                            ),
                            TextSpan(
                              text: 'as well as',
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 14.0,
                              ),
                            ),
                            TextSpan(
                              text: ' Privacy Policy ',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 14.0,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  _openBrowser(privacyPolicyUrl);
                                },
                            ),
                            TextSpan(
                              text: 'governing the use of ',
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 14.0,
                              ),
                            ),
                            TextSpan(
                              text: 'slicejob.com',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 14.0,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  _openBrowser(webUrl);
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                    verticalSpacer(20.h),
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
                                ref.watch(registerRef).isAuthenticating;
                            return MaterialButton(
                              onPressed: !isLoading ? _register : () {},
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
                                      'Register',
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        horizontalSpacer(5.w),
                        InkWell(
                          onTap: () {
                            context.pushNamed(
                              loginRoute,
                            );
                          },
                          child: Text(
                            'Login',
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
