import 'package:flutter/material.dart';
import 'package:curved_progress_bar/curved_progress_bar.dart';

class Circle extends CustomPainter {
  final double outlineStrokeWidth;
  final Color outlineColor;

  Circle({this.outlineStrokeWidth = 3, this.outlineColor = Colors.grey});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = outlineColor
      ..strokeWidth = outlineStrokeWidth
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class PiecesProgressCard extends StatelessWidget {
  final int piecesCollected;
  final int totalPieces;
  final double circularProgressDiameter;
  final double circularProgressStroke;
  final double outlineStrokeWidth;

  PiecesProgressCard({
    required this.piecesCollected,
    required this.totalPieces,
    this.circularProgressDiameter = 200,
    this.circularProgressStroke = 20,
    this.outlineStrokeWidth = 3,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double progress = piecesCollected / totalPieces;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Theme.of(context).unselectedWidgetColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 220,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  CustomPaint(
                    painter: Circle(
                        outlineStrokeWidth: outlineStrokeWidth,
                        outlineColor: Theme.of(context).dividerColor),
                    child: Container(
                      height:
                          (circularProgressDiameter + circularProgressStroke) -
                              outlineStrokeWidth,
                      width:
                          (circularProgressDiameter + circularProgressStroke) -
                              outlineStrokeWidth,
                    ),
                  ),
                  CustomPaint(
                    painter: Circle(
                        outlineStrokeWidth: outlineStrokeWidth,
                        outlineColor: Theme.of(context).dividerColor),
                    child: Container(
                      height:
                          (circularProgressDiameter - circularProgressStroke) +
                              outlineStrokeWidth,
                      width:
                          (circularProgressDiameter - circularProgressStroke) +
                              outlineStrokeWidth,
                    ),
                  ),
                  Container(
                    height: circularProgressDiameter,
                    width: circularProgressDiameter,
                    child: CurvedCircularProgressIndicator(
                      value: progress,
                      strokeWidth: circularProgressStroke,
                      color: Colors.white,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: '$piecesCollected',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).dividerColor),
                            ),
                            TextSpan(
                              text: '/$totalPieces',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'pieces collected',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
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
