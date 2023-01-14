import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:slice_job/app_setup/routes/router.dart';
import 'package:slice_job/constants/app_colors.dart';
import 'package:slice_job/helpers/extensions/context_extension.dart';


class ProfileUnauthenticatedView extends StatelessWidget {
  const ProfileUnauthenticatedView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Ionicons.lock_closed_outline,
                  size: 60.0,
                  color: AppColors.red,
                ),
                const SizedBox(height: 10.0),
                Text(
                  'To access the page you need to be login. '
                  'Please login if you already a register user or '
                  'register if you are not registered.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.grey,
                  ),
                ),
                const SizedBox(height: 10.0),
                MaterialButton(
                  onPressed: () {
                    context.pushNamed(
                      loginRoute,
                    );
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: AppColors.primary,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  elevation: 0.0,
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                MaterialButton(
                  onPressed: () {
                    context.pushNamed(
                      registerRoute,
                    );
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Colors.transparent,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  elevation: 0.0,
                  child: Text(
                    'Register',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
