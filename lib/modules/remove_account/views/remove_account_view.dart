import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:slice_job/controllers/authentication_controller.dart';

import '/constants/app_colors.dart';
import '/packages/panara_dialogs/panara_dialogs.dart';
import '../../../services/preference_service.dart';
import '../../navbar/views/nav_bar_view.dart';

class RemoveAccountView extends StatefulWidget {
  const RemoveAccountView({Key? key}) : super(key: key);

  @override
  State<RemoveAccountView> createState() => _RemoveAccountViewState();
}

class _RemoveAccountViewState extends State<RemoveAccountView> {
  final _password = TextEditingController();
  final _rePassword = TextEditingController();

  bool _showPassword = false;
  bool _showConfirmPassword = false;

  @override
  void dispose() {
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
                    'Remove Account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
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

    final result = await showDialog(
      context: context,
      builder: (context) => FutureProgressDialog(
        context
            .read<AuthenticationController>()
            .removeAccount(password: _password.text.trim()),
      ),
    );

    log(result.toString());

    await PreferenceService.service.clearPreferences();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const NavBarView(),
      ),
      (route) => false,
    );
  }
}
