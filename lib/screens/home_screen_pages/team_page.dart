import 'package:first_flutter_application/screens/home_screen_pages/dashboard_page.dart';
import 'package:first_flutter_application/utils/bug_tester.dart';
import 'package:first_flutter_application/utils/modal/modal_utils.dart';
import 'package:first_flutter_application/utils/theme/color_theme.dart';
import 'package:first_flutter_application/widgets/panel/team_members_panel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_flutter_application/model/team_members_model.dart';

class TeamPage extends StatefulWidget {
  const TeamPage({super.key});
  // final TeamProvider teamProvider;

  @override
  State<TeamPage> createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  @override
  void initState() {
    final teamProvider = Provider.of<TeamProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      teamProvider.fetchTeamMembers();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BugTester.test(context.toString());

    // return Consumer<TeamProvider>(
    //   builder: (context, teamProvider, child) {
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
                    "Find your member",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(height: 16),
              SearchInput(),
            ],
          ),
        ),
        const Positioned(bottom: 0, left: 0, right: 0, child: MembersPanel()),
        const AddMemberButton(),
      ],
    );
    // },
    // );
  }
}

class AddMemberButton extends StatelessWidget {
  const AddMemberButton({super.key});

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
            ShowModal.showAddMemberModal(context);
          },
        ),
      ),
    );
  }
}
