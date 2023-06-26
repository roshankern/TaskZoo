import 'package:flutter/material.dart';

class Circle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 3
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

  PiecesProgressCard({
    required this.piecesCollected,
    required this.totalPieces,
    this.circularProgressDiameter = 200,
    this.circularProgressStroke = 20,
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
                    painter: Circle(),
                    child: Container(
                      height: (circularProgressDiameter+circularProgressStroke)-3,
                      width: (circularProgressDiameter+circularProgressStroke)-3,
                    ),
                  ),
                  CustomPaint(
                    painter: Circle(),
                    child: Container(
                      height: (circularProgressDiameter-circularProgressStroke)+3,
                      width: (circularProgressDiameter-circularProgressStroke)+3,
                    ),
                  ),
                  Container(
                    height: circularProgressDiameter,
                    width: circularProgressDiameter,
                    child: CircularProgressIndicator(
                      value: progress,
                      strokeWidth: circularProgressStroke,
                      color: Colors.white,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '$piecesCollected/$totalPieces',
                        style:
                            TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'pieces collected',
                        style: TextStyle(fontSize: 16),
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
