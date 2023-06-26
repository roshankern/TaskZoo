import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';

class DailyPercentCompletedCard extends StatelessWidget {
  final Map<String, double> data;
  final double barWidth;
  final double barHeight;
  final double taskPercentGoal;

  DailyPercentCompletedCard({
    required this.data,
    required this.barHeight,
    required this.barWidth,
    required this.taskPercentGoal,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Theme.of(context).unselectedWidgetColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'percent tasks completed',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  CustomPaint(
                    size: Size(barWidth * data.length, barHeight + 20),
                    painter: BarChartPainter(data, barWidth, barHeight),
                  ),
                ],
              ),
            ),
            Container(
              height: barHeight + 40,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: RotatedBox(
                      quarterTurns: -1,
                      child: Text(
                        'lost',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                  Expanded(
                    child: RotatedBox(
                      quarterTurns: -1,
                      child: Text(
                        'gained',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BarChartPainter extends CustomPainter {
  final Map<String, double> data;
  double barWidth;
  final double barHeight;
  final Color barColor = Colors.white;
  final Color backgroundBarColor = Colors.grey;
  final double cornerRadius = 8.0;
  final double strokeWidth = 2.0;

  BarChartPainter(this.data, this.barWidth, this.barHeight);

  @override
  void paint(Canvas canvas, Size size) {
    double maxBarHeight = barHeight - 20;
    double gapWidth = size.width / (2 * data.length + 1); // Added this line
    barWidth = gapWidth; // Update barWidth based on the calculated gapWidth

    var textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    int i = 0;
    for (var entry in data.entries) {
      double actualBarHeight = maxBarHeight * entry.value;
      double left = (2 * i + 1) * gapWidth; // Update left position calculation
      double top = maxBarHeight - actualBarHeight;

      var backgroundRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(left, 0, barWidth, maxBarHeight),
        Radius.circular(cornerRadius),
      );

      var paint = Paint()..color = barColor;
      var rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(left, top, barWidth, actualBarHeight),
        Radius.circular(cornerRadius),
      );

      // Draw background
      var backgroundStrokePaint = Paint()
        ..color = backgroundBarColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth;
      canvas.drawRRect(backgroundRect, backgroundStrokePaint);

      // Draw bar
      canvas.drawRRect(rect, paint);

      // Draw label
      textPainter.text = TextSpan(
        text: entry.key[0].toLowerCase(),
        style: TextStyle(
          color: Colors.black,
          fontSize: 12,
        ),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
          left + barWidth / 2 - textPainter.width / 2,
          maxBarHeight + 5,
        ),
      );

      i++;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
