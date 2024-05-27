import 'package:first_flutter_application/model/tabungan_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers.dart';

class TabunganPage extends StatefulWidget {
  final int memberID;

  const TabunganPage({super.key, required this.memberID});

  @override
  State<TabunganPage> createState() => _TabunganPageState();
}

class _TabunganPageState extends State<TabunganPage> {
  @override
  void initState() {
    super.initState();
    final tabunganProvider =
        Provider.of<TabunganProvider>(context, listen: false);
    tabunganProvider.fetchTabungans(widget.memberID);

    final jenisTransaksiProvider =
        Provider.of<JenisTransaksiProvider>(context, listen: false);
    jenisTransaksiProvider.fetchTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Daftar Tabungan',
            style: TextStyle(color: Color.fromRGBO(215, 252, 112, 1))),
        iconTheme: const IconThemeData(color: Color.fromRGBO(215, 252, 112, 1)),
      ),
      backgroundColor: const Color.fromRGBO(17, 17, 17, 1),
      body: Consumer2<TabunganProvider, JenisTransaksiProvider>(
        builder: (context, tabunganProvider, jenisTransaksiProvider, child) {
          if (tabunganProvider.isLoading || jenisTransaksiProvider.isLoading) {
            return const Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(
                  Color.fromRGBO(215, 252, 112, 1)),
            ));
          }

          if (tabunganProvider.tabungans.isEmpty ||
              jenisTransaksiProvider.jenisTransaksiList.isEmpty) {
            return const Center(child: Text('Tidak ada data'));
          }

          return SingleChildScrollView(
            child: StickyHeader(
              header: const Row(
                children: [
                  Expanded(child: TableHeader(label: 'ID',left: 24,)),
                  Expanded(
                    child: TableHeader(label: 'Tanggal',left: 8,),
                  ),
                  Expanded(child: TableHeader(label: 'Transaksi',left: 8,)),
                  Expanded(child: TableHeader(label: 'Nominal'  ,left: 24,)),
                ],
              ),
              content: DataTable(
                dataRowColor: MaterialStateColor.resolveWith(
                    (states) => const Color.fromRGBO(17, 17, 17, 1)),
                headingRowHeight: 0,
                columns: const [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Tanggal')),
                  DataColumn(label: Text('Transaksi')),
                  DataColumn(label: Text('Nominal')),
                ],
                rows: tabunganProvider.tabungans.map((transaction) {
                  final jenisTransaksi =
                      jenisTransaksiProvider.jenisTransaksiList.firstWhere(
                    (jenis) => jenis.id == transaction.transaksiID,
                    orElse: () => JenisTransaksi(
                        id: 0, trxName: 'Unknown', trxMultiply: 0),
                  );

                  return DataRow(cells: [
                    DataCell(Text(transaction.id.toString(),
                        style: jenisTransaksi.trxMultiply > 0
                            ? TextStyle(color: Colors.grey[300])
                            : const TextStyle(color: Colors.red))),
                    DataCell(Text(transaction.tanggal,
                        style: jenisTransaksi.trxMultiply > 0
                            ? TextStyle(color: Colors.grey[300])
                            : const TextStyle(color: Colors.red))),
                    DataCell(
                      Text(jenisTransaksi.trxName,
                          style: jenisTransaksi.trxMultiply > 0
                              ? const TextStyle(color: Colors.green)
                              : const TextStyle(color: Colors.red)),
                    ),
                    DataCell(
                      SizedBox(
                        width: 150, // Atur lebar sesuai kebutuhan
                        child: Row(
                          children: [
                            jenisTransaksi.trxMultiply > 0
                                ? const Icon(Icons.arrow_upward,
                                    color: Colors.green)
                                : const Icon(Icons.arrow_downward,
                                    color: Colors.red),
                            Text('Rp. ${transaction.nominal.toString()}',
                                style: jenisTransaksi.trxMultiply > 0
                                    ? TextStyle(color: Colors.grey[300])
                                    : const TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),// Atur overflow handling
                    ),
                  ]);
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}

class TableHeader extends StatelessWidget {
  final String label;
  final double left;

  const TableHeader({required this.label,required this.left});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding:  EdgeInsets.only(
        top: 8,
        bottom: 8,
        left: left,
        right: 24,
      ), // Padding header
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Color.fromRGBO(215, 252, 112, 1),
        ),
      ),
    );
  }
}
