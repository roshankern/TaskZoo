import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                  const Text(
                    'percent tasks completed',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  CustomPaint(
                    size: Size(barWidth * data.length, barHeight + 10),
                    painter: BarChartPainter(
                        data,
                        barWidth,
                        barHeight,
                        MediaQuery.of(context).size.width - 30 - 20 - 30,
                        taskPercentGoal),
                  ),
                ],
              ),
            ),
            Container(
              height: barHeight + 40,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: RotatedBox(
                      quarterTurns: -1,
                      child: Text(
                        'gained',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                  Expanded(
                    child: RotatedBox(
                      quarterTurns: -1,
                      child: Text(
                        'lost',
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
  final double barWidth;
  final double barHeight;
  final double availableWidth; // Total available width
  final Color barColor = Colors.white;
  final Color backgroundBarColor = Colors.grey;
  final double cornerRadius = 8.0;
  final double strokeWidth = 2.0;
  final double taskPercentGoal;

  BarChartPainter(this.data, this.barWidth, this.barHeight, this.availableWidth,
      this.taskPercentGoal);

  @override
  void paint(Canvas canvas, Size size) {
    double maxBarHeight = barHeight - 10;
    double totalBarWidth = barWidth * data.length;

    // Total available width for the spaces
    double totalSpacingWidth = availableWidth - totalBarWidth;

    // Width of each space
    double spaceWidth = totalSpacingWidth / (data.length - 1);

    var textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    int i = 0;
    for (var entry in data.entries) {
      double actualBarHeight = maxBarHeight * entry.value;
      double left = i * (barWidth + spaceWidth);
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
        style: const TextStyle(
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

    // Draw dashed line
    double goalLineTop = maxBarHeight - (maxBarHeight * taskPercentGoal);
    double goalLineWidth = ((i - 1) * (barWidth + spaceWidth)) +
        5; // Calculate the rightmost edge of the last bar
    canvas.save();
    canvas.translate(0, goalLineTop);
    DashedLinePainter().paint(canvas,
        Size(goalLineWidth, 0)); // Use goalLineWidth instead of availableWidth
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 9, dashSpace = 5, startX = 0;
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
