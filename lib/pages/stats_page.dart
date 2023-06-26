import 'package:flutter/material.dart';
import 'package:taskzoo/widgets/stats/pieces_progress_card.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [PiecesProgressCard(piecesCollected: 15, totalPieces: 20)]),
      bottomNavigationBar: BottomAppBar(
        height: 50,
        color: Theme.of(context).unselectedWidgetColor,
        child: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
