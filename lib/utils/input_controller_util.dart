import 'package:first_flutter_application/model/tabungan_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
  late ValueNotifier<JenisTransaksi?> transactionTypeController = ValueNotifier<JenisTransaksi?>(null);


  TextEditingController get nominal => nominalController;
  ValueNotifier<JenisTransaksi?> get transactionType => transactionTypeController;

  void dispose() {
    nominalController.dispose();
  }

  void controllerReset() {
    nominalController.clear();
    transactionTypeController.value = null;
  }

  InputSavingController();
}

class InputInterestController{
  late TextEditingController rate = TextEditingController();
  late ValueNotifier<bool> isActiveNotifier = ValueNotifier<bool>(false);
  // bool isActive = false;

  TextEditingController get rateController => rate;
  ValueNotifier<bool> get isActiveController => isActiveNotifier;

  void dispose() {
    rate.dispose();
  }

  void controllerReset() {
    rate.clear();
    isActiveNotifier.value = false;
  }

  InputInterestController();
}

class InputToggleController{
  late ValueNotifier<bool> isActiveNotifier = ValueNotifier<bool>(false);

  ValueNotifier<bool> get isActiveController => isActiveNotifier;
  set isActiveController(ValueNotifier<bool> value) => isActiveNotifier = value;

  void dispose() {
    isActiveNotifier.dispose();
  }

  void controllerReset() {
    isActiveNotifier.value = false;
  }

  InputToggleController();
}