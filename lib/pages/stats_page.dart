import 'package:flutter/material.dart';

import 'package:taskzoo/widgets/stats/current_productivity_card.dart';

import 'package:taskzoo/widgets/stats/daily_percent_completed_card.dart';
import 'package:taskzoo/widgets/stats/month_total_tasks_completed_card.dart';

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
    const prop1 = 0.20;
    const prop2 = 0.18;
    const prop3 = 0.19;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        toolbarHeight: appBarSize,
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
            Container(
              height: 10,
            ),
            Expanded(
              child: CurrentProductivityCard(
                currentProductivity: 0.75,
                circularProgressStroke: 20,
                outlineStrokeWidth: 2,
              ),
            ),
            Container(
              height: 10,
            ),
            Expanded(
              child: DailyPercentCompletedCard(
                data: dailyPercentCompletedTestData,
                barWidth: 20,
              ),
            ),
            Container(
              height: 10,
            ),
            Expanded(
              child: MonthTotalTasksCompletedCard(
                data: monthTotalCompletedTestData,
              ),
            ),
            Container(
              height: 10,
            ),
          ]),
      bottomNavigationBar: BottomAppBar(
        height: 50,
        color: Theme.of(context).primaryColor,
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
