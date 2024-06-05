import 'package:first_flutter_application/utils/theme/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NullNotifier extends StatelessWidget {
  const NullNotifier({super.key, required this.hintText});
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 150,
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: BackgroundColor.secondaryBackgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 30),
            SvgPicture.asset(
                  'lib/images/sad.svg',
                  semanticsLabel: 'Sad Picture',
                  height: 60,
                  width: 80,
                ),
            const SizedBox(height: 4),
            Text(
              hintText,
              style: const TextStyle(
                color: GeneralColor.lightColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

