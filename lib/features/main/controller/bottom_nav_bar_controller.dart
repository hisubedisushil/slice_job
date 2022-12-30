import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavigationBarController extends StateNotifier<int> {
  late final PageController _pageController = PageController(
    initialPage: 0,
  );

  BottomNavigationBarController(super.state);

  void setSelectedIndex(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutQuad,
    );
    state = index;
  }

  PageController get pageController => _pageController;
}
