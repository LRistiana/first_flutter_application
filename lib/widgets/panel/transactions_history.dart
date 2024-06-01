import 'package:first_flutter_application/utils/theme/color_theme.dart';
import 'package:flutter/material.dart';
// import 'package:sliding_up_panel/sliding_up_panel.dart';

class TransactionsHistory extends StatefulWidget {
  const TransactionsHistory({super.key});

  @override
  State<TransactionsHistory> createState() => _TransactionsHistoryState();
}

class _TransactionsHistoryState extends State<TransactionsHistory> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.55,
      minChildSize: 0.5,
      maxChildSize: 1.0,
      builder: (BuildContext context, ScrollController scrollController) {
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
            itemCount: 100,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text('Item $index'),
              );
            },
          ),
        );
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