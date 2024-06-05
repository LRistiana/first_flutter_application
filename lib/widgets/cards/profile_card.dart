import 'package:first_flutter_application/utils/theme/color_theme.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: 400,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: GradientColor.primaryGradient,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: BackgroundColor.primaryBackgroundColor,
                ),
                child: const Icon(
                  Icons.person,
                  color: GeneralColor.lightColor,
                ),
              ),
              const SizedBox(width: 8),
              const Column(
                crossAxisAlignment:CrossAxisAlignment.start,  
                children: [
                  Text("Guest",
                      style:  TextStyle(
                          color: GeneralColor.darkColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  Text("Guest@gmail.com",
                      style:  TextStyle(
                          color: BackgroundColor.primaryBackgroundColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                ],
              )
            ],
          ),
          const SizedBox(height: 36),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Total Balance", style:  TextStyle(
                  color: GeneralColor.darkColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold)),
              Text("Rp 100.000.000", style:  TextStyle(
                  color: GeneralColor.darkColor,
                  fontSize: 36,
                  fontWeight: FontWeight.bold)),
            ],
          )
        ],
      ),
    );
  }
}
