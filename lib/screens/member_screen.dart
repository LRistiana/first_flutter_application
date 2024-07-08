import "package:first_flutter_application/model/tabungan_model.dart";
import "package:first_flutter_application/model/team_members_model.dart";
import "package:first_flutter_application/utils/bug_tester.dart";
import "package:first_flutter_application/utils/modal/modal_utils.dart";
import "package:first_flutter_application/utils/theme/color_theme.dart";
import "package:first_flutter_application/widgets/cards/member_card.dart";
import "package:first_flutter_application/widgets/cards/statistic_card.dart";
import "package:first_flutter_application/widgets/panel/transactions_history.dart";
import 'package:provider/provider.dart';
import "package:flutter/material.dart";

class MemberScreen extends StatefulWidget {
  MemberScreen({super.key, required this.memberID});
  final int memberID;

  @override
  State<MemberScreen> createState() => _MemberScreenState();
}

class _MemberScreenState extends State<MemberScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    final teamProvider = Provider.of<TeamProvider>(context, listen: false);
    final tabunganProvider =
        Provider.of<TabunganProvider>(context, listen: false);
    final jenisTransaksiProvider =
        Provider.of<JenisTransaksiProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      tabunganProvider.clearCache();
      jenisTransaksiProvider.clearCache();

      tabunganProvider.fetchTabungans(widget.memberID);
      jenisTransaksiProvider.fetchTransactions();
      teamProvider.fetchMember(widget.memberID);
    });
    super.initState();
  }

  // @override
  @override
  Widget build(BuildContext context) {
    BugTester.test(context.toString());
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: GeneralColor.lightColor),
          surfaceTintColor: Colors.transparent),
      backgroundColor: BackgroundColor.primaryBackgroundColor,
      body: Consumer3<TeamProvider, TabunganProvider, JenisTransaksiProvider>(
        builder:
            (context, teamValue, tabunganValue, jenisTransaksiValue, child) {
              // teamValue.fetchMember(widget.memberID);
          return Column(
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
                                  teamValue.member.id == 0
                                      ? "Member Name"
                                      : teamValue.member.nama,
                                  style: const TextStyle(
                                      color: GeneralColor.lightColor),
                                )
                              ],
                            )),
                        OutlinedButton(
                            onPressed: () => {
                              ShowModal.showEditStatusModal(
                                  context, teamValue.member)
                            },
                            style: ButtonStyle(
                              side: MaterialStateProperty.all( BorderSide(
                                  color: teamValue.member.statusAktif == 0
                                      ? Colors.red
                                      : GeneralColor.primaryColor)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              )),
                              overlayColor: MaterialStateProperty.all(
                                  teamValue.member.statusAktif == 0
                                      ? Colors.red.withOpacity(0.1)
                                      : GeneralColor.primaryColor.withOpacity(0.1)),
                            ),
                            child: Text(
                              teamValue.member.statusAktif == 0
                                  ? "Deactivate"
                                  : "Activate",
                              style:
                                  TextStyle(color: teamValue.member.statusAktif == 0
                                      ? Colors.red
                                      : GeneralColor.primaryColor),
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
                              getSaldo: () => teamValue.getSaldo(
                                  teamValue.member.id),
                              member: teamValue.member,
                              jenisTransaksiProvider: jenisTransaksiValue,
                            ),
                            const SizedBox(width: 16),
                            teamValue.member.id == 0
                                ? const SizedBox.shrink()
                                : StatisticCard(
                                    member: teamValue.member,
                                  ),
                          ],
                        )),
                  ],
                ),
              ),
              const Text("Trasactions History",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 4,
              ),
              TransactionsHistory(
                tabunganProvider: tabunganValue,
                jenisTransaksiProvider: jenisTransaksiValue,
              ),
            ],
          );
        },
      ),
    );
  }
}
