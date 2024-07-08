// import 'package:first_flutter_application/model/tabungan_model.dart';
import 'package:first_flutter_application/utils/theme/color_theme.dart';
// import 'package:first_flutter_application/widgets/utils/input.dart';
import 'package:flutter/material.dart';
import 'package:first_flutter_application/utils/input_controller_util.dart';

class EditStatusEventModal extends StatefulWidget {
  const EditStatusEventModal(
      {super.key,
      required this.inputToggleController,
      required this.onEdit,});
  
  final InputToggleController inputToggleController;
  final VoidCallback onEdit;
  
  @override
  State<EditStatusEventModal> createState() => _EditStatusEventModalState();
}

class _EditStatusEventModalState extends State<EditStatusEventModal> {
  bool _isSure = false;
  // ValueNotifier<bool> isActive = widget.inputToggleController.isActiveNotifier;

  void toggleSwitch(bool value) {
    setState(() {
      widget.inputToggleController.isActiveController.value = value;
    });
  }

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
          gradient: GradientColor.primaryGradient,
          // color: const Color.fromRGBO(215, 252, 112, 1),
        ),
        height: _isSure ? 250 : 220,
        width: 350,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Change Status",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 22.0, right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Active",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black),
                    ),
                    Switch(
                    value: widget.inputToggleController.isActiveController.value,
                    onChanged: toggleSwitch,
                    activeColor: GeneralColor.darkColor,
                    activeTrackColor: GeneralColor.secondaryColor,
                    inactiveThumbColor: GeneralColor.lightColor,
                    inactiveTrackColor: GeneralColor.secondaryColor,
                                ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Visibility(
                  visible: _isSure,
                  child: Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: const Center(
                      child: Text(
                        "Please check your data before confirm!",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
                        if (_isSure) {
                          Navigator.pop(context);
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            widget.onEdit();
                          });
                        } else {
                          setState(() {
                            _isSure = true;
                          });
                        }
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
                      child:  Text(
                        _isSure ? 'Confirm' : 'Save',
                        style: const TextStyle(
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
