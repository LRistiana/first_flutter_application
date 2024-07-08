import 'package:first_flutter_application/model/tabungan_model.dart';
import 'package:first_flutter_application/utils/theme/color_theme.dart';
import 'package:first_flutter_application/widgets/utils/input.dart';
import 'package:flutter/material.dart';
import 'package:first_flutter_application/utils/input_controller_util.dart';

class AddSavingEventModal extends StatefulWidget {
  const AddSavingEventModal(
      {super.key,
      required this.inputSavingController,
      required this.onAdd,
      required this.jenisTransaksiProvider});
  final InputSavingController inputSavingController;
  final JenisTransaksiProvider jenisTransaksiProvider;
  final VoidCallback onAdd;

  @override
  State<AddSavingEventModal> createState() => _AddSavingEventModalState();
}

class _AddSavingEventModalState extends State<AddSavingEventModal> {
  bool _isSure = false;

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
        height: _isSure ? 330 : 300,
        width: 350,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Add New saving",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 20,
              ),
              TransactionType(
                  selectedTypeTransaction:
                      widget.inputSavingController.transactionType,
                  jenisTransaksiProvider: widget.jenisTransaksiProvider),
              TextInput(
                  hintText: "Nominal",
                  controller: widget.inputSavingController.nominal),
              Visibility(
                  visible: _isSure,
                  child: Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: const Center(
                      child: Text(
                        "Please check your data before do transaction!",
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
                            widget.onAdd();
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
