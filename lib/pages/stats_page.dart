import 'package:flutter/material.dart';
import 'package:taskzoo/widgets/stats/pieces_progress_card.dart';
import 'package:taskzoo/widgets/stats/daily_percent_completed_card.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dailyPercentCompltedTestData = {
      "mon": 0.5,
      "tue": 0.7,
      "wed": 0.3,
      "thu": 0.6,
      "fri": 0.1,
      "sat": 0.6,
      "sun": 0.9,
    };

    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PiecesProgressCard(
              piecesCollected: 15,
              totalPieces: 20,
              circularProgressDiameter: 200,
              circularProgressStroke: 20,
              outlineStrokeWidth: 2,
            ),
            DailyPercentCompletedCard(
              data: dailyPercentCompltedTestData,
              width: 300,
              height: 150,
            )
          ]),
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
