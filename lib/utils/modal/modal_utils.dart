import 'dart:math';

import 'package:dio/dio.dart';
import 'package:first_flutter_application/utils/theme/color_theme.dart';
import 'package:first_flutter_application/widgets/modals/add_member_event.dart';
import 'package:first_flutter_application/widgets/modals/add_saving_event.dart';
import 'package:first_flutter_application/widgets/modals/delete_event.dart';
import 'package:first_flutter_application/widgets/modals/delete_result.dart';
import 'package:first_flutter_application/widgets/modals/edit_member_event.dart';
import 'package:first_flutter_application/widgets/utils/announcer.dart';
import 'package:flutter/material.dart';
import 'package:first_flutter_application/model/team_members_model.dart';
import 'package:first_flutter_application/model/tabungan_model.dart';
import 'package:first_flutter_application/widgets/modals/customize_modal.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';
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
              // teamProvider.deleteMember(member.id);
              // showDeleteSuccesModal(context);
              ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: FutureBuilder(
                future: teamProvider.deleteMember(member.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return snapshot.data.toString().split("/")[0] == "success"
                        ? Row(children: [
                            const Icon(Icons.check_circle, color: Colors.green),
                            const SizedBox(width: 10),
                            Text(snapshot.data.toString().split("/")[1]),
                          ])
                        : Row(children: [
                            const Icon(Icons.error, color: Colors.red),
                            const SizedBox(width: 10),
                            Text(snapshot.data.toString()),
                          ]);
                  } else {
                    return  const Row(
                      children: [
                        SizedBox(
                          height: 15,
                          width: 15,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(GeneralColor.lightColor),
                            strokeWidth: 1,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text("Loading...")
                      ],
                    );
                  }
                },
              ),
              duration: const Duration(seconds: 2),
            ),
          );

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
          onAdd: () {
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
            final teamProvider =
                Provider.of<TeamProvider>(context, listen: false);
            // teamProvider.addMember(newMember);
            ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: FutureBuilder(
                future: teamProvider.addMember(newMember),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return snapshot.data.toString().split("/")[0] == "success"
                        ? Row(children: [
                            const Icon(Icons.check_circle, color: Colors.green),
                            const SizedBox(width: 10),
                            Text(snapshot.data.toString().split("/")[1]),
                          ])
                        : Row(children: [
                            const Icon(Icons.error, color: Colors.red),
                            const SizedBox(width: 10),
                            Text(snapshot.data.toString()),
                          ]);
                  } else {
                    return  const Row(
                      children: [
                        SizedBox(
                          height: 15,
                          width: 15,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(GeneralColor.lightColor),
                            strokeWidth: 1,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text("Loading...")
                      ],
                    );
                  }
                },
              ),
              duration: const Duration(seconds: 2),
            ),
          );
          }),
    );
  }

  static void showAddSavingModal(BuildContext context, TeamMember member,
      JenisTransaksiProvider jenisTransaksiProvider) {
    // final TeamMember member;

    inputSavingController.controllerReset();
    showDialog(
      context: context,
      builder: (context) => AddSavingEventModal(
          inputSavingController: inputSavingController,
          jenisTransaksiProvider: jenisTransaksiProvider,
          onAdd: () {
            final Tabungan newTabungan = Tabungan(
                transaksiID: inputSavingController.transactionType.value!.id,
                nominal: int.parse(inputSavingController.nominal.text));
            final savingProvider =
                Provider.of<TabunganProvider>(context, listen: false);
            // savingProvider.addTabungan(member, newTabungan);
             ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: FutureBuilder(
                future: savingProvider.addTabungan(member, newTabungan),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return snapshot.data.toString().split("/")[0] == "success"
                        ? Row(children: [
                            const Icon(Icons.check_circle, color: Colors.green),
                            const SizedBox(width: 10),
                            Text(snapshot.data.toString().split("/")[1]),
                          ])
                        : Row(children: [
                            const Icon(Icons.error, color: Colors.red),
                            const SizedBox(width: 10),
                            Text(snapshot.data.toString()),
                          ]);
                  } else {
                    return  const Row(
                      children: [
                        SizedBox(
                          height: 15,
                          width: 15,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(GeneralColor.lightColor),
                            strokeWidth: 1,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text("Loading...")
                      ],
                    );
                  }
                },
              ),
              duration: const Duration(seconds: 2),
            ),
          );
          }),
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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: FutureBuilder(
                future: teamProvider.updateMember(editedMember),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return snapshot.data.toString().split("/")[0] == "success"
                        ? Row(children: [
                            const Icon(Icons.check_circle, color: Colors.green),
                            const SizedBox(width: 10),
                            Text(snapshot.data.toString().split("/")[1]),
                          ])
                        : Row(children: [
                            const Icon(Icons.error, color: Colors.red),
                            const SizedBox(width: 10),
                            Text(snapshot.data.toString()),
                          ]);
                  } else {
                    return  const Row(
                      children: [
                        SizedBox(
                          height: 15,
                          width: 15,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(GeneralColor.lightColor),
                            strokeWidth: 1,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text("Loading...")
                      ],
                    );
                  }
                },
              ),
              duration: const Duration(seconds: 2),
            ),
          );
          // teamProvider.updateMember(editedMember);
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
