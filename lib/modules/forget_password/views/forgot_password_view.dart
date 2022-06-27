import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:slice_job/controllers/authentication_controller.dart';

import '/constants/app_colors.dart';
import '/packages/panara_dialogs/panara_dialogs.dart';
import 'reset_password_view.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final _email = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    'Forget Password',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    decoration: InputDecoration(
                      label: const Text(
                        'Email',
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
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      bool b = RegExp(
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                          .hasMatch(value ?? '');

                      if (!b) {
                        return 'Please enter valid email address';
                      }
                      return null;
                    },
                    controller: _email,
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
                            'Submit',
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

    bool b = RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(_email.text);

    if (!b) {
      await PanaraInfoDialog.showAnimatedGrow(
        context,
        title: "Invalid Email",
        message: "Please enter valid email or mobile number.",
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
        context.read<AuthenticationController>().forgotPassword(
              email: _email.text,
            ),
      ),
    );
    log(result.toString());
    if (result is bool) {
      if (result) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => ResetPasswordView(
              email: _email.text,
            ),
          ),
        );
      }
    } else if (result is String) {
      await PanaraInfoDialog.showAnimatedGrow(
        context,
        title: "Forgot Password Failed",
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
        title: "Forgot Password Failed",
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
