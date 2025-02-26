import 'package:flutter/material.dart';
import 'package:vls_app/pages/home/home.dart';
import 'package:vls_app/pages/user_profile/user_profile_page.dart';
import 'package:vls_app/pages/videos/videos_page.dart';

import '../utils/constants/colors.dart';
import '../utils/theme/custom_themes/text_theme.dart';

class NavigationLayout extends StatefulWidget {
  const NavigationLayout({super.key});

  @override
  State<NavigationLayout> createState() => _NavigationLayoutState();
}

class _NavigationLayoutState extends State<NavigationLayout> {
  int _currentIndex = 0;

  final List<Widget> _pages = [HomePage(), VideosPage(), UserProfilePage()];

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _pages[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        elevation: 10.0,
        selectedIconTheme: IconThemeData(color: TColors.primary, size: 30),
        unselectedIconTheme: IconThemeData(color: TColors.black),
        selectedLabelStyle: TTextTheme.lightTextTheme.labelLarge,
        backgroundColor: TColors.white,
        useLegacyColorScheme: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.tv), label: 'Videos'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
