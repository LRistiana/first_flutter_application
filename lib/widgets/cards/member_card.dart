import 'package:first_flutter_application/model/tabungan_model.dart';
import 'package:first_flutter_application/model/team_members_model.dart';
import 'package:first_flutter_application/utils/format/currency.dart';
import 'package:first_flutter_application/utils/modal/modal_utils.dart';
import 'package:first_flutter_application/utils/theme/color_theme.dart';
import 'package:flutter/material.dart';

class MemberCard extends StatefulWidget {
  const MemberCard(
      {super.key,
      required this.getSaldo,
      required this.member,
      required this.jenisTransaksiProvider});
  final Future<int> Function() getSaldo;
  final JenisTransaksiProvider jenisTransaksiProvider;
  final TeamMember member;

  @override
  State<MemberCard> createState() => _MemberCardState();
}

class _MemberCardState extends State<MemberCard> {
  late int _previousBalance = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      height: 200,
      width: 350,
      decoration: BoxDecoration(
        gradient: GradientColor.primaryGradient,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Text(
            "Total Balance",
            style: TextStyle(
                color: TextColor.darkTextColor,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          FutureBuilder<int>(
            key: const ValueKey('unique_key_for_future_builder'),
            future: widget.getSaldo(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return _previousBalance == 0
                    ? const Text(
                        "Rp 0",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : Text(
                        CurrencyFormatter.rupiah(_previousBalance),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      );
              } else if (snapshot.hasError) {
                return Text(
                  "Error: ${snapshot.error}",
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                  ),
                );
              } else {
                int previousBalanceHere = _previousBalance;
                _previousBalance = snapshot.data!;
                return AnimatedBalance(
                  startValue:
                      previousBalanceHere, // ganti dengan saldo sebellumnya jika ada
                  endValue: snapshot.data!,
                  duration: const Duration(seconds: 1),
                );
              }
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              ShowModal.showAddSavingModal(
                  context, widget.member, widget.jenisTransaksiProvider);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              minimumSize: const Size(300, 60),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.wallet,
                  color: Colors.white,
                ),
                SizedBox(width: 8),
                Text(
                  'New Transaction',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedBalance extends StatelessWidget {
  final int startValue;
  final int endValue;
  final Duration duration;

  const AnimatedBalance({
    super.key,
    required this.startValue,
    required this.endValue,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<int>(
      tween: IntTween(begin: startValue, end: endValue),
      duration: duration,
      builder: (context, value, child) {
        return Text(
          CurrencyFormatter.rupiah(value),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    );
  }
}
