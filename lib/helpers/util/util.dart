import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Widget verticalSpacer(double height, {Widget? child}) => SizedBox(
      height: height,
      child: child,
    );

Widget horizontalSpacer(double width) => SizedBox(
      width: width,
    );

Future<bool> openUrl(String url) async {
  final uri = Uri.parse(url);
  final canOpen = await canLaunchUrl(uri);
  if (canOpen) {
    launchUrl(uri);
  }
  return canOpen;
}
