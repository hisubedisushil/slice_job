import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pinput/pinput.dart';
import 'package:slice_job/app/entities/app_entities.dart';
import 'package:slice_job/app_setup/routes/router.dart';
import 'package:slice_job/constants/app_colors.dart';
import 'package:slice_job/core/models/authentication/user.dart';
import 'package:slice_job/features/auth/provider/auth_provider.dart';
import 'package:slice_job/helpers/extensions/context_extension.dart';

final verifyRef =
    StateNotifierProvider.autoDispose<AuthProvider, AuthState>((ref) {
  return AuthProvider(ref: ref);
});

class VerifyScreen extends ConsumerStatefulWidget {
  final User user;

  const VerifyScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  ConsumerState<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends ConsumerState<VerifyScreen> {
  final _otp = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _otp.dispose();
    super.dispose();
  }

  _verify() async {
    if (_formKey.currentState?.validate() ?? false) {
      FocusScope.of(context).requestFocus(FocusNode());
      ref.read(verifyRef.notifier).verifyRegister(
            email: widget.user.email!,
            phone: widget.user.phoneNumber!,
            code: _otp.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(verifyRef, (previous, next) {
      if (next.error != null) {
        ref.read(verifyRef.notifier).resetError();
        final errorMsg = next.error!.reason;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              errorMsg,
            ),
          ),
        );
      }
      if (next.isAuthenticated && next.user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.primary.withAlpha(200),
            content: Text(
              'Registration Successful! Login with your new credential.',
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
        context.pushReplacementNamed(
          loginRoute,
        );
      }
    });
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Form(
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
                      'Verify your email',
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
                        'Hi ${widget.user.firstName}! Check your email and enter '
                        'verification code below to verify your email '
                        'address and complete registration process.',
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
                      defaultPinTheme: PinTheme(
                        width: (width - 20) / 8,
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
                      ),
                      validator: FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.required(
                              errorText: 'Enter pin received in message!'),
                          FormBuilderValidators.equalLength(6,
                              errorText: 'Enter 6 digit OTP from message.'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40.0),
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
                                ref.watch(verifyRef).isAuthenticating;
                            return MaterialButton(
                              onPressed: !isLoading ? _verify : () {},
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
                                      'Verify',
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
