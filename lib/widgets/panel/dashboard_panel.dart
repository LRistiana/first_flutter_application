import 'package:first_flutter_application/utils/theme/color_theme.dart';
import 'package:first_flutter_application/widgets/cards/profile_card.dart';
import 'package:flutter/material.dart';

class DashboardPanel extends StatelessWidget {
  const DashboardPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 349,
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color : BackgroundColor.secondaryBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),

      ),
      child:  Column(
        children: [
           const ProfileCard(),
           const SizedBox(height: 16),
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Container(
                // color: BackgroundColor.primaryBackgroundColor,
                height: 100,
                width: 196,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: BackgroundColor.primaryBackgroundColor,
                ),
               ),
               Container(
                // color: BackgroundColor.primaryBackgroundColor,
                height: 100,
                width: 196,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: BackgroundColor.primaryBackgroundColor,
                ),
               ),
             ],
           )
        ],
      ),
    );
  }
}

