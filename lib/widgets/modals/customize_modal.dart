import 'package:first_flutter_application/utils/modal_utils.dart';
import 'package:flutter/material.dart';
import 'package:first_flutter_application/model/team_members_model.dart'; 

class CustomizeModal extends StatelessWidget {
  const CustomizeModal({super.key, required this.member});
  final TeamMember member;

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
              'Customize Member?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              'You can Edit or Delete your member data',
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
                IconButton(
                  onPressed: () {
                    ModalUtils.showDeleteModal(member, context);
                  },
                  icon: const Icon(Icons.delete, color: Colors.black),
                ),
                ElevatedButton(
                  onPressed: () {ModalUtils.showEditMemberModal(context,member);},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    minimumSize:
                        const Size(250, 60), // Width unconstrained, height 40
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8), // Space between icon and text
                      Text(
                        'Edit',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
