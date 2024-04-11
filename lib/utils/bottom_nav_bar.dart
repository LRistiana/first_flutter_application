import "package:flutter/material.dart";
import "package:google_nav_bar/google_nav_bar.dart";

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const GNav(
        color: Colors.grey,
        activeColor: Colors.black,
        backgroundColor: Colors.black,
        mainAxisAlignment: MainAxisAlignment.center,
        tabBackgroundColor: Color.fromRGBO(215, 252, 112, 1),
        tabBorderRadius: 16,
        tabs:  [
          GButton(icon: Icons.home, text: 'Home'),
          GButton(icon: Icons.search, text: 'Search'),
          GButton(icon: Icons.shopping_cart, text: 'Cart'),
          GButton(icon: Icons.person_2, text: 'Profile')
        ],
      ),
    );
  }
}
