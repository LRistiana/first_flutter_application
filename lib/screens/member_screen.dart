import "package:first_flutter_application/model/team_members_model.dart";
import "package:first_flutter_application/utils/theme/color_theme.dart";
import "package:first_flutter_application/widgets/cards/member_card.dart";
import "package:first_flutter_application/widgets/cards/statistic_card.dart";
import "package:first_flutter_application/widgets/panel/transactions_history.dart";
import 'package:provider/provider.dart';
import "package:flutter/material.dart";

class MemberScreen extends StatefulWidget {
  const MemberScreen({super.key, required this.memberID});
  final int memberID;

  @override
  State<MemberScreen> createState() => _MemberScreenState();
}

class _MemberScreenState extends State<MemberScreen> {
  final ScrollController _scrollController = ScrollController();
  // @override
  // void initState() {
  //   super.initState();
  //   final teamProvider = Provider.of<TeamProvider>(context, listen: false);
  //   teamProvider.fetchMember(widget.memberID);
  // }

  @override
  Widget build(BuildContext context) {
    final teamProvider = Provider.of<TeamProvider>(context, listen: false);
    teamProvider.fetchMember(widget.memberID);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: GeneralColor.lightColor),
      ),
      backgroundColor: BackgroundColor.primaryBackgroundColor,
      body: Consumer<TeamProvider>(
        builder: (context, value, child) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              _scrollController.animateTo(
                                _scrollController.position.maxScrollExtent,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                              // Navigator.pop(context);
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
                                    color:
                                        GeneralColor.darkColor.withOpacity(0.4),
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
                                Text(
                                  value.member.id == 0
                                      ? "Member Name"
                                      : value.member.nama,
                                  style: const TextStyle(
                                      color: GeneralColor.lightColor),
                                )
                              ],
                            )),
                        OutlinedButton(
                            onPressed: () => {},
                            style: ButtonStyle(
                              side: MaterialStateProperty.all(const BorderSide(
                                  color: GeneralColor.primaryColor)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              )),
                              overlayColor: MaterialStateProperty.all(
                                  GeneralColor.primaryColor.withOpacity(0.1)),
                            ),
                            child: const Text(
                              "Active",
                              style:
                                  TextStyle(color: GeneralColor.primaryColor),
                            ))
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    SingleChildScrollView(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            MemberCard(
                                getSaldo: () =>
                                    value.getSaldo(value.member.id)),
                            const SizedBox(width: 16),
                            const StatisticCard()
                          ],
                        )),
                  ],
                ),
              ),
              const TransactionsHistory(),
            ],
          );
        },
      ),
    );
  }
}
