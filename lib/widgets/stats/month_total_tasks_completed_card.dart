import 'package:dimensions_theme/dimensions_theme.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MonthTotalTasksCompletedCard extends StatefulWidget {
  final List<int> data;

  MonthTotalTasksCompletedCard({required this.data});

  @override
  _MonthTotalTasksCompletedCard createState() =>
      _MonthTotalTasksCompletedCard();
}

class _MonthTotalTasksCompletedCard extends State<MonthTotalTasksCompletedCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        List<FlSpot> spots = widget.data
            .asMap()
            .entries
            .map((e) => FlSpot(
                  e.key.toDouble(),
                  e.value.toDouble() * _animation.value,
                ))
            .toList();

        double maxX = widget.data.length.toDouble() - 1;
        double maxY = widget.data
                .reduce((curr, next) => curr > next ? curr : next)
                .toDouble() +
            1;

        return Padding(
          padding: EdgeInsets.fromLTRB(Dimensions.of(context).insets.medium, 0,
              Dimensions.of(context).insets.medium, 0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(Dimensions.of(context).radii.medium),
              color: Theme.of(context).cardColor,
            ),
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(Dimensions.of(context).radii.medium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Total Tasks Completed',
                      style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).indicatorColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
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
                            color: Theme.of(context).indicatorColor,
                            spots: spots,
                            isCurved: true,
                            dotData: FlDotData(show: false),
                            belowBarData: BarAreaData(
                              show: true,
                              color: Theme.of(context).indicatorColor,
                            ),
                          ),
                        ],
                        gridData: FlGridData(show: false),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).indicatorColor,
                      border: Border(
                        top: BorderSide(
                          color: Theme.of(context).indicatorColor,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: Text(
                      '${widget.data.length} Day History',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).cardColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
