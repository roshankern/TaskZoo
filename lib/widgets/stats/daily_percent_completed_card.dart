import 'package:flutter/material.dart';

class DailyPercentCompletedCard extends StatelessWidget {
  final Map<String, double> data;
  final double height;
  final double width;

  DailyPercentCompletedCard(
      {required this.data, required this.height, required this.width});

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
          child: CustomPaint(
            size: Size(width, height + 20), // Add space for labels
            painter: BarChartPainter(data),
          )),
    );
  }
}

class BarChartPainter extends CustomPainter {
  final Map<String, double> data;
  final Color barColor = Colors.white; // Color for each bar in the graph.

  BarChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    double barWidth = size.width / (data.keys.length * 2 - 1);
    double maxBarHeight = size.height - 20; // Subtract space for labels

    var textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    int i = 0;
    for (var entry in data.entries) {
      double barHeight = maxBarHeight * entry.value;
      double left = i * barWidth * 2;
      double top = maxBarHeight - barHeight;
      var paint = Paint()..color = barColor;
      var rect = Rect.fromLTWH(left, top, barWidth, barHeight);
      canvas.drawRect(rect, paint);

      // Draw label
      textPainter.text = TextSpan(
        text: entry.key[0].toLowerCase(),
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
        ),
      );
      textPainter.layout();
      textPainter.paint(
          canvas,
          Offset(
              left + barWidth / 2 - textPainter.width / 2, maxBarHeight + 5)); // Adjust y position

      i++;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // We always repaint for simplicity
  }
}
