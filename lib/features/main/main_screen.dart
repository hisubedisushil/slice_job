import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import 'package:slice_job/constants/app_colors.dart';
import 'package:slice_job/features/blogs/views/blogs_screen.dart';
import 'package:slice_job/features/home/home_screen.dart';
import 'package:slice_job/features/main/controller/bottom_nav_bar_controller.dart';
import 'package:slice_job/features/profile/views/profile_screen.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

final navBarController =
    StateNotifierProvider<BottomNavigationBarController, int>(
        (ref) => BottomNavigationBarController(0));

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    final navRef = ref.read(navBarController.notifier);
    final selectedIndex = ref.watch(navBarController);
    return Scaffold(
      bottomNavigationBar: SlidingClippedNavBar(
        backgroundColor: AppColors.primary,
        onButtonPressed: navRef.setSelectedIndex,
        activeColor: AppColors.white,
        inactiveColor: AppColors.white.withOpacity(0.6),
        selectedIndex: selectedIndex,
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
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: navRef.pageController,
        children: [
          // const JobView(),
          // JobFilterView(
          //   searchText: widget.searchText,
          //   category: widget.category,
          // ),
          // const BlogsView(),
          // const ProfileView(),
          const HomeScreen(),
          Container(
            color: Colors.red,
          ),
          const BlogsScreen(),
          const ProfileScreen(),
        ],
      ),
    );
  }
}
