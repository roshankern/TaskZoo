import 'package:flutter/material.dart';

class TaskCompletionChart extends StatelessWidget {
  final Map<String, double> data;

  TaskCompletionChart({required this.data});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(200, 100), //This can be adjusted according to your needs
      painter: BarChartPainter(data),
    );
  }
}

class BarChartPainter extends CustomPainter {
  final Map<String, double> data;
  final List<Color> colors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ]; // Colors for each bar in the graph.

  BarChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    double barWidth = size.width / (data.keys.length * 2 - 1);
    double maxBarHeight = size.height;

    int i = 0;
    for (var entry in data.entries) {
      double barHeight = maxBarHeight * entry.value;
      double left = i * barWidth * 2;
      double top = maxBarHeight - barHeight;
      var paint = Paint()..color = colors[i % colors.length];
      var rect = Rect.fromLTWH(left, top, barWidth, barHeight);
      canvas.drawRect(rect, paint);
      i++;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // We always repaint for simplicity
  }
}
