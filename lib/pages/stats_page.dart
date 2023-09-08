import 'package:flutter/material.dart';
import 'package:dimensions_theme/dimensions_theme.dart';
import 'package:taskzoo/widgets/isar_service.dart';

import 'package:taskzoo/widgets/stats/current_productivity_card.dart';

import 'package:taskzoo/widgets/stats/daily_percent_completed_card.dart';
import 'package:taskzoo/widgets/stats/month_total_tasks_completed_card.dart';

class StatsPage extends StatefulWidget {
  final IsarService service;
  const StatsPage({Key? key, required this.service}) : super(key: key);

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  @override
  void initState() {
    super.initState();
    widget.service.validateDailyCompletionEntry();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: Dimensions.of(context).insets.medium,
              ),
              StreamBuilder<double>(
                stream: widget.service.percentTasksCompleted(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else {
                    double percentage = snapshot.data ?? 0.0;
                    percentage = 60.0;
                    return Expanded(
                      child: CurrentProductivityCard(
                        currentProductivity: percentage / 100,
                        circularProgressStroke: 15,
                        outlineStrokeWidth:
                            Dimensions.of(context).borderWidths.medium,
                      ),
                    );
                  }
                },
              ),
              SizedBox(
                height: Dimensions.of(context).insets.medium,
              ),
              StreamBuilder<Map<String, double>>(
                stream: widget.service.getCompletionPercentForPast7Days(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else {
                    Map<String, double> completionData = snapshot.data ?? {};
                    completionData = {
                      'Monday': 0.7,
                      'Tuesday': 0.2,
                      'Wednesday': 0.5,
                      'Thursday': 0.9,
                      'Friday': 0.4,
                      'Saturday': 0.1,
                      'Sunday': 0.8,
                    };
                    //Test to see if the null case needs to considered.
                    // print(completionData);
                    return Expanded(
                      child: DailyPercentCompletedCard(
                        data: completionData,
                        barWidth: 15,
                      ),
                    );
                  }
                },
              ),
              SizedBox(
                height: Dimensions.of(context).insets.medium,
              ),
              StreamBuilder<List<int>>(
                stream: widget.service.getCompletionCountsLast30Days(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else {
                    List<int> completionCounts = snapshot.data ?? [0];
                    completionCounts = [
                      10,
                      11,
                      12,
                      14,
                      13,
                      15,
                      16,
                      17,
                      18,
                      12,
                      19,
                      16,
                      14,
                      15,
                      17,
                      18,
                      20,
                      19,
                      11,
                      13,
                      18,
                      0,
                      17,
                      14,
                      16,
                      18,
                      19,
                      20,
                      16,
                      18
                    ];
                    if (completionCounts.isEmpty) {
                      completionCounts = [0];
                    }
                    // Default to an empty list if data is null
                    return Expanded(
                      child:
                          MonthTotalTasksCompletedCard(data: completionCounts),
                    );
                  }
                },
              ),
              SizedBox(
                height: Dimensions.of(context).insets.medium,
              ),
            ]),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 50,
        color: Theme.of(context).cardColor,
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
