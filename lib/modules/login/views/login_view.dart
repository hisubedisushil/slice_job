import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:ionicons/ionicons.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:provider/provider.dart';
import 'package:slice_job/controllers/authentication_controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/app_colors.dart';
import '../../register/views/register_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _showPassword = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
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
                    'Login',
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
                        'Email Address',
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
                  TextFormField(
                    obscureText: !_showPassword,
                    decoration: InputDecoration(
                      label: const Text(
                        'Password',
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
                          setState(() {});
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
                          onPressed: _login,
                          child: Text(
                            'Login',
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
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            launch('https://www.slicejob.com/password/forget');
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
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const RegisterView(),
                            ),
                          );
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
                  // const SizedBox(height: 20.0),
                  // SocialLoginButton(
                  //   buttonType: SocialLoginButtonType.facebook,
                  //   borderRadius: 10.0,
                  //   height: 56.0,
                  //   text: 'Login Using Facebook',
                  //   onPressed: () {},
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _login() async {
    FocusScope.of(context).requestFocus(FocusNode());
    bool b = RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(_email.text);
    if (!b) {
      await PanaraInfoDialog.showAnimatedGrow(
        context,
        title: "Invalid Email",
        message: "Please enter valid email address.",
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
        title: "Invalid Password",
        message: "Password must have at least 6 characters.",
        buttonText: 'Okay',
        onTapDismiss: () => Navigator.pop(context),
        panaraDialogType: PanaraDialogType.error,
        barrierDismissible: true,
      );
      return;
    }

    bool result = await showDialog(
      context: context,
      builder: (context) => FutureProgressDialog(
        context.read<AuthenticationController>().login(
              email: _email.text,
              password: _password.text,
            ),
      ),
    );
    log(result.toString());
    if (result) {
      Navigator.pop(context);
    } else {
      await PanaraInfoDialog.showAnimatedGrow(
        context,
        title: "Login Failed",
        message: "Invalid Credential, Please try again.",
        buttonText: 'Okay',
        onTapDismiss: () => Navigator.pop(context),
        panaraDialogType: PanaraDialogType.error,
        barrierDismissible: true,
      );
      return;
    }
  }
}
