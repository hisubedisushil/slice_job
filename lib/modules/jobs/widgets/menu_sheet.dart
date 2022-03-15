import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_colors.dart';
import '../../../controllers/authentication_controller.dart';
import '../../login/views/login_view.dart';
import '../../navbar/controllers/nav_bar_controller.dart';
import '../../pages/about_us_view.dart';
import '../../pages/contact_view.dart';
import '../../pages/faq_view.dart';
import '../../pages/privacy_view.dart';
import '../../pages/term_view.dart';
import '../../register/views/register_view.dart';

class MenuSheet extends StatelessWidget {
  const MenuSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navbar = context.watch<NavBarController>();
    final authentication = context.watch<AuthenticationController>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 15.0),
        Container(
          width: 120.0,
          height: 5.0,
          decoration: BoxDecoration(
            color: AppColors.grey,
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        const SizedBox(height: 15.0),
        if (!authentication.isLoggedIn)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LoginView(),
                  ),
                );
              },
              leading: Icon(
                Ionicons.lock_open_outline,
                color: AppColors.primary,
                size: 24.0,
              ),
              title: Text(
                'Login',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              horizontalTitleGap: 0.0,
              dense: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        if (!authentication.isLoggedIn)
          const Divider(
            height: 0.0,
            indent: 20.0,
            endIndent: 20.0,
          ),
        if (!authentication.isLoggedIn)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const RegisterView(),
                  ),
                );
              },
              leading: Icon(
                Ionicons.person_add_outline,
                color: AppColors.primary,
                size: 24.0,
              ),
              title: Text(
                'Register',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              horizontalTitleGap: 0.0,
              dense: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        if (!authentication.isLoggedIn)
          const Divider(
            height: 0.0,
            indent: 20.0,
            endIndent: 20.0,
          ),
        if (authentication.isLoggedIn)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ListTile(
              onTap: () {
                navbar.setSelectedIndex(3);
                Navigator.pop(context);
              },
              leading: Icon(
                Ionicons.person_outline,
                color: AppColors.primary,
                size: 24.0,
              ),
              title: Text(
                'Profile',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              horizontalTitleGap: 0.0,
              dense: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        if (authentication.isLoggedIn)
          const Divider(
            height: 0.0,
            indent: 20.0,
            endIndent: 20.0,
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: ListTile(
            onTap: () {
              navbar.setSelectedIndex(1);
              Navigator.pop(context);
            },
            leading: Icon(
              Ionicons.briefcase_outline,
              color: AppColors.primary,
              size: 24.0,
            ),
            title: Text(
              'Jobs',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            horizontalTitleGap: 0.0,
            dense: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        const Divider(
          height: 0.0,
          indent: 20.0,
          endIndent: 20.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: ListTile(
            onTap: () {
              navbar.setSelectedIndex(2);
              Navigator.pop(context);
            },
            leading: Icon(
              Ionicons.chatbox_ellipses_outline,
              color: AppColors.primary,
              size: 24.0,
            ),
            title: Text(
              'Blogs',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            horizontalTitleGap: 0.0,
            dense: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        const Divider(
          height: 0.0,
          indent: 20.0,
          endIndent: 20.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AboutUsView(),
                ),
              );
            },
            leading: Icon(
              Ionicons.information_outline,
              color: AppColors.primary,
              size: 24.0,
            ),
            title: Text(
              'About',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            horizontalTitleGap: 0.0,
            dense: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        const Divider(
          height: 0.0,
          indent: 20.0,
          endIndent: 20.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ContactView(),
                ),
              );
            },
            leading: Icon(
              Ionicons.call_outline,
              color: AppColors.primary,
              size: 24.0,
            ),
            title: Text(
              'Contact',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            horizontalTitleGap: 0.0,
            dense: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        const Divider(
          height: 0.0,
          indent: 20.0,
          endIndent: 20.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const FAQView(),
                ),
              );
            },
            leading: Icon(
              Ionicons.help,
              color: AppColors.primary,
              size: 24.0,
            ),
            title: Text(
              'FAQs',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            horizontalTitleGap: 0.0,
            dense: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        const Divider(
          height: 0.0,
          indent: 20.0,
          endIndent: 20.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const TermView(),
                ),
              );
            },
            leading: Icon(
              Ionicons.reader_outline,
              color: AppColors.primary,
              size: 24.0,
            ),
            title: Text(
              'Terms & Condition',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            horizontalTitleGap: 0.0,
            dense: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        const Divider(
          height: 0.0,
          indent: 20.0,
          endIndent: 20.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PrivacyView(),
                ),
              );
            },
            leading: Icon(
              Ionicons.lock_closed_outline,
              color: AppColors.primary,
              size: 24.0,
            ),
            title: Text(
              'Privacy & Policy',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            horizontalTitleGap: 0.0,
            dense: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).padding.bottom + 20.0,
        )
      ],
    );
  }
}
