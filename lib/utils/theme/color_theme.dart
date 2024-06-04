import "package:flutter/material.dart";

class GeneralColor{
  static const Color primaryColor = Color.fromRGBO(215, 252, 112, 1);
  static const Color darkColor = Colors.black;
  static const Color lightColor = Colors.white;
}
class BackgroundColor{
  static const Color primaryBackgroundColor = Color.fromRGBO(17, 17, 17, 1);
  static const Color secondaryBackgroundColor = Colors.black;
}

class GradientColor{
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color.fromRGBO(237, 209, 199, 1),Color.fromRGBO(176, 193, 216, 1)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}


class TextColor{
  static const Color lightTextColor = Colors.white;
  static const Color darkTextColor = Colors.black;
}