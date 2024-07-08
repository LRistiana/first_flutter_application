import 'package:first_flutter_application/utils/theme/color_theme.dart';
import 'package:flutter/material.dart';

class LogOutModal extends StatelessWidget {
  const LogOutModal({super.key, required this.onLogOut});
  final VoidCallback onLogOut;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(44),
        topRight: Radius.circular(44),
      ),
      child: Container(
        height: 200,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(gradient: GradientColor.primaryGradientRevert),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'Log Out?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              'You can always come back later to continue your saving progress!',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    minimumSize: const  Size(250,60 ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                    ),
                  ),
                  child: const Text(
                    'No',
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton(
                  onPressed:() {
                    Navigator.pop(context);
                    onLogOut();},
                  child: const  Text(
                    'Yes',
                    style: TextStyle(color: Colors.black),
                  ),
                )
                ],
            )
          ],
        ),
      ),
    ));
  }
}

