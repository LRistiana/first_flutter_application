import 'package:first_flutter_application/model/team_members_model.dart';
import 'package:first_flutter_application/utils/theme/color_theme.dart';
import 'package:flutter/material.dart';

class StatisticCard extends StatefulWidget {
  const StatisticCard({super.key, required this.member});
  final TeamMember member;

  @override
  State<StatisticCard> createState() => _StatisticCardState();
}

class _StatisticCardState extends State<StatisticCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      height: 200,
      width: 350,
      decoration: BoxDecoration(
        gradient: GradientColor.primaryGradient,
        // color: GeneralColor.primaryColor,
        borderRadius: BorderRadius.circular(16),
        
      ),
      child: Column(
        children: [
          // Menampilkan nomer induk member
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.numbers_rounded,
                  color: TextColor.darkTextColor, size: 24),
              Text(widget.member.nomorInduk.toString(),
                  style: const TextStyle(
                      color: TextColor.darkTextColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          // Menampilkan alamat
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.home,
                  color: TextColor.darkTextColor, size: 24),
              Text(widget.member.alamat,
                  style: const TextStyle(
                      color: TextColor.darkTextColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          // Menampilkan nomer telp
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.phone,
                  color: TextColor.darkTextColor, size: 24),
              Text(widget.member.telepon.toString(),
                  style: const TextStyle(
                      color: TextColor.darkTextColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          // Menampilkan tanggal lahir
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.date_range,
                  color: TextColor.darkTextColor, size: 24),
              Text(widget.member.tanggalLahir.toString(),
                  style: const TextStyle(
                      color: TextColor.darkTextColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';

// class StatisticCard extends StatelessWidget {
//   const StatisticCard({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Dummy data transaksi tabungan
//     final List<Map<String, dynamic>> dummyTabunganData = [
//       {"id": 1, "trx_tanggal": "2024-05-26", "trx_nominal": 50000},
//       {"id": 2, "trx_tanggal": "2024-05-27", "trx_nominal": 90000},
//       {"id": 3, "trx_tanggal": "2024-05-28", "trx_nominal": 120000},
//       {"id": 4, "trx_tanggal": "2024-05-29", "trx_nominal": 60000},
//       {"id": 5, "trx_tanggal": "2024-05-30", "trx_nominal": 80000},
//     ];

//     return Container(
//       padding: const EdgeInsets.all(24),
//       height: 200,
//       width: 350,
//       decoration: BoxDecoration(
//         color: Colors.white, // Ganti warna latar belakang sesuai kebutuhan
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: const [
//           BoxShadow(
//             color: Colors.grey,
//             blurRadius: 5,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: LineChart(
//         LineChartData(
//           minX: 0,
//           maxX: dummyTabunganData.length.toDouble() - 1,
//           minY: 0,
//           maxY: getMaxNominal(dummyTabunganData) * 1.2, // Meningkatkan batas atas agar grafik lebih jelas
//           titlesData: FlTitlesData(
//             bottomTitles: SideTitles(
//               showTitles: true,
//               getTitles: (value) {
//                 if (value.toInt() % 2 == 0 && value.toInt() < dummyTabunganData.length) {
//                   return dummyTabunganData[value.toInt()]['trx_tanggal'].toString().substring(5, 10);
//                 }
//                 return '';
//               },
//             ),
//             leftTitles: SideTitles(
//               showTitles: true,
//               getTitles: (value) {
//                 return value.toInt().toString();
//               },
//             ),
//           ),
//           borderData: FlBorderData(
//             show: true,
//             border: Border.all(color: Colors.black),
//           ),
//           lineBarsData: [
//             LineChartBarData(
//               spots: getSpots(dummyTabunganData),
//               isCurved: true,
//               colors: [Colors.blue], // Ganti warna grafik sesuai kebutuhan
//               barWidth: 2,
//               isStrokeCapRound: true,
//               belowBarData: BarAreaData(show: false),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Fungsi untuk mendapatkan nilai maksimum nominal dari data tabungan
//   double getMaxNominal(List<Map<String, dynamic>> tabunganData) {
//     double maxNominal = 0;
//     for (var transaksi in tabunganData) {
//       if (transaksi['trx_nominal'] > maxNominal) {
//         maxNominal = transaksi['trx_nominal'].toDouble();
//       }
//     }
//     return maxNominal;
//   }

//   // Fungsi untuk mendapatkan titik-titik (spots) dari data tabungan untuk grafik
//   List<FlSpot> getSpots(List<Map<String, dynamic>> tabunganData) {
//     List<FlSpot> spots = [];
//     for (int i = 0; i < tabunganData.length; i++) {
//       spots.add(FlSpot(i.toDouble(), tabunganData[i]['trx_nominal'].toDouble()));
//     }
//     return spots;
//   }
// }
