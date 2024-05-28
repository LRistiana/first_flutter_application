import 'package:first_flutter_application/utils/modal_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:first_flutter_application/model/team_members_model.dart'; // Import the provider from the models folder
import 'package:first_flutter_application/model/tabungan_model.dart'; // Import the provider from the models folder
import 'package:first_flutter_application/widgets/modals/customize_modal.dart'; // Import the provider from the models folder

class TeamPage extends StatefulWidget {
  const TeamPage({super.key});

  @override
  State<TeamPage> createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  @override
  void initState() {
    super.initState();
    final teamProvider = Provider.of<TeamProvider>(context, listen: false);
    teamProvider.fetchTeamMembers();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TeamProvider>(
      builder: (context, teamProvider, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              teamProvider.teamMembers.isEmpty
                  ? const Center(
                      child: Text("Belum ada anggota tim",
                          style:
                              TextStyle(fontSize: 20, color: Colors.white38)),
                    )
                  : ListView.builder(
                      itemCount: teamProvider.teamMembers.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: ListTile(
                              leading:
                                  const Icon(Icons.person, color: Colors.black),
                              title: Text(
                                teamProvider.teamMembers[index].nama,
                                style: const TextStyle(color: Colors.white),
                              ),
                              subtitle: FutureBuilder<int>(
                                future: teamProvider.getSaldo(
                                    teamProvider.teamMembers[index].id),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Text('Loading...');
                                  } else if (snapshot.hasError) {
                                    return const Text('Error');
                                  } else {
                                    return Text('Saldo: Rp.${snapshot.data}');
                                  }
                                },
                              ),
                              onTap: () => 
                              ModalUtils.showCustomizeModal(
                                  teamProvider.teamMembers[index], context),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/tabungan',
                                          arguments: teamProvider
                                              .teamMembers[index].id);
                                    },
                                    icon: const Icon(Icons.history,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
              AddMemberButton(),
            ],
          ),
        );
      },
    );
  }

void _showCustomizeModal(TeamMember member, BuildContext context) {
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


  void _showMemberDetail(TeamMember member, BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Member Detail',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                _buildDetailRow('ID', member.id.toString()),
                _buildDetailRow('Nomer Induk', member.nomorInduk.toString()),
                _buildDetailRow('Nama', member.nama),
                _buildDetailRow('Alamat', member.alamat),
                _buildDetailRow('Tanggal Lahir', member.tanggalLahir),
                _buildDetailRow('Telepon', member.telepon),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AddSavingButton(
                      member: member,
                    ),
                    const SizedBox(width: 20),
                    EditMemberButton(member: member),
                    DeleteMemberButton(member: member)
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }
}

class AddMemberButton extends StatefulWidget {
  const AddMemberButton({super.key});
  @override
  State<AddMemberButton> createState() => _AddMemberButtonState();
}

