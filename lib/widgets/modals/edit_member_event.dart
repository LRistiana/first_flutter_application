import 'package:first_flutter_application/model/team_members_model.dart';
import 'package:first_flutter_application/widgets/utils/input.dart';
import 'package:flutter/material.dart';
import 'package:first_flutter_application/utils/input_controller_util.dart';

class EditMemberEventModal extends StatefulWidget {
  const EditMemberEventModal(
      {super.key,
      required this.member,
      required this.inputMemberController,
      required this.onCancel,
      required this.onEdit});
  final TeamMember member;
  final InputMemberController inputMemberController;
  final VoidCallback onCancel;
  final VoidCallback onEdit;

  @override
  State<EditMemberEventModal> createState() => _EditMemberEventModalState();
}

class _EditMemberEventModalState extends State<EditMemberEventModal> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(36),
      ),
      insetPadding: EdgeInsets.zero,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(36),
          color: const Color.fromRGBO(215, 252, 112, 1),
        ),
        height: 550,
        width: 350,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Edit Member",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 20,
              ),
              TextInput(
                  hintText: 'Nomer Induk',
                  controller: widget.inputMemberController.nomerInduk),
              TextInput(
                  hintText: 'Name', controller: widget.inputMemberController.name),
              TextInput(
                  hintText: 'Address',
                  controller: widget.inputMemberController.address),
              TextInput(
                  hintText: 'Telp', controller: widget.inputMemberController.telp),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black, // Color of the underline
                        width: 1.0, // Thickness of the underline
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Date of Birth',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          )),
                      DatePickerWidget(
                          dateNotifer: widget.inputMemberController.date),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        widget.onCancel();
                      },
                      child: const Text('Cancel',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold))),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        widget.onEdit();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(
                            200, 60), // Width unconstrained, height 40
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                        ),
                      ),
                      child: const Text(
                        'Save',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
