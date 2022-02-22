import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Profile',
        style: TextStyle(
          fontFamily: 'AlegreyaSans',
          fontWeight: FontWeight.w900,
          fontSize: 24.0,
        ),
      ),
    );
  }
}
