import 'package:first_flutter_application/model/team_members_model.dart';
import 'package:first_flutter_application/utils/format/currency.dart';
import 'package:first_flutter_application/utils/modal/modal_utils.dart';
import 'package:first_flutter_application/utils/theme/color_theme.dart';
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
            return ListView.builder(
              itemCount: teamProvider.teamMembers.length,
              itemBuilder: (context, index) {
                final TeamMember teamMembers = teamProvider.teamMembers[index];
                return ListTile(
                  splashColor: Colors.transparent,
                  onTap: () => Navigator.of(context)
                      .pushNamed('/member', arguments: teamMembers.id),
                  onLongPress: () =>
                      ShowModal.showCustomizeModal(teamMembers, context),
                  leading: Container(
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(
                        color: BackgroundColor.iconBacgroundColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Icon(Icons.person)),
                  title: Text(teamMembers.nama,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: GeneralColor.lightColor)),
                  subtitle: FutureBuilder<int>(
                      future: teamProvider.getSaldo(
                          teamProvider.teamMembers[index].id),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Text('Saldo : Rp. 0');
                        } else if (snapshot.hasError) {
                          return const Text('Error');
                        } else {
                          return Text('Saldo : ${CurrencyFormatter.rupiah(snapshot.data!)}');
                        }
                      },
                    ),
                );
              },
            );
          },
        ));
  }
}
