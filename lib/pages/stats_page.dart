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

Widget getPiecesProgressCard(
    BuildContext context, int piecesCollected, int totalPieces, {double circularProgressDiameter = 200, double circularProgressStroke = 20}) {
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

class StatsPage extends StatelessWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [getPiecesProgressCard(context, 15, 20)]),
      bottomNavigationBar: BottomAppBar(
        height: 50,
        color: Theme.of(context).unselectedWidgetColor,
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
