import 'package:flutter/material.dart';
import 'package:taskzoo/widgets/stats/pieces_progress_card.dart';
import 'package:taskzoo/widgets/stats/daily_percent_completed_card.dart';
import 'package:taskzoo/widgets/stats/month_total_tasks_completed_card.dart';

import 'dart:math';

class StatsPage extends StatelessWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dailyPercentCompletedTestData = {
      "mon": 0.3,
      "tue": 0.1,
      "wed": 0.0,
      "thu": 0.5,
      "fri": 1.0,
      "sat": 0.6,
      "sun": 0.1,
    };

    List<int> monthTotalCompletedTestData = [
      10,
      15,
      16,
      4,
      19,
      9,
      8,
      5,
      7,
      16,
      18,
      11,
      12,
      17,
      11,
      5,
      8,
      3,
      17,
      8,
      11,
      2,
      10
    ];

    const appBarSize = 40.0;
    const prop1 = 0.22;
    const prop2 = 0.18;
    const prop3 = 0.20;


    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: IconButton(
            iconSize: appBarSize / 1.5,
            icon: const Icon(Icons.keyboard_control),
            color: Theme.of(context).indicatorColor,
            onPressed: () {
              // Perform settings action
            },
          ),
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            PiecesProgressCard(
              piecesCollected: 15,
              totalPieces: 20,
              circularProgressDiameter: MediaQuery.of(context).size.height * prop1,
              circularProgressStroke: 20,
              outlineStrokeWidth: 2,
            ),
            DailyPercentCompletedCard(
              data: dailyPercentCompletedTestData,
              barWidth: 15,
              barHeight: MediaQuery.of(context).size.height * prop2,
              taskPercentGoal: 0.6,
            ),
            MonthTotalTasksCompletedCard(
              data: monthTotalCompletedTestData,
              height: MediaQuery.of(context).size.height * prop3,
            ),
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
