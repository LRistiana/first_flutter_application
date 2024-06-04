import 'package:first_flutter_application/model/tabungan_model.dart';
import 'package:first_flutter_application/utils/format/month.dart';
import 'package:first_flutter_application/utils/theme/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TextInput extends StatefulWidget {
  const TextInput(
      {super.key, required this.hintText, required this.controller});
  final String hintText;
  final TextEditingController controller;

  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          _isFocused = hasFocus;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(8.0),
        width: _isFocused ? 300.0 : 280.0, // Change these values as needed
        child: TextField(
          controller: widget.controller,
          decoration: InputDecoration(
            labelText: widget.hintText,
            labelStyle: TextStyle(
              color: _isFocused
                  ? Colors.grey[600]
                  : Colors.black, // Change color based on focus
            ),
            border: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1.0,
              ),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 3.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DatePickerWidget extends StatefulWidget {
  const DatePickerWidget({super.key, required this.dateNotifer});
  final ValueNotifier<DateTime?> dateNotifer;

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.dateNotifer.value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.black, // Header background color
              onPrimary: Color.fromRGBO(215, 252, 112, 1), // Header text color
              surface: Colors.white, // Calendar background color
              onSurface: Colors.black, // Calendar text color
            ),
            dialogBackgroundColor:
                Colors.white, // Background color of the dialog
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != widget.dateNotifer.value) {
      setState(() {
        widget.dateNotifer.value = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextButton(
          onPressed: () => _selectDate(context),
          child: Text(
            widget.dateNotifer.value == null
                ? 'Select date'
                : MonthFormatter.formatDateMonthYear(widget.dateNotifer.value!.toLocal().toString().split(' ')[0]),
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}

class TransactionType extends StatefulWidget {
  const TransactionType({super.key, required this.selectedTypeTransaction});
  final ValueNotifier<JenisTransaksi?> selectedTypeTransaction;

  @override
  State<TransactionType> createState() => _TransactionTypeState();
}

class _TransactionTypeState extends State<TransactionType> {
  bool _isFocused = false;
  @override
  void initState() {
    super.initState();
    // Panggil fetchTransactions di dalam initState
    final jenisTransaksiProvider =
        Provider.of<JenisTransaksiProvider>(context, listen: false);
    jenisTransaksiProvider.fetchTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<JenisTransaksiProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return Container(
            padding: const EdgeInsets.all(8.0),
            width: 280.0,
            child: const LinearProgressIndicator(
              backgroundColor: GeneralColor.darkColor,
              color: GeneralColor.lightColor,
              minHeight: 1,
            ),
          );
        } else {
          return Focus(
            onFocusChange: (hasFocus) {
              setState(() {
                _isFocused = hasFocus;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(8.0),
              width: _isFocused ? 300.0 : 280.0,
              child: DropdownButtonFormField<JenisTransaksi>(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Pilih Jenis Transaksi",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: GeneralColor.darkColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: GeneralColor.darkColor, width: 2),
                    ),
                  ),
                  value: widget.selectedTypeTransaction.value,
                  onChanged: (JenisTransaksi? newValue) {
                    widget.selectedTypeTransaction.value = newValue;
                  },
                  dropdownColor: GeneralColor.darkColor,
                  items: provider.jenisTransaksiList
                      .map<DropdownMenuItem<JenisTransaksi>>(
                          (JenisTransaksi value) {
                    return DropdownMenuItem<JenisTransaksi>(
                      value: value,
                      child: Text(
                        value.trxName,
                        style: const TextStyle(color: GeneralColor.lightColor),
                      ),
                    );
                  }).toList(), // Set the dropdown background color
                  selectedItemBuilder: (BuildContext context) {
                    return provider.jenisTransaksiList
                        .map<Widget>((JenisTransaksi item) {
                      return Text(
                        item.trxName,
                        style: const TextStyle(
                          color: GeneralColor.darkColor,
                        ),
                      );
                    }).toList();
                  }),
            ),
          );
        }
      },
    );
  }
}
