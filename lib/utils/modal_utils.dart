import 'package:first_flutter_application/widgets/modals/delete_event.dart';
import 'package:flutter/material.dart';
import 'package:first_flutter_application/model/team_members_model.dart';
import 'package:first_flutter_application/widgets/modals/customize_modal.dart';
import 'package:provider/provider.dart';

class ModalUtils {
  

  static void showCustomizeModal(TeamMember member, BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(44),
          topRight: Radius.circular(44),
        ),
      ),
      builder: (context) {
        return CustomizeModal(member: member);
      },
    );
  }

  static void showDeleteModal(TeamMember member, BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(44),
          topRight: Radius.circular(44),
        ),
      ),
      builder: (context) {
        return DeleteEventModal(onDelete: (){
          Navigator.of(context).pop();
          final teamProvider =
                    Provider.of<TeamProvider>(context, listen: false);
          teamProvider.deleteMember(member.id);
        },);
      },
    );
  }
}
