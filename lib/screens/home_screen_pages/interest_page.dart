import "package:first_flutter_application/model/interest_model.dart";
import "package:first_flutter_application/utils/gradient_text.dart";
import "package:first_flutter_application/utils/modal/modal_utils.dart";
import "package:first_flutter_application/utils/theme/color_theme.dart";
import "package:first_flutter_application/widgets/cards/interest_card.dart";
import "package:first_flutter_application/widgets/panel/interest_panel.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";



class InterestScreen extends StatefulWidget {
  const InterestScreen({super.key});

  @override
  State<InterestScreen> createState() => InterestScreenState();
}

class InterestScreenState extends State<InterestScreen> {
  @override
  void initState() {
    final interestProvider = Provider.of<InterestProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      interestProvider.getInterests();
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          child: const Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GradientText(
                    "Interest Rate",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(height: 16),
              ActiveInterstCard(),
              SizedBox(height: 16),
              // InterestPanel()
              
            ],
          ),
        ),
        const Positioned(bottom: 0, left: 0, right: 0, child: InterestPanel()),
        const AddInterestButton(),
      ],
    );
  }
}



class AddInterestButton extends StatelessWidget {
  const AddInterestButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      padding: const EdgeInsets.only(bottom: 20, right: 20),
      child: Container(
        decoration: BoxDecoration(
          gradient: GradientColor.primaryGradient,
          borderRadius: BorderRadius.circular(50),
        ),
        child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          shape: const CircleBorder(),
          elevation: 0,
          child: const Icon(
            Icons.add,
            color: Colors.black,
          ),
          onPressed: () {
            ShowModal.showAddInterestModal(context);
          },
        ),
      ),
    );
  }
}