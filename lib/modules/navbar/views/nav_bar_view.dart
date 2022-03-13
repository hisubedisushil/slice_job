import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:provider/provider.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

import '../../../constants/app_colors.dart';
import '../../../models/job_category_model.dart';
import '../../blogs/views/blogs_view.dart';
import '../../jobs/views/job_filter_view.dart';
import '../../jobs/views/job_view.dart';
import '../../profile/views/profile_view.dart';
import '../controllers/nav_bar_controller.dart';

class NavBarView extends StatefulWidget {
  final int index;
  final String? searchText;
  final JobCategoryModel? category;

  const NavBarView({
    Key? key,
    this.index = 0,
    this.searchText,
    this.category,
  }) : super(key: key);

  @override
  State<NavBarView> createState() => _NavBarViewState();
}

class _NavBarViewState extends State<NavBarView> {
  @override
  void initState() {
    super.initState();
    if (widget.index != 0) {
      context.read<NavBarController>().setSelectedIndex(widget.index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final navigator = context.watch<NavBarController>();

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: WillPopScope(
        onWillPop: () async {
          PanaraConfirmDialog.showAnimatedGrow(
            context,
            title: "Close Application",
            message: "Are you sure you want to exit this application?",
            confirmButtonText: "Yes",
            cancelButtonText: "No",
            onTapCancel: () {
              Navigator.pop(context);
            },
            onTapConfirm: () {
              SystemNavigator.pop();
            },
            panaraDialogType: PanaraDialogType.error,
            barrierDismissible: true,
          );
          return false;
        },
        child: Material(
          color: AppColors.white,
          child: Scaffold(
            backgroundColor: AppColors.primary.withOpacity(0.1),
            body: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: navigator.pageController,
              children: [
                const JobView(),
                JobFilterView(
                  searchText: widget.searchText,
                  category: widget.category,
                ),
                const BlogsView(),
                const ProfileView(),
              ],
            ),
            bottomNavigationBar: Material(
              color: AppColors.primary,
              child: SafeArea(
                child: SlidingClippedNavBar(
                  backgroundColor: AppColors.primary,
                  onButtonPressed: navigator.setSelectedIndex,
                  activeColor: AppColors.white,
                  inactiveColor: AppColors.white.withOpacity(0.6),
                  selectedIndex: navigator.selectedIndex,
                  iconSize: 24.0,
                  barItems: <BarItem>[
                    BarItem(
                      icon: Ionicons.home_outline,
                      title: 'Home',
                    ),
                    BarItem(
                      icon: Ionicons.briefcase_outline,
                      title: 'Jobs',
                    ),
                    BarItem(
                      icon: Ionicons.chatbox_ellipses_outline,
                      title: 'Blogs',
                    ),
                    BarItem(
                      icon: Ionicons.person_outline,
                      title: 'Profile',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
