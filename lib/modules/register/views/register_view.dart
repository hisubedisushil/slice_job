import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:ionicons/ionicons.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/app_colors.dart';
import '../../../controllers/authentication_controller.dart';
import '../../login/views/login_view.dart';
import 'verify_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _first = TextEditingController();
  final _last = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _password = TextEditingController();
  final _rePassword = TextEditingController();

  bool _showPassword = false;
  bool _showConfirmPassword = false;
  bool _receiveNews = true;
  bool _receivePromotions = true;
  bool _agree = false;

  @override
  void dispose() {
    _first.dispose();
    _last.dispose();
    _email.dispose();
    _phone.dispose();
    _password.dispose();
    _rePassword.dispose();
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
                    'Jobseeker Registration',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 1,
                        child: TextFormField(
                          decoration: InputDecoration(
                            label: const Text(
                              'First Name',
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textCapitalization: TextCapitalization.words,
                          validator: (value) {
                            if (((value ?? '').isEmpty)) {
                              return 'Please enter first name.';
                            }
                            return null;
                          },
                          controller: _first,
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 1,
                        child: TextFormField(
                          decoration: InputDecoration(
                            label: const Text(
                              'Last Name',
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textCapitalization: TextCapitalization.words,
                          validator: (value) {
                            if (((value ?? '').isEmpty)) {
                              return 'Please enter last name.';
                            }
                            return null;
                          },
                          controller: _last,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
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
                  const SizedBox(height: 10.0),
                  TextFormField(
                    decoration: InputDecoration(
                      label: const Text(
                        'Mobile',
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
                    keyboardType: TextInputType.phone,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    validator: (value) {
                      if ((value ?? '').length != 10) {
                        return 'Please enter valid mobile number';
                      }
                      return null;
                    },
                    controller: _phone,
                  ),
                  const SizedBox(height: 10.0),
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
                        'Re-type Password',
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
                  const SizedBox(height: 10.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: _receiveNews,
                        onChanged: (value) {
                          _receiveNews = value ?? false;
                          if (mounted) {
                            setState(() {});
                          }
                        },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'Receive news & updates about the site',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: _receivePromotions,
                        onChanged: (value) {
                          _receivePromotions = value ?? false;
                          if (mounted) {
                            setState(() {});
                          }
                        },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'Receive Other Promotions & Special Offers',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: _agree,
                        onChanged: (value) {
                          _agree = value ?? false;
                          if (mounted) {
                            setState(() {});
                          }
                        },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'I have read and agreed to the',
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 16.0,
                                  ),
                                ),
                                TextSpan(
                                  text: ' Terms & Conditions ',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 16.0,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      launchUrl(
                                        Uri.parse(
                                          'https://www.slicejob.com/company/terms',
                                        ),
                                      );
                                    },
                                ),
                                TextSpan(
                                  text: 'as well as',
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 16.0,
                                  ),
                                ),
                                TextSpan(
                                  text: ' Privacy Policy ',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 16.0,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      launchUrl(
                                        Uri.parse(
                                          'https://www.slicejob.com/company/policy',
                                        ),
                                      );
                                    },
                                ),
                                TextSpan(
                                  text: 'governing the use of Slicejob.com',
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
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
                          onPressed: _register,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          color: AppColors.primary,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          minWidth: double.infinity,
                          height: 56.0,
                          elevation: 0.0,
                          child: Text(
                            'Register',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
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
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginView(),
                            ),
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
    );
  }

  _register() async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (!_agree) {
      await PanaraInfoDialog.showAnimatedGrow(
        context,
        title: "Agreement Required",
        message: "Please agree to the Term & Conditions "
            "and Privacy Policy to register.",
        buttonText: 'Okay',
        onTapDismiss: () => Navigator.pop(context),
        panaraDialogType: PanaraDialogType.error,
        barrierDismissible: true,
      );
      return;
    }

    if (_first.text.isEmpty) {
      await PanaraInfoDialog.showAnimatedGrow(
        context,
        title: "Invalid First Name",
        message: "Please enter first name.",
        buttonText: 'Okay',
        onTapDismiss: () => Navigator.pop(context),
        panaraDialogType: PanaraDialogType.error,
        barrierDismissible: true,
      );
      return;
    }

    if (_last.text.isEmpty) {
      await PanaraInfoDialog.showAnimatedGrow(
        context,
        title: "Invalid Last Name",
        message: "Please enter last name.",
        buttonText: 'Okay',
        onTapDismiss: () => Navigator.pop(context),
        panaraDialogType: PanaraDialogType.error,
        barrierDismissible: true,
      );
      return;
    }

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

    if (_phone.text.length != 10) {
      await PanaraInfoDialog.showAnimatedGrow(
        context,
        title: "Invalid Mobile Number",
        message: "Please enter valid mobile number",
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

    if (_password.text != _rePassword.text) {
      await PanaraInfoDialog.showAnimatedGrow(
        context,
        title: "Invalid Password",
        message: "Password does not match.",
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
        context.read<AuthenticationController>().register(
              firstName: _first.text,
              lastName: _last.text,
              email: _email.text,
              phone: _phone.text,
              password: _password.text,
              rePassword: _rePassword.text,
            ),
      ),
    );
    log(result.toString());

    if (result) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => VerifyView(
            name: _first.text,
            email: _email.text,
            phone: _phone.text,
          ),
        ),
      );
    } else {
      await PanaraInfoDialog.showAnimatedGrow(
        context,
        title: "Register Failed",
        message: "Email already used, try different email.",
        buttonText: 'Okay',
        onTapDismiss: () => Navigator.pop(context),
        panaraDialogType: PanaraDialogType.error,
        barrierDismissible: true,
      );
      return;
    }
  }
}
