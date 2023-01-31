import 'package:flutter/material.dart';
import 'package:slice_job/app_setup/routes/router.dart';
import 'package:slice_job/features/auth/views/login_screen.dart';
import 'package:slice_job/features/profile/views/cv/widgets/updating_dialog.dart';

extension RouterExtension on BuildContext {
  pushNamed(String routeName, {dynamic extra}) {
    Navigator.of(this).pushNamed(
      routeName,
      arguments: extra,
    );
  }

  pop() {
    Navigator.of(this).pop();
  }

  pushReplacementNamed(String routeName, {dynamic extra}) {
    Navigator.of(this).pushReplacementNamed(
      routeName,
      arguments: extra,
    );
  }

  popUntilNamed(String routeName, {dynamic extra}) {
    Navigator.of(this).pushNamedAndRemoveUntil(routeName, (route) {
      return route.settings.name == mainRoute;
    });
  }

  void pushLoginScreen() {
    showDialog<bool>(
      context: this,
      builder: (context) {
        return const LoginScreen();
      },
    );
  }

  void showUpdatingCVInfoDialog(String message) {
    showDialog(
      context: this,
      builder: (context) {
        return UpdatingCVInfoDialog(message: message);
      },
    );
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
        ),
      ),
    );
  }
}
