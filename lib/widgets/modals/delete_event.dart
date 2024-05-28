// import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:first_flutter_application/model/team_members_model.dart';

class DeleteEventModal extends StatelessWidget {
  const DeleteEventModal({super.key, required this.onDelete});
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(44),
        topRight: Radius.circular(44),
      ),
      child: Container(
        height: 200,
        padding: const EdgeInsets.all(20),
        color: const Color.fromRGBO(215, 252, 112, 1),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'Delete Member?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              'You Can’t Get Back This Data',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    minimumSize: const  Size(250,60 ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                    ),
                  ),
                  child: const Text(
                    'No',
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton(
                  onPressed:() {
                    Navigator.pop(context);
                    onDelete();},
                  child: const  Text(
                    'Yes',
                    style: TextStyle(color: Colors.black),
                  ),
                )
                ],
            )
          ],
        ),
      ),
    ));
  }
}

