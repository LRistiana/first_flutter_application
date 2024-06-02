import 'package:first_flutter_application/widgets/modals/add_member_event.dart';
import 'package:first_flutter_application/widgets/modals/add_saving_event.dart';
import 'package:first_flutter_application/widgets/modals/delete_event.dart';
import 'package:first_flutter_application/widgets/modals/delete_result.dart';
import 'package:first_flutter_application/widgets/modals/edit_member_event.dart';
import 'package:flutter/material.dart';
import 'package:first_flutter_application/model/team_members_model.dart';
import 'package:first_flutter_application/model/tabungan_model.dart';
import 'package:first_flutter_application/widgets/modals/customize_modal.dart';
import 'package:provider/provider.dart';
import 'package:first_flutter_application/utils/input_controller_util.dart';

class ShowModal {
  static InputMemberController inputMemberController = InputMemberController();
  static InputSavingController inputSavingController = InputSavingController();

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
    inputMemberController.controllerReset();
    showDialog(
      context: context,
      builder: (context) => AddMemberEventModal(
        inputMemberController: inputMemberController,
        onAdd: (){
          final newMember = TeamMember(
            id: int.parse(inputMemberController.nomerInduk.text),
            nomorInduk: int.parse(inputMemberController.nomerInduk.text),
            nama: inputMemberController.name.text,
            alamat: inputMemberController.address.text,
            telepon: inputMemberController.telp.text,
            tanggalLahir: inputMemberController.date.value.toString(),
            imageUrl: "",
            statusAktif: 1,
          );
          final teamProvider = Provider.of<TeamProvider>(context, listen: false);
          teamProvider.addMember(newMember);
        }
      ),
    );
  }

  static void showAddSavingModal(BuildContext context, TeamMember member){
    // final TeamMember member;

    inputSavingController.controllerReset();
    showDialog(
      context: context,
      builder: (context) => AddSavingEventModal(
        inputSavingController: inputSavingController,
        onAdd: (){
          final Tabungan newTabungan = Tabungan(transaksiID: inputSavingController.transactionType.value!.id,nominal: int.parse(inputSavingController.nominal.text));
          final savingProvider = Provider.of<TabunganProvider>(context, listen: false);
          savingProvider.addTabungan(member, newTabungan);
        }
      ),
    );

  }

  static void showEditMemberModal(BuildContext context, TeamMember member) {
    inputMemberController.name.text = member.nama;
    inputMemberController.nomerInduk.text = member.nomorInduk.toString();
    inputMemberController.telp.text = member.telepon;
    inputMemberController.address.text = member.alamat;
    inputMemberController.date.value = DateTime.parse(member.tanggalLahir);
    Navigator.pop(context);

    showDialog(
      context: context,
      builder: (context) => EditMemberEventModal(
        member: member,
        inputMemberController: inputMemberController,
        onCancel: () => showCustomizeModal(member, context),
        onEdit: () {
          final editedMember = TeamMember(
            id: member.id,
            nomorInduk: int.parse(inputMemberController.nomerInduk.text),
            nama: inputMemberController.name.text,
            alamat: inputMemberController.address.text,
            telepon: inputMemberController.telp.text,
            tanggalLahir: inputMemberController.date.value.toString(),
            imageUrl: "",
            statusAktif: 1,
          );
          if (editedMember == member) {
            return;
          }
          final teamProvider =
              Provider.of<TeamProvider>(context, listen: false);
          teamProvider.updateMember(editedMember);
          // showDeleteSuccesModal(context);
        },
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