class _AddMemberButtonState extends State<AddMemberButton> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController telephoneController = TextEditingController();
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      padding: const EdgeInsets.only(
          bottom: 20,
          right:
              20), // Ubah padding agar tombol tidak terlalu dekat dengan tepi layar
      child: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(215, 252, 112, 1),
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
        onPressed: () {
          _showAddMemberDialog(
              context); // Panggil fungsi untuk menampilkan dialog tambah anggota
        },
      ),
    );
  }

  void _showAddMemberDialog(BuildContext context) {
    // Implementasi dialog tambah anggota tim di sini
    final teamProvider = Provider.of<TeamProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Tambah Anggota Tim'),
          contentPadding: EdgeInsets.zero,
          content: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextInput(hint: "ID Number", textController: idController),
                  TextInput(hint: "Name", textController: nameController),
                  TextInput(hint: "Address", textController: addressController),
                  TextInput(
                      hint: "Telephone", textController: telephoneController),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Date of Birth"),
                        ElevatedButton(
                          onPressed: () async {
                            final DateTime? dateTime = await showDatePicker(
                              context: context,
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2050),
                            );
                            if (dateTime != null) {
                              setState(() {
                                // Lakukan sesuatu dengan tanggal yang dipilih, misalnya menyimpannya ke dalam variabel atau menampilkan di layar
                                print('Selected date: $dateTime');
                                selectedDate = dateTime;
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              side: BorderSide(color: Colors.black),
                            ),
                          ),
                          child: Text(selectedDate != null
                              ? selectedDate.toString()
                              : "Pick a Date"),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: const Text(
                'Batal',
                style: TextStyle(color: Colors.black),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final newMember = TeamMember(
                    id: int.parse(idController.text),
                    nomorInduk: int.parse(idController.text),
                    nama: nameController.text,
                    alamat: addressController.text,
                    telepon: telephoneController.text,
                    tanggalLahir: selectedDate.toString(),
                    imageUrl: '',
                    statusAktif: 1);
                // Simpan ke penyimpanan atau API
                // Simpan ke penyimpanan atau API, misalnya:
                teamProvider.addMember(newMember);
                Navigator.of(context).pop(); // Tutup dialog setelah selesai
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(215, 252, 112, 1),
              ),
              child: const Text(
                'Simpan',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }
}

class EditMemberButton extends StatefulWidget {
  const EditMemberButton({super.key, required this.member});
  final TeamMember member;
  @override
  State<EditMemberButton> createState() => _EditMemberButtonState();
}

class _EditMemberButtonState extends State<EditMemberButton> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController telephoneController = TextEditingController();
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      padding: const EdgeInsets.only(
          bottom: 20,
          right:
              20), // Ubah padding agar tombol tidak terlalu dekat dengan tepi layar
      child: FloatingActionButton(
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.edit, // Ubah ikon menjadi ikon edit
          color: Colors.orange,
        ),
        onPressed: () {
          _showEditMemberDialog(
              context); // Panggil fungsi untuk menampilkan dialog edit anggota
        },
      ),
    );
  }

  void _showEditMemberDialog(BuildContext context) {
    idController.text = widget.member.nomorInduk.toString();
    nameController.text = widget.member.nama;
    addressController.text = widget.member.alamat;
    telephoneController.text = widget.member.telepon;
    selectedDate = DateTime.parse(widget.member.tanggalLahir);
    // Implementasi dialog edit anggota tim di sini
    final teamProvider = Provider.of<TeamProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Anggota Tim'), // Ubah judul dialog
          contentPadding: EdgeInsets.zero,
          content: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextInput(hint: "ID Number", textController: idController),
                  TextInput(hint: "Name", textController: nameController),
                  TextInput(hint: "Address", textController: addressController),
                  TextInput(
                      hint: "Telephone", textController: telephoneController),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Date of Birth"),
                        ElevatedButton(
                          onPressed: () async {
                            final DateTime? dateTime = await showDatePicker(
                              context: context,
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2050),
                            );
                            if (dateTime != null) {
                              setState(() {
                                // Lakukan sesuatu dengan tanggal yang dipilih, misalnya menyimpannya ke dalam variabel atau menampilkan di layar
                                print('Selected date: $dateTime');
                                selectedDate = dateTime;
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              side: BorderSide(color: Colors.black),
                            ),
                          ),
                          child: Text(selectedDate != null
                              ? selectedDate.toString()
                              : "Pick a Date"),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: const Text('Batal', style: TextStyle(color: Colors.black)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(215, 252, 112, 1),
              ),
              onPressed: () {
                final newMember = TeamMember(
                    id: widget.member.id,
                    nomorInduk: int.parse(idController.text),
                    nama: nameController.text,
                    alamat: addressController.text,
                    telepon: telephoneController.text,
                    tanggalLahir: selectedDate.toString(),
                    imageUrl: '',
                    statusAktif: 1);
                // Simpan perubahan ke penyimpanan atau API
                // Simpan perubahan ke penyimpanan atau API, misalnya:
                teamProvider.updateMember(newMember);
                Navigator.of(context).pop(); // Tutup dialog setelah selesai
              },
              child: const Text('Simpan Perubahan',
                  style: TextStyle(color: Colors.black)), // Ubah teks tombol
            ),
          ],
        );
      },
    );
  }
}

class DeleteMemberButton extends StatelessWidget {
  const DeleteMemberButton({super.key, required this.member});
  final TeamMember member;

  void _showDeleteMemberDialog(BuildContext context, TeamMember member) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hapus Anggota Tim'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Apakah Anda yakin ingin menghapus anggota tim ini?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: const Text(
                'Batal',
                style: TextStyle(color: Colors.black),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final teamProvider =
                    Provider.of<TeamProvider>(context, listen: false);
                // Panggil fungsi untuk menghapus anggota tim dari penyimpanan atau API
                teamProvider.deleteMember(member.id);
                Navigator.of(context).pop(); // Tutup dialog setelah selesai
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text(
                'Hapus',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      padding: const EdgeInsets.only(
          bottom: 20,
          right:
              20), // Ubah padding agar tombol tidak terlalu dekat dengan tepi layar
      child: FloatingActionButton(
        backgroundColor: Colors.red,
        child: const Icon(
          Icons.delete, // Ubah ikon menjadi ikon edit
          color: Colors.white,
        ),
        onPressed: () {
          _showDeleteMemberDialog(context,
              member); // Panggil fungsi untuk menampilkan dialog edit anggota
        },
      ),
    );
  }
}

class AddSavingButton extends StatefulWidget {
  AddSavingButton({super.key, required this.member});
  final TeamMember member;

  @override
  State<AddSavingButton> createState() => _AddSavingButtonState();
}

class _AddSavingButtonState extends State<AddSavingButton> {
  JenisTransaksi? selectedTypeTransaction;

