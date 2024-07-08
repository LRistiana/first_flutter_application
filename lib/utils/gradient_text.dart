import "package:first_flutter_application/utils/theme/color_theme.dart";
import "package:flutter/material.dart";



class GradientText extends StatelessWidget {
  final String text;
  final TextStyle style;

  const GradientText(
    this.text, {
    super.key,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return GradientColor.primaryGradientRevert.createShader(bounds);
      },
      child: Text(
        text,
        style: style.copyWith(
            color: Colors.white), // Optional: You can adjust the text color
      ),
    );
  }
}
