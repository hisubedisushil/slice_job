import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:ionicons/ionicons.dart';
// import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_colors.dart';
import '../../../controllers/authentication_controller.dart';
import '../../../packages/panara_dialogs/panara_dialogs.dart';

class ResetPasswordView extends StatefulWidget {
  final String email;

  const ResetPasswordView({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final _otp = TextEditingController();
  final _password = TextEditingController();
  final _rePassword = TextEditingController();

  bool _showPassword = false;
  bool _showConfirmPassword = false;

  @override
  void dispose() {
    _otp.dispose();
    _password.dispose();
    _rePassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Center(
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
                  // Pinput(
                  //   controller: _otp,
                  //   length: 6,
                  //   defaultPinTheme: PinTheme(
                  //     width: (width - 20) / 6,
                  //     height: (width - 20) / 6,
                  //     textStyle: TextStyle(
                  //       fontSize: 32.0,
                  //       color: AppColors.black,
                  //       fontWeight: FontWeight.bold,
                  //       height: 0.75,
                  //     ),
                  //     decoration: BoxDecoration(
                  //       border: Border.all(color: AppColors.primary),
                  //       borderRadius: BorderRadius.circular(10.0),
                  //     ),
                  //     padding: EdgeInsets.zero,
                  //     margin: EdgeInsets.zero,
                  //   ),
                  // ),
                  const SizedBox(height: 40.0),
                  TextFormField(
                    obscureText: !_showPassword,
                    decoration: InputDecoration(
                      label: const Text(
                        'New Password',
                      ),
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      fillColor: AppColors.white.withOpacity(0.8),
                      hintStyle: TextStyle(
                        color: AppColors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                      filled: true,
                      suffixIcon: IconButton(
                        onPressed: () {
                          _showPassword = !_showPassword;
                          if (mounted) {
                            setState(() {});
                          }
                        },
                        icon: Icon(
                          _showPassword
                              ? Ionicons.eye_off_outline
                              : Ionicons.eye_outline,
                        ),
                      ),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if ((value ?? '').length < 6) {
                        return 'Password must have at least 6 characters.';
                      }
                      return null;
                    },
                    controller: _password,
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    obscureText: !_showConfirmPassword,
                    decoration: InputDecoration(
                      label: const Text(
                        'Re-type New Password',
                      ),
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      fillColor: AppColors.white.withOpacity(0.8),
                      hintStyle: TextStyle(
                        color: AppColors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                      filled: true,
                      suffixIcon: IconButton(
                        onPressed: () {
                          _showConfirmPassword = !_showConfirmPassword;
                          if (mounted) {
                            setState(() {});
                          }
                        },
                        icon: Icon(
                          _showConfirmPassword
                              ? Ionicons.eye_off_outline
                              : Ionicons.eye_outline,
                        ),
                      ),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if ((value ?? '') != _password.text) {
                        return 'Password does not match.';
                      }
                      return null;
                    },
                    controller: _rePassword,
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
                        child: MaterialButton(
                          onPressed: _submit,
                          child: Text(
                            'Reset',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          color: AppColors.primary,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          minWidth: double.infinity,
                          height: 56.0,
                          elevation: 0.0,
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
    );
  }

  _submit() async {
    FocusScope.of(context).requestFocus(FocusNode());

    if (_otp.text.length != 6) {
      await PanaraInfoDialog.showAnimatedGrow(
        context,
        title: "Invalid OTP",
        message: "OTP must be 6 digit.",
        buttonText: 'Okay',
        onTapDismiss: () => Navigator.pop(context),
        panaraDialogType: PanaraDialogType.error,
        barrierDismissible: true,
      );
      return;
    }

    if (_password.text.length < 6) {
      await PanaraInfoDialog.showAnimatedGrow(
        context,
        title: "Invalid New Password",
        message: "Password must have at least 6 characters.",
        buttonText: 'Okay',
        onTapDismiss: () => Navigator.pop(context),
        panaraDialogType: PanaraDialogType.error,
        barrierDismissible: true,
      );
      return;
    }

    if (_password.text != _rePassword.text) {
      await PanaraInfoDialog.showAnimatedGrow(
        context,
        title: "Invalid Re-Type Password",
        message: "Password does not match.",
        buttonText: 'Okay',
        onTapDismiss: () => Navigator.pop(context),
        panaraDialogType: PanaraDialogType.error,
        barrierDismissible: true,
      );
      return;
    }

    final result = await showDialog(
      context: context,
      builder: (context) => FutureProgressDialog(
        context.read<AuthenticationController>().resetPassword(
              email: widget.email,
              code: _otp.text,
              password: _password.text,
            ),
      ),
    );

    if (result is bool) {
      if (result) {
        await PanaraInfoDialog.showAnimatedGrow(
          context,
          title: "Reset Password Success",
          message: 'You have successfully reset password. '
              'Please login using new password.',
          buttonText: 'Okay',
          onTapDismiss: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          panaraDialogType: PanaraDialogType.success,
          barrierDismissible: true,
        );
      }
    } else if (result is String) {
      await PanaraInfoDialog.showAnimatedGrow(
        context,
        title: "Reset Password Failed",
        message: result,
        buttonText: 'Okay',
        onTapDismiss: () => Navigator.pop(context),
        panaraDialogType: PanaraDialogType.error,
        barrierDismissible: true,
      );
      return;
    } else {
      await PanaraInfoDialog.showAnimatedGrow(
        context,
        title: "Reset Password Failed",
        message: "Oops! Something went wrong.",
        buttonText: 'Okay',
        onTapDismiss: () => Navigator.pop(context),
        panaraDialogType: PanaraDialogType.error,
        barrierDismissible: true,
      );
      return;
    }
  }
}
