// import 'dart:ffi';

import 'package:first_flutter_application/utils/theme/color_theme.dart';
import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({super.key, required this.message});
  final String message;
  // final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
  padding: const EdgeInsets.all(10),
  margin: const EdgeInsets.all(10),
  width: double.infinity,
  decoration: BoxDecoration(
    color: GeneralColor.lightColor,
    borderRadius: BorderRadius.circular(10),

  ),
  child:  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Row(
        children: [
          Icon(Icons.error, color: Colors.red, size: 18),
          SizedBox(width: 5),
          Text(
            "Error",
            style: TextStyle(color: GeneralColor.darkColor , fontWeight: FontWeight.bold),
          ),
        ],
      ),
      const SizedBox(height: 10),
      Row(
        children: [
          const SizedBox(width: 23),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: GeneralColor.darkColor),
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ),
    ],
  ),
);

  }
}