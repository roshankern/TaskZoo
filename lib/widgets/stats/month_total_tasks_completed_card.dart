import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MonthTotalTasksCompletedCard extends StatelessWidget {
  final List<int> data;
  final double height;

  MonthTotalTasksCompletedCard({
    required this.data,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    List<FlSpot> spots = data
        .asMap()
        .entries
        .map((e) => FlSpot(e.key.toDouble(), e.value.toDouble()))
        .toList();

    double maxX = data.length.toDouble()-1;
    double maxY = data.reduce((curr, next) => curr > next ? curr : next).toDouble()+1;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: this.height,
        padding: const EdgeInsets.all(0.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Theme.of(context).unselectedWidgetColor,
        ),
        child: SizedBox(
              height: height,
              child: LineChart(
                LineChartData(
                  minX: 0,
                  maxX: maxX,
                  minY: -1,
                  maxY: maxY,
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                  gridData: FlGridData(show: false),
                ),
              ),
            ),
      ),
    );
  }
}
