import 'package:first_flutter_application/model/tabungan_model.dart';
import 'package:first_flutter_application/utils/format/currency.dart';
import 'package:first_flutter_application/utils/theme/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:sliding_up_panel/sliding_up_panel.dart';

class TransactionsHistory extends StatefulWidget {
  const TransactionsHistory({super.key, required this.memberID});
  final int memberID;

  @override
  State<TransactionsHistory> createState() => _TransactionsHistoryState();
}

class _TransactionsHistoryState extends State<TransactionsHistory> {
  @override
  Widget build(BuildContext context) {
    final tabunganProvider =
        Provider.of<TabunganProvider>(context, listen: false);
    final jenisTransaksiProvider =
        Provider.of<JenisTransaksiProvider>(context, listen: false);

    tabunganProvider.fetchTabungans(widget.memberID);
    jenisTransaksiProvider.fetchTransactions();

    return DraggableScrollableSheet(
      initialChildSize: 0.55,
      minChildSize: 0.5,
      maxChildSize: 1.0,
      builder: (BuildContext context, ScrollController scrollController) {
        return Consumer2<TabunganProvider, JenisTransaksiProvider>(builder:
            (context, tabunganProvider, jenisTransaksiProvider, child) {

              tabunganProvider.tabungans.sort((a, b) => b.tanggal.compareTo(a.tanggal));
          return Container(
            decoration: const BoxDecoration(
              color: GeneralColor.darkColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
            ),
            child: ListView.builder(
              controller: scrollController,
              itemCount: tabunganProvider.tabungans.length,
              itemBuilder: (BuildContext context, int index) {
                final jenisTransaksi =
                    jenisTransaksiProvider.jenisTransaksiList.firstWhere(
                  (jenis) =>
                      jenis.id == tabunganProvider.tabungans[index].transaksiID,
                  orElse: () =>
                      JenisTransaksi(id: 0, trxName: 'Unknown', trxMultiply: 0),
                );
                return ListTile(
                    leading: Container(
                      decoration :BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: jenisTransaksi.trxMultiply > 0
                          ? const Icon(Icons.arrow_upward, color: Colors.green)
                          : const Icon(Icons.arrow_downward, color: Colors.red
                    )),
                    title: Text(
                      jenisTransaksi.trxName,
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      tabunganProvider.tabungans[index].tanggal
                          .toString()
                          .split(' ')[0],
                      style: const TextStyle(color: Colors.white),
                    ),
                    trailing: Text(
                      CurrencyFormatter.rupiah(
                          tabunganProvider.tabungans[index].nominal),
                      style: const TextStyle(color: Colors.white),
                    ));
              },
            ),
          );
        });
      },
    );
  }
}



// class TransactionsHistory extends StatelessWidget {
//   const TransactionsHistory({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SlidingUpPanel(
//         panelBuilder: (ScrollController sc) => _scrollingList(sc),
//         body: Center(
//           child: Text('This is the widget behind the sliding panel'),
//         ),
//       ),
//     );
//   }

//   Widget _scrollingList(ScrollController sc) {
//     return ListView.builder(
//       controller: sc,
//       itemCount: 100,
//       itemBuilder: (BuildContext context, int index) {
//         return ListTile(
//           title: Text('Item $index'),
//         );
//       },
//     );
//   }
// }