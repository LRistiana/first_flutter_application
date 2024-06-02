import 'package:first_flutter_application/model/tabungan_model.dart';
import 'package:flutter/material.dart';

class InputMemberController {
  late TextEditingController nameController = TextEditingController();
  late TextEditingController nomerIndukController = TextEditingController();
  late TextEditingController telpController = TextEditingController();
  late TextEditingController addressController = TextEditingController();
  late ValueNotifier<DateTime?> dateNotifier = ValueNotifier<DateTime?>(null);

  TextEditingController get name => nameController;
  TextEditingController get nomerInduk => nomerIndukController;
  TextEditingController get telp => telpController;
  TextEditingController get address => addressController;
  ValueNotifier<DateTime?> get date => dateNotifier;

  void dispose() {
    nameController.dispose();
    nomerIndukController.dispose();
    telpController.dispose();
    addressController.dispose();
    dateNotifier.dispose();
  }

  void controllerReset() {
    nameController.clear();
    nomerIndukController.clear();
    telpController.clear();
    addressController.clear();
    dateNotifier.value = null;
  }

  InputMemberController();
}

class InputSavingController{
  late TextEditingController nominalController = TextEditingController();
  JenisTransaksi? selectedJenisTransaksi;


  TextEditingController get nominal => nominalController;
  JenisTransaksi get jenisTransaksi => selectedJenisTransaksi!; 

  void dispose() {
    nominalController.dispose();
  }

  void controllerReset() {
    nominalController.clear();
    selectedJenisTransaksi = null;
  }

  InputSavingController();
}
