import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '/packages/panara_dialogs/panara_dialogs.dart';
import '../../../constants/app_colors.dart';
import '../../../controllers/profile_controller.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({Key? key}) : super(key: key);

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final _oldPassword = TextEditingController();
  final _password = TextEditingController();
  final _rePassword = TextEditingController();

  bool _showOldPassword = false;
  bool _showPassword = false;
  bool _showConfirmPassword = false;

  @override
  void dispose() {
    _oldPassword.dispose();
    _password.dispose();
    _rePassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      child: Scaffold(
        backgroundColor: AppColors.primary.withOpacity(0.1),
        appBar: AppBar(
          title: const Text('Change Password'),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextFormField(
                  obscureText: !_showOldPassword,
                  decoration: InputDecoration(
                    label: const Text(
                      'Old Password',
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
                        _showOldPassword = !_showOldPassword;
                        if (mounted) {
                          setState(() {});
                        }
                      },
                      icon: Icon(
                        _showOldPassword
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
                  controller: _oldPassword,
                ),
                const SizedBox(height: 10.0),
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
                const SizedBox(height: 10.0),
                MaterialButton(
                  onPressed: _update,
                  child: Text(
                    'Change',
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
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  minWidth: double.infinity,
                  height: 56.0,
                  elevation: 0.0,
                ),
                const SizedBox(height: 60.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _update() async {
    FocusScope.of(context).requestFocus(FocusNode());

    if (_oldPassword.text.length < 6) {
      await PanaraInfoDialog.showAnimatedGrow(
        context,
        title: "Invalid Old Password",
        message: "Password must have at least 6 characters.",
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

    String result = await showDialog(
      context: context,
      builder: (context) => FutureProgressDialog(
        context.read<ProfileController>().changePassword(
              oldPassword: _oldPassword.text,
              newPassword: _password.text,
            ),
      ),
    );
    log(result.toString());

    if (result.isEmpty) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Your password is successfully updated.',
            textAlign: TextAlign.center,
          ),
          backgroundColor: AppColors.green,
        ),
      );
    } else {
      await PanaraInfoDialog.showAnimatedGrow(
        context,
        title: "Change Password Failed",
        message: result,
        buttonText: 'Okay',
        onTapDismiss: () => Navigator.pop(context),
        panaraDialogType: PanaraDialogType.error,
        barrierDismissible: true,
      );
      return;
    }
  }
}
