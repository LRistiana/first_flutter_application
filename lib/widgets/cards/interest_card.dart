import 'package:first_flutter_application/model/interest_model.dart';
import 'package:first_flutter_application/utils/theme/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActiveInterstCard extends StatelessWidget {
  const ActiveInterstCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 165,
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: GradientColor.primaryGradient,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const Text("Current Interest Rate",
              style: TextStyle(
                fontSize: 16, 
                fontWeight: FontWeight.bold,
                color: GeneralColor.darkColor)),
            Consumer<InterestProvider>(builder: (context, interestProvider,_){
              return Text(interestProvider.activeInterest?.percent == null 
              ? "0 %"
              : "${interestProvider.activeInterest!.percent} %",
              style: const TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.bold,
                color: GeneralColor.darkColor
              ));
            })
        ],
      ),
    );
  }
}
