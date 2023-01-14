import 'package:flutter/cupertino.dart';

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
}
