import 'package:first_flutter_application/widgets/modals/add_member_event.dart';
import 'package:first_flutter_application/widgets/modals/delete_event.dart';
import 'package:first_flutter_application/widgets/modals/delete_result.dart';
import 'package:first_flutter_application/widgets/modals/edit_member_event.dart';
import 'package:flutter/material.dart';
import 'package:first_flutter_application/model/team_members_model.dart';
import 'package:first_flutter_application/widgets/modals/customize_modal.dart';
import 'package:provider/provider.dart';
import 'package:first_flutter_application/utils/input_controller_util.dart';

class ModalUtils {
  static InputController inputController = InputController();

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
        return DeleteEventModal(
          onDelete: () {
            Navigator.of(context).pop();
            final teamProvider =
                Provider.of<TeamProvider>(context, listen: false);
            try {
              teamProvider.deleteMember(member.id);
              showDeleteSuccesModal(context);
            } catch (e) {}
          },
        );
      },
    );
  }

  static void showAddMemberModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AddMemberEventModal(),
    );
  }

  static void showEditMemberModal(BuildContext context, TeamMember member) {
    inputController.name.text = member.nama;
    inputController.nomerInduk.text = member.nomorInduk.toString();
    inputController.telp.text = member.telepon;
    inputController.address.text = member.alamat;
    inputController.date.value = DateTime.parse(member.tanggalLahir);
    Navigator.pop(context);

    showDialog(
      context: context,
      builder: (context) => EditMemberEventModal(
        member: member,
        inputController: inputController,
        onCancel: () => showCustomizeModal(member, context),
        onEdit: () {
          final editedMember = TeamMember(
            id: member.id,
            nomorInduk: int.parse(inputController.nomerInduk.text),
            nama: inputController.name.text,
            alamat: inputController.address.text,
            telepon: inputController.telp.text,
            tanggalLahir: inputController.date.value.toString(),
            imageUrl: "",
            statusAktif: 1,
          );
          if (editedMember == member) {
            return;
          }
          final teamProvider = Provider.of<TeamProvider>(context, listen: false);
          teamProvider.updateMember(editedMember);
          showDeleteSuccesModal(context);},
      ),
    );
  }

  static void showDeleteSuccesModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const DeleteSuccess(),
    );
  }
}
