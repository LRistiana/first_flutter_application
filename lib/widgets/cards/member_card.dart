import 'package:first_flutter_application/utils/theme/color_theme.dart';
import 'package:flutter/material.dart';

class MemberCard extends StatelessWidget {
  const MemberCard({super.key, required this.getSaldo});
  final Future<int> Function() getSaldo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      height: 200,
      width: 350,
      decoration: BoxDecoration(
        color: GeneralColor.primaryColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
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
            future: getSaldo(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text(
                  "Rp. -",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                );
              } else if (snapshot.hasError) {
                return Text(
                  "Error: ${snapshot.error}",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                  ),
                );
              } else {
                return AnimatedBalance(
                  startValue: 0, // Ganti dengan nilai saldo sebelumnya jika ada
                  endValue: snapshot.data!,
                  duration: Duration(seconds: 2), // Durasi animasi
                );
              }
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              minimumSize:
                  const Size(300, 60), // Width unconstrained, height 40
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
                SizedBox(width: 8), // Space between icon and text
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
    Key? key,
    required this.startValue,
    required this.endValue,
    required this.duration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<int>(
      tween: IntTween(begin: startValue, end: endValue),
      duration: duration,
      builder: (context, value, child) {
        return Text(
          'Rp. $value',
          style: TextStyle(
            color: Colors.black,
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    );
  }
}
