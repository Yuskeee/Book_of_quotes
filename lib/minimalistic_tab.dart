import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MinimalisticNavBar extends StatefulWidget {
  Function callback;

  MinimalisticNavBar(this.callback, {Key? key}) : super(key: key);

  @override
  _MinimalisticNavBarState createState() => _MinimalisticNavBarState();

  int getSelectedIndex() {
    return _MinimalisticNavBarState()._getSelectedIndex();
  }
}

class _MinimalisticNavBarState extends State<MinimalisticNavBar> {
  int _selectedIndex = 0;

  int _getSelectedIndex() {
    return _selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 56, 165, 255),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black12,
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              gap: 10,
              activeColor: Colors.black,
              iconSize: 18,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: const Color.fromARGB(229, 255, 255, 255),
              color: Colors.white,
              tabs: const [
                GButton(
                  icon: Icons.menu_book_outlined,
                  text: 'Book',
                ),
                GButton(
                  icon: Icons.favorite,
                  text: 'Favorites',
                ),
                GButton(
                  icon: Icons.explore,
                  text: 'Discover',
                ),
                GButton(
                  icon: Icons.settings,
                  text: 'Settings',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                  widget.callback(index);
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
