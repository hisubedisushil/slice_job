import 'package:flutter/cupertino.dart';
import 'package:slice_job/app_setup/routes/router.dart';

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
}
