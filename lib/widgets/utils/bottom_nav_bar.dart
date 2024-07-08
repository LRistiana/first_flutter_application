import "package:first_flutter_application/utils/theme/color_theme.dart";
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
        backgroundColor: BackgroundColor.secondaryBackgroundColor,
        mainAxisAlignment: MainAxisAlignment.center,
        tabBackgroundColor: GradientColor.primaryGradientRevert.colors[1],
        tabBorderRadius: 36,
        onTabChange :(value) => onTabchange!(value),
        gap: 1,
        tabs:  const [
        GButton(icon: Icons.home, text: 'Home'),
          GButton(icon: Icons.people, text: 'Members'),
          GButton(icon: Icons.percent_outlined, text: 'Interest')
        ],
      ),
    );
  }
}
