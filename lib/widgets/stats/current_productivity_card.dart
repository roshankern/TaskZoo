import 'package:flutter/material.dart';
import 'package:curved_progress_bar/curved_progress_bar.dart';
import 'package:dimensions_theme/dimensions_theme.dart';
import 'package:flutter_svg/svg.dart';

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

class CurrentProductivityCard extends StatelessWidget {
  final double currentProductivity;
  final double circularProgressStroke;
  final double outlineStrokeWidth;

  CurrentProductivityCard({
    required this.currentProductivity,
    this.circularProgressStroke = 20,
    this.outlineStrokeWidth = 3,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(Dimensions.of(context).insets.medium, 0,
          Dimensions.of(context).insets.medium, 0),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double circularProgressDiameter = constraints.maxHeight -
              40; // 40 accounts for padding and any extra spacing you might want

          return Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(Dimensions.of(context).radii.medium),
              color: Theme.of(context).cardColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      CustomPaint(
                        painter: Circle(
                            outlineStrokeWidth: outlineStrokeWidth,
                            outlineColor: Theme.of(context).dividerColor),
                        child: Container(
                          height: (circularProgressDiameter +
                                  circularProgressStroke) -
                              outlineStrokeWidth,
                          width: (circularProgressDiameter +
                                  circularProgressStroke) -
                              outlineStrokeWidth,
                        ),
                      ),
                      CustomPaint(
                        painter: Circle(
                            outlineStrokeWidth: outlineStrokeWidth,
                            outlineColor: Theme.of(context).dividerColor),
                        child: Container(
                          height: (circularProgressDiameter -
                                  circularProgressStroke) +
                              outlineStrokeWidth,
                          width: (circularProgressDiameter -
                                  circularProgressStroke) +
                              outlineStrokeWidth,
                        ),
                      ),
                      Container(
                        height: circularProgressDiameter,
                        width: circularProgressDiameter,
                        child: CurvedCircularProgressIndicator(
                          value: currentProductivity,
                          strokeWidth: circularProgressStroke,
                          color: Theme.of(context).indicatorColor,
                          animationDuration: Duration(milliseconds: 800),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            '${(currentProductivity * 100).toStringAsFixed(0)}%',
                            style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).indicatorColor),
                          ),
                          Text(
                            'Current \nProductivity',
                            style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).dividerColor),
                            textAlign: TextAlign.center,
                          ),
                          IconButton(
                            color: Theme.of(context).indicatorColor,
                            icon: SvgPicture.asset(
                                "assets/custom_icons/info.svg",
                                color: Theme.of(context).iconTheme.color,
                                semanticsLabel: 'Settings'),
                            onPressed: () => _showInfoDialog(context),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

void _showInfoDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Positioned(
            bottom: 10,
            left: 10,
            right: 10,
            child: InformationBlurb(),
          ),
        ],
      );
    },
  );
}

class InformationBlurb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(Dimensions.of(context).radii.medium)),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize:
              MainAxisSize.min, // Ensures that the card fits the content
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context); // Pops the info blurb
                },
              ),
            ),
            Text(
              'Current Productivity',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: Dimensions.of(context).insets.medium),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.of(context).insets.medium),
              child: Text(
                'This metric reflects the percent of tasks currently marked as completed.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: Dimensions.of(context).insets.large,
            ),
          ],
        ),
      ),
    );
  }
}
