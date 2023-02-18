import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slice_job/constants/app_colors.dart';
import 'package:slice_job/features/main/controller/bottom_nav_bar_controller.dart';
import 'package:slice_job/helpers/constants.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    final navRef = ref.read(navBarController.notifier);
    final selectedIndex = ref.watch(navBarController);
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: SlidingClippedNavBar(
          backgroundColor: AppColors.primary,
          onButtonPressed: navRef.setSelectedIndex,
          activeColor: AppColors.white,
          inactiveColor: AppColors.white.withOpacity(0.6),
          selectedIndex: selectedIndex,
          iconSize: 24.0,
          barItems: navBarItems,
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: navRef.pageController,
          children: pages,
        ),
      ),
    );
  }
}
