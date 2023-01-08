import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:slice_job/app.dart';
import 'package:slice_job/app/urls.dart';
import 'package:slice_job/app_setup/routes/router.dart';
import 'package:slice_job/features/main/main_screen.dart';
import 'package:slice_job/helpers/extensions/padding_extensions.dart';
import 'package:slice_job/helpers/util/inapp_webview.dart';

import '/constants/app_colors.dart';

class HomeScreenMenuSheet extends ConsumerStatefulWidget {
  const HomeScreenMenuSheet({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreenMenuSheet> createState() =>
      _HomeScreenMenuSheetState();
}

class _HomeScreenMenuSheetState extends ConsumerState<HomeScreenMenuSheet> {
  void _navigate(String routeName) {
    context.pushNamed(
      routeName,
    );
  }

  Widget _divider() => Divider(
        height: 0.0,
        indent: 20.w,
        endIndent: 20.w,
      );

  final inAppBrowser = SliceJobAppBrowser();

  @override
  Widget build(BuildContext context) {
    final navbar = ref.read(navBarController.notifier);
    final authState = ref.watch(authRef);
    final divider = _divider();

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
        if (!authState.isAuthenticated)
          SheetListTileItem(
            onTap: () {
              _navigate(RoutePaths.loginRoute.routeName);
            },
            iconData: Ionicons.lock_open_outline,
            label: 'Login',
          ),
        if (!authState.isAuthenticated) divider,
        if (!authState.isAuthenticated)
          SheetListTileItem(
            onTap: () {
              _navigate(RoutePaths.registerRoute.routeName);
            },
            iconData: Ionicons.person_add_outline,
            label: 'Register',
          ),
        if (!authState.isAuthenticated) divider,
        if (authState.isAuthenticated)
          SheetListTileItem(
            onTap: () {
              navbar.setSelectedIndex(3);
              context.pop();
            },
            iconData: Ionicons.person_outline,
            label: 'Profile',
          ),
        if (authState.isAuthenticated) divider,
        SheetListTileItem(
          onTap: () {
            navbar.setSelectedIndex(1);
            context.pop();
          },
          iconData: Ionicons.briefcase_outline,
          label: 'Jobs',
        ),
        divider,
        SheetListTileItem(
          onTap: () {
            navbar.setSelectedIndex(2);
            context.pop();
          },
          iconData: Ionicons.chatbox_ellipses_outline,
          label: 'Blogs',
        ),
        divider,
        SheetListTileItem(
          onTap: () {
            context.pop();
            // _navigate(RoutePaths.registerRoute.routeName);
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (_) => const TestCategoriesView(),
            //   ),
            // );
          },
          iconData: Ionicons.clipboard_outline,
          label: 'Test Yourself',
        ),
        divider,
        SheetListTileItem(
          onTap: () {
            context.pop();
            _navigate(RoutePaths.aboutUsRoute.routeName);
          },
          iconData: Ionicons.information_outline,
          label: 'About Us',
        ),
        divider,
        SheetListTileItem(
          onTap: () {
            context.pop();
            _navigate(RoutePaths.contactUsRoute.routeName);
          },
          iconData: Ionicons.call_outline,
          label: 'Contact Us',
        ),
        divider,
        SheetListTileItem(
          onTap: () {
            context.pop();
            _navigate(RoutePaths.faqsRoute.routeName);
          },
          iconData: Ionicons.help,
          label: 'FAQs',
        ),
        divider,
        SheetListTileItem(
          onTap: () {
            context.pop();
            inAppBrowser.openUrl(termsAndConditionsUrl);
          },
          iconData: Ionicons.reader_outline,
          label: 'Terms & Conditions',
        ),
        divider,
        SheetListTileItem(
          onTap: () {
            context.pop();
            inAppBrowser.openUrl(privacyPolicyUrl);
          },
          iconData: Ionicons.lock_closed_outline,
          label: 'Privacy Policy',
        ),
        divider,
        if (authState.isAuthenticated)
          SheetListTileItem(
            onTap: () {
              context.pop();
              _navigate(RoutePaths.removeAccountRoute.routeName);
            },
            iconData: Ionicons.close,
            label: 'Remove Account',
          ),
        SizedBox(
          height: MediaQuery.of(context).padding.bottom + 20.0,
        )
      ],
    );
  }
}

class SheetListTileItem extends StatelessWidget {
  const SheetListTileItem({
    super.key,
    required this.onTap,
    required this.iconData,
    required this.label,
  });

  final void Function() onTap;
  final IoniconsData iconData;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        iconData,
        color: AppColors.primary,
        size: 24.w,
      ),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.black,
        ),
      ),
      horizontalTitleGap: 0.0,
      dense: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
    ).pX(10.w);
  }
}
