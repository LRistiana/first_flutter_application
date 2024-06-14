import 'package:first_flutter_application/model/team_members_model.dart';
import 'package:first_flutter_application/utils/format/month.dart';
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
    return SizedBox(
      height: 200,
      child: Column(
        children: [
          MemberData(title: widget.member.nomorInduk.toString(), icon: Icons.perm_identity),
          const SizedBox(height: 6),
          MemberData(title: widget.member.alamat, icon: Icons.home),
          const SizedBox(height: 6),
          MemberData(title: widget.member.telepon.toString(), icon: Icons.phone),
          const SizedBox(height: 6),        
          MemberData(title: MonthFormatter.formatDateMonthYear(widget.member.tanggalLahir.toString()), icon: Icons.date_range),
        ],
      ),
    );
    // return Container(
    //   padding: const EdgeInsets.all(24),
    //   height: 200,
    //   width: 350,
    //   decoration: BoxDecoration(
    //     gradient: GradientColor.primaryGradient,
    //     // color: GeneralColor.primaryColor,
    //     borderRadius: BorderRadius.circular(16),
        
    //   ),
    //   child: Column(
    //     children: [
    //       // Menampilkan nomer induk member
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           const Icon(Icons.numbers_rounded,
    //               color: TextColor.darkTextColor, size: 24),
    //           Text(widget.member.nomorInduk.toString(),
    //               style: const TextStyle(
    //                   color: TextColor.darkTextColor,
    //                   fontSize: 18,
    //                   fontWeight: FontWeight.bold)),
    //         ],
    //       ),
    //       // Menampilkan alamat
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           const Icon(Icons.home,
    //               color: TextColor.darkTextColor, size: 24),
    //           Text(widget.member.alamat,
    //               style: const TextStyle(
    //                   color: TextColor.darkTextColor,
    //                   fontSize: 18,
    //                   fontWeight: FontWeight.bold)),
    //         ],
    //       ),
    //       // Menampilkan nomer telp
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           const Icon(Icons.phone,
    //               color: TextColor.darkTextColor, size: 24),
    //           Text(widget.member.telepon.toString(),
    //               style: const TextStyle(
    //                   color: TextColor.darkTextColor,
    //                   fontSize: 18,
    //                   fontWeight: FontWeight.bold)),
    //         ],
    //       ),
    //       // Menampilkan tanggal lahir
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           const Icon(Icons.date_range,
    //               color: TextColor.darkTextColor, size: 24),
    //           Text(widget.member.tanggalLahir.toString(),
    //               style: const TextStyle(
    //                   color: TextColor.darkTextColor,
    //                   fontSize: 18,
    //                   fontWeight: FontWeight.bold)),
    //         ],
    //       ),
    //     ],
    //   ),
    // );
  }
}

class MemberData extends StatelessWidget {
  const MemberData({super.key, required this.title, required this.icon});
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: 45,
      width: 350,
      decoration: BoxDecoration(
        gradient: GradientColor.primaryGradientRevert,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: TextColor.darkTextColor, size: 16),
          Text(title,
              style: const TextStyle(
                  color: TextColor.darkTextColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold)),
        ],
      ),
      
    );
  }
}