import 'package:first_flutter_application/model/interest_model.dart';
import 'package:first_flutter_application/utils/gradient_text.dart';
import 'package:first_flutter_application/utils/theme/color_theme.dart';
import 'package:first_flutter_application/widgets/utils/null_notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class InterestPanel extends StatefulWidget {
  const InterestPanel({super.key});

  @override
  State<InterestPanel> createState() => _InterestPanelState();
}

class _InterestPanelState extends State<InterestPanel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      height: 420,
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: GeneralColor.darkColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Column(
        children: [
          const GradientText(
            "Interest Rate List",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Consumer<InterestProvider>(
              builder: (context, interestProvider, child) {
                interestProvider.interests.sort((a, b) => b.id.compareTo(a.id));
                // interestProvider.interests.sort((a, b) => b.isActive.compareTo(a.isActive));
                if (interestProvider.interests.isEmpty) {
                  return const NullNotifier(hintText: "No Interest Rate Found");
                }
                return GridView.count(
                    crossAxisCount: 4,
                    children: List.generate(
                        interestProvider.interests.length,
                        (index) => Center(
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: BackgroundColor.primaryBackgroundColor,
                                  border: Border.all(
                                    color: interestProvider.interests[index].isActive == 1
                                        ? GeneralColor.lightColor
                                        : GeneralColor.darkColor,
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${interestProvider.interests[index].percent} %",
                                      style: const TextStyle(
                                        color: GeneralColor.lightColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )));
              },
            ),
          )
        ],
      ),
    );
  }
}

