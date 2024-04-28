import "package:flutter/material.dart";
import "package:google_nav_bar/google_nav_bar.dart";

class BottomNavBar extends StatelessWidget {
  void Function(int)? onTabchange;
  BottomNavBar({super.key, required this.onTabchange});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GNav(
        color: Colors.grey,
        activeColor: Colors.black,
        backgroundColor: Colors.black,
        mainAxisAlignment: MainAxisAlignment.center,
        tabBackgroundColor: const Color.fromRGBO(215, 252, 112, 1),
        tabBorderRadius: 16,
        onTabChange :(value) => onTabchange!(value),


        tabs:  const [
          GButton(icon: Icons.dashboard, text: 'Dasboard'),
          GButton(icon: Icons.people, text: 'Anggota'),
          GButton(icon: Icons.person_2, text: 'Profile')
        ],
      ),
    );
  }
}
