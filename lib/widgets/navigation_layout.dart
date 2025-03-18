import 'package:flutter/material.dart';
import 'package:vls_app/pages/home/home.dart';
import 'package:vls_app/pages/news/news_page.dart';
import 'package:vls_app/pages/user_profile/user_profile_page.dart';
import 'package:vls_app/pages/videos/videos_page.dart';
import 'package:vls_app/widgets/drawer_menu.dart';

import '../pages/events/events_page.dart';
import '../pages/settings/settings.dart';
import '../utils/constants/colors.dart';
import '../utils/theme/custom_themes/appbar_theme.dart';
import '../utils/theme/custom_themes/text_theme.dart';

class NavigationLayout extends StatefulWidget {
  const NavigationLayout({super.key});

  @override
  State<NavigationLayout> createState() => _NavigationLayoutState();
}

class _NavigationLayoutState extends State<NavigationLayout> {
  final GlobalKey _bottomNavigationKey = GlobalKey();
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    VideosPage(),
    NewsPage(),
    EventsPage(),
  ];

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
      drawer: DrawerMenu(),
      appBar: AppBar(
        elevation: 5.0,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, 20.0),
          child: SizedBox.shrink(),
        ),
        shadowColor: TColors.black.withAlpha(100),
        backgroundColor: TAppBarTheme.lightAppBarTheme.backgroundColor,
        title: Text('VLS Suriname'), //Volkspartij Leefbaar Suriname
        actions: [
          // Padding(
          //   padding: EdgeInsets.only(right: 16.0),
          //   child: IconButton(
          //     onPressed: () {},
          //     icon: Icon(Icons.notifications),
          //   ),
          // ),
        ],
      ),
      body: Center(child: _pages[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        key: _bottomNavigationKey,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        elevation: 10.0,
        selectedIconTheme: IconThemeData(color: TColors.primary, size: 30),
        unselectedIconTheme: IconThemeData(color: TColors.black),
        selectedLabelStyle: TTextTheme.lightTextTheme.labelLarge,
        unselectedLabelStyle: TTextTheme.lightTextTheme.labelLarge,
        selectedItemColor: TColors.primary,
        unselectedItemColor: TColors.black,
        backgroundColor: TColors.white,
        selectedFontSize: 12.0,
        useLegacyColorScheme: false,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.tv), label: 'Videos'),
          BottomNavigationBarItem(
            icon: Icon(Icons.feed_outlined),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Events',
          ),
        ],
      ),
    );
  }
}
