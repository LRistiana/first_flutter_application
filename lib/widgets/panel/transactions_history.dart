import 'package:first_flutter_application/model/tabungan_model.dart';
import 'package:first_flutter_application/utils/format/currency.dart';
import 'package:first_flutter_application/utils/format/month.dart';
import 'package:first_flutter_application/utils/theme/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class TransactionsHistory extends StatefulWidget {
  const TransactionsHistory({super.key, required this.memberID});
  final int memberID;

  @override
  State<TransactionsHistory> createState() => _TransactionsHistoryState();
}

class _TransactionsHistoryState extends State<TransactionsHistory> {
  Map<String, List<Tabungan>> groupByMonth(List<Tabungan> tabungans) {
    Map<String, List<Tabungan>> grouped = {};
    for (var tabungan in tabungans) {
      // Assuming tanggal is in the format "yyyy-MM-dd"
      String monthYear = tabungan.tanggal.substring(0, 7); // "yyyy-MM"
      if (!grouped.containsKey(monthYear)) {
        grouped[monthYear] = [];
      }
      grouped[monthYear]!.add(tabungan);
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    final tabunganProvider =
        Provider.of<TabunganProvider>(context, listen: false);
    final jenisTransaksiProvider =
        Provider.of<JenisTransaksiProvider>(context, listen: false);

    tabunganProvider.fetchTabungans(widget.memberID);
    jenisTransaksiProvider.fetchTransactions();

    return Consumer2<TabunganProvider, JenisTransaksiProvider>(
      builder: (context, tabunganProvider, jenisTransaksiProvider, child) {
        tabunganProvider.tabungans
            .sort((a, b) => b.tanggal.compareTo(a.tanggal));
        var groupedTransactions = groupByMonth(tabunganProvider.tabungans);

        if (tabunganProvider.isLoading || jenisTransaksiProvider.isLoading) {
          return const Center(
            child: LinearProgressIndicator(
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(GeneralColor.darkColor),
              minHeight: 1,
            ),
          );
        }

        return SizedBox(
          height: 360,
          child: ListView.builder(
            itemCount: groupedTransactions.length,
            itemBuilder: (BuildContext context, int index) {
              String monthYear = groupedTransactions.keys.elementAt(index);
              List<Tabungan> monthlyTransactions =
                  groupedTransactions[monthYear]!;

              return Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: GeneralColor.darkColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: GeneralColor.lightColor,
                            width: 1,
                          ),
                        ),
                      ),
                      child: Text(
                        MonthFormatter.formatMonthYear(monthYear),
                        style: const TextStyle(
                          color: GeneralColor.lightColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Column(
                      children: monthlyTransactions.map((tabungan) {
                        final jenisTransaksi = jenisTransaksiProvider
                            .jenisTransaksiList
                            .firstWhere(
                          (jenis) => jenis.id == tabungan.transaksiID,
                          orElse: () => JenisTransaksi(
                              id: 0, trxName: 'Unknown', trxMultiply: 0),
                        );
                        return ListTile(
                          leading: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: BackgroundColor.iconBacgroundColor,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: jenisTransaksi.trxMultiply > 0
                                ? const Icon(Icons.arrow_upward,
                                    color: Colors.green, size: 12)
                                : const Icon(Icons.arrow_downward,
                                    color: Colors.red, size: 12),
                          ),
                          title: Text(
                            jenisTransaksi.trxName,
                            style: const TextStyle(
                                color: GeneralColor.lightColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                          subtitle: Text(
                            "${MonthFormatter.formatDateMonthYear(tabungan.tanggal.split(' ')[0])} • ${tabungan.tanggal.split(' ')[1].split(':')[0]}:${tabungan.tanggal.split(' ')[1].split(':')[1]}",
                            style: const TextStyle(
                                color: GeneralColor.secondaryColor),
                          ),
                          trailing: jenisTransaksi.trxMultiply > 0
                              ? Text(
                                  CurrencyFormatter.rupiah(tabungan.nominal),
                                  style: const TextStyle(
                                      color: GeneralColor.lightColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                )
                              : Text(
                                  "- ${CurrencyFormatter.rupiah(tabungan.nominal)}",
                                  style: const TextStyle(
                                      color: GeneralColor.lightColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
