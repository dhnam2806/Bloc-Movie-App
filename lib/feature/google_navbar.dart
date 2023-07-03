import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:movie_app/feature/search/ui/search_page.dart';
import 'home/ui/home_page.dart';

class GNavBar extends StatefulWidget {
  const GNavBar({super.key});

  @override
  State<GNavBar> createState() => _GNavBarState();
}

class _GNavBarState extends State<GNavBar> {
  int _currentIndex = 0;

  static List<Widget> navScreens = <Widget>[
    HomePage(),
    SearchPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navScreens.elementAt(_currentIndex),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GNav(
          gap: 8,
          backgroundColor: Colors.black,
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.red,
          padding: const EdgeInsets.all(12),
          duration: const Duration(milliseconds: 400),
          debug: true,
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.search,
              text: 'Search',
            ),
            GButton(
              icon: Icons.favorite,
              text: 'Favorite',
            ),
            GButton(
              icon: Icons.person,
              text: 'Profile',
            ),
          ],
          selectedIndex: _currentIndex,
          onTabChange: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
