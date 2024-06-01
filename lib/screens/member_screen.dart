import "package:first_flutter_application/utils/theme/color_theme.dart";
import "package:flutter/material.dart";

class MemberScreen extends StatefulWidget {
  const MemberScreen({super.key});

  @override
  State<MemberScreen> createState() => _MemberScreenState();
}

class _MemberScreenState extends State<MemberScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BackgroundColor.primaryBackgroundColor,
        iconTheme: const IconThemeData(color: GeneralColor.lightColor),
      ),
      backgroundColor: BackgroundColor.primaryBackgroundColor,
      body: Container(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          GeneralColor.primaryColor.withOpacity(0.0)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: GeneralColor.darkColor.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Icon(
                            Icons.person,
                            color: GeneralColor.lightColor,
                          ),
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        const Text(
                          "Member",
                          style:
                              TextStyle(color: GeneralColor.lightColor),
                        )
                      ],
                    )),
                OutlinedButton(
                    onPressed: () => {},
                    style: ButtonStyle(
                      side: MaterialStateProperty.all(
                          const BorderSide(color: GeneralColor.primaryColor)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      )),
                      overlayColor: MaterialStateProperty.all(
                          GeneralColor.primaryColor.withOpacity(0.1)),
                    ),
                    child: const Text(
                      "Active",
                      style: TextStyle(color: GeneralColor.primaryColor),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
