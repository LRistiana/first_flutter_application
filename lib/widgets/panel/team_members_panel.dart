import 'package:first_flutter_application/model/team_members_model.dart';
// import 'package:first_flutter_application/utils/format/currency.dart';
import 'package:first_flutter_application/utils/modal/modal_utils.dart';
import 'package:first_flutter_application/utils/theme/color_theme.dart';
import 'package:first_flutter_application/widgets/utils/null_notification.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MembersPanel extends StatelessWidget {
  const MembersPanel({super.key});
  @override
  Widget build(BuildContext context) {
    final teamProvider = Provider.of<TeamProvider>(context, listen: false);
    teamProvider.fetchTeamMembers();
    return Container(
        height: 530,
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: BackgroundColor.secondaryBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        child: Consumer<TeamProvider>(
          builder: (context, teamProvider, _) {
            if (teamProvider.teamMembers.isEmpty) {
              return const Center(
                  child: NullNotifier(hintText: "No Team Members Found!"));
            }
            Map<String, List<TeamMember>> teamMemberMap = {};
            for (var teamMember in teamProvider.teamMembers) {
              String firstLetter = teamMember.nama[0].toUpperCase();
              if (!teamMemberMap.containsKey(firstLetter)) {
                teamMemberMap[firstLetter] = [];
              }
              teamMemberMap[firstLetter]!.add(teamMember);
            }

            List<String> sortedKeys = teamMemberMap.keys.toList();
            sortedKeys.sort((a, b) => a.compareTo(b));

            return ListView.builder(
              itemCount: sortedKeys.length,
              itemBuilder: (context, index) {
                List<TeamMember> teamMembers =
                    teamMemberMap[sortedKeys[index]]!;

                // final TeamMember teamMembers = teamProvider.teamMembers[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(8),
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: BackgroundColor.primaryBackgroundColor,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              sortedKeys[index],
                              style: const TextStyle(
                                color: GeneralColor.lightColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              teamMembers.length > 1
                              ? '${teamMembers.length} Members'
                              : '${teamMembers.length} Member',
                              style: const TextStyle(
                                color: BackgroundColor.iconBacgroundColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: teamMembers.map((member) {
                          return ListTile(
                            splashColor: Colors.transparent,
                            onTap: () => Navigator.of(context)
                                .pushNamed('/member', arguments: member.id),
                            onLongPress: () =>
                                ShowModal.showCustomizeModal(member, context),
                            leading: Container(
                                height: 36,
                                width: 36,
                                decoration: BoxDecoration(
                                  color: BackgroundColor.iconBacgroundColor,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: const Icon(Icons.person)),
                            title: Text(member.nama,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: GeneralColor.lightColor)),
                            subtitle: Text(
                                member.alamat),
                            // FutureBuilder<int>(
                            //   future: teamProvider.getSaldo(member.id),
                            //   builder: (context, snapshot) {
                            //     if (snapshot.connectionState ==
                            //         ConnectionState.waiting) {
                            //       return const Text('Saldo : Rp. 0');
                            //     } else if (snapshot.hasError) {
                            //       return const Text('Error');
                            //     } else {
                            //       return Text(
                            //           'Saldo : ${CurrencyFormatter.rupiah(snapshot.data!)}');
                            //     }
                            //   },
                            // ),
                            trailing: member.statusAktif == 1
                            ? const Icon(
                                Icons.circle,
                                color:  Colors.green,
                                size: 7,
                              )
                            : const Icon(
                                Icons.circle,
                                color: Colors.red,
                                size: 7,
                              ),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                );
              },
            );
          },
        ));
  }
}




// teamMembers.map((member) {
//                         return ListTile(
//                           splashColor: Colors.transparent,
//                           onTap: () => Navigator.of(context)
//                               .pushNamed('/member', arguments: teamMembers.id),
//                           onLongPress: () => ShowModal.showCustomizeModal(
//                               teamMembers, context),
//                           leading: Container(
//                               height: 36,
//                               width: 36,
//                               decoration: BoxDecoration(
//                                 color: BackgroundColor.iconBacgroundColor,
//                                 borderRadius: BorderRadius.circular(50),
//                               ),
//                               child: const Icon(Icons.person)),
//                           title: Text(teamMembers.nama,
//                               style: const TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                   color: GeneralColor.lightColor)),
//                           subtitle: FutureBuilder<int>(
//                             future: teamProvider
//                                 .getSaldo(teamProvider.teamMembers[index].id),
//                             builder: (context, snapshot) {
//                               if (snapshot.connectionState ==
//                                   ConnectionState.waiting) {
//                                 return const Text('Saldo : Rp. 0');
//                               } else if (snapshot.hasError) {
//                                 return const Text('Error');
//                               } else {
//                                 return Text(
//                                     'Saldo : ${CurrencyFormatter.rupiah(snapshot.data!)}');
//                               }
//                             },
//                           ),
//                         );
//                       }).toList(),