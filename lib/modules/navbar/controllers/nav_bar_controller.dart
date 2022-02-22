import 'package:flutter/material.dart';

class NavBarController with ChangeNotifier {
  late PageController _pageController;
  int _selectedIndex = 0;

  NavBarController() {
    _pageController = PageController(
      initialPage: _selectedIndex,
    );
  }

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    _pageController.animateToPage(
      _selectedIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutQuad,
    );
    notifyListeners();
  }

  PageController get pageController => _pageController;
  int get selectedIndex => _selectedIndex;
}
