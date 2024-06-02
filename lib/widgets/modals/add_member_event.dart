import 'package:first_flutter_application/widgets/utils/input.dart';
import 'package:flutter/material.dart';
import 'package:first_flutter_application/utils/input_controller_util.dart';

class AddMemberEventModal extends StatefulWidget {
  const AddMemberEventModal(
      {super.key,
      required this.inputMemberController,
      required this.onAdd});
  final InputMemberController inputMemberController;
  final VoidCallback onAdd;

  @override
  State<AddMemberEventModal> createState() => _AddMemberEventModalState();
}

class _AddMemberEventModalState extends State<AddMemberEventModal> {
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
                "Add New Member",
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
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
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
                      },
                      child: const Text('Cancel',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold))),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        widget.onAdd();
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