  final TextEditingController nominalController = TextEditingController();

  void _showAddSavingDialog(BuildContext context) {
    final tabungan = Provider.of<TabunganProvider>(context, listen: false);
    final jenisTransaksiProvider =
        Provider.of<JenisTransaksiProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Tambah Tabungan'),
          contentPadding: EdgeInsets.zero,
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Consumer<JenisTransaksiProvider>(
                  builder: (context, provider, child) {
                    if (provider.isLoading) {
                      return const CircularProgressIndicator();
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonFormField<JenisTransaksi>(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Pilih Jenis Transaksi",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 154, 210, 2),
                                  width: 2),
                            ),
                          ),
                          value: selectedTypeTransaction,
                          onChanged: (JenisTransaksi? newValue) {
                            setState(() {
                              selectedTypeTransaction = newValue;
                            });
                          },
                          items: provider.jenisTransaksiList
                              .map<DropdownMenuItem<JenisTransaksi>>(
                                  (JenisTransaksi value) {
                            return DropdownMenuItem<JenisTransaksi>(
                              value: value,
                              child: Text(value.trxName),
                            );
                          }).toList(),
                        ),
                      );
                    }
                  },
                ),
                TextInput(hint: "Nominal", textController: nominalController)
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: const Text(
                'Batal',
                style: TextStyle(color: Colors.black),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (selectedTypeTransaction != null) {
                  final newSaving = Tabungan(
                    transaksiID: selectedTypeTransaction!.id,
                    nominal: int.parse(nominalController.text),
                  );

                  tabungan.addTabungan(widget.member, newSaving);
                  Navigator.of(context).pop(); // Tutup dialog setelah selesai
                } else {
                  // Handle case where no transaction type is selected
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Please select a transaction type')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(215, 252, 112, 1),
              ),
              child:
                  const Text('Simpan', style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    final jenisTransaksiProvider =
        Provider.of<JenisTransaksiProvider>(context, listen: false);
    jenisTransaksiProvider.fetchTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      padding: const EdgeInsets.only(
        bottom: 20,
        right: 20,
      ), // Ubah padding agar tombol tidak terlalu dekat dengan tepi layar
      child: SizedBox(
        width: 150, // Atur lebar tombol
        height: 50, // Atur tinggi tombol
        child: FloatingActionButton(
          backgroundColor: const Color.fromRGBO(215, 252, 112, 1),
          onPressed: () {
            _showAddSavingDialog(context);
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                Icons.add,
                color: Colors.black,
              ),
              Text(
                "Add Savings",
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextInput extends StatelessWidget {
  const TextInput({
    super.key,
    required this.hint,
    required this.textController,
  });

  final String hint;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: textController,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: hint,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromARGB(255, 154, 210, 2), width: 2),
          ),
        ),
      ),
    );
  }
}

// class AddSavingsButton extends StatefulWidget {
//   final TeamMember member;

//   const AddSavingsButton({super.key, required this.member});
//   @override
//   State<AddSavingsButton> createState() => _AddSavingsButtonState();
// }

// class _AddSavingsButtonState extends State<AddSavingsButton> {
//   final TextEditingController nominalController = TextEditingController();

//   void _showAddSavingsDialog(BuildContext context) {
//     final tabungan = Provider.of<TabunganProvider>(context, listen: false);
//     // Implementasi dialog tambah anggota tim di sini
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Tambah Anggota Tim'),
//           contentPadding: EdgeInsets.zero,
//           content: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   TextInput(hint: "Nominal", textController: nominalController),
//                 ],
//               ),
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Tutup dialog
//               },
//               child: const Text('Batal'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 final newSaving = Tabungan(
//                   transaksiID: 4,
//                   nominal: int.parse(nominalController.text),
//                 );
//                 // Simpan ke penyimpanan atau API
//                 // Simpan ke penyimpanan atau API, misalnya:
//                 tabungan.addTabungan(widget.member, newSaving);
//                 Navigator.of(context).pop(); // Tutup dialog setelah selesai
//               },
//               child: const Text('Simpan'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       alignment: Alignment.bottomRight,
//       padding: const EdgeInsets.only(
//         bottom: 20,
//         right: 20,
//       ), // Ubah padding agar tombol tidak terlalu dekat dengan tepi layar
//       child: SizedBox(
//         width: 150, // Atur lebar tombol
//         height: 50, // Atur tinggi tombol
//         child: FloatingActionButton(
//           backgroundColor: const Color.fromRGBO(215, 252, 112, 1),
//           onPressed: () {
//             _showAddSavingsDialog(context);
//           },
//           child: const Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Icon(
//                 Icons.add,
//                 color: Colors.black,
//               ),
//               Text(
//                 "Add Savings",
//                 style: TextStyle(color: Colors.black),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
