import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AnimalBuilder extends StatefulWidget {
  const AnimalBuilder(
      {required this.svgPath, required this.biomeIcon, Key? key})
      : super(key: key);

  final String svgPath;
  final IconData biomeIcon;

  @override
  State<AnimalBuilder> createState() => AnimalBuilderState();
}

class AnimalBuilderState extends State<AnimalBuilder> {
  int _numShapes = 0;
  late Future<String> svgDataFuture;
  int _totalNumShapes = 0;
  double _buildPercent = 0;

  Future<String> loadSvgData(String assetName) async {
    return await rootBundle.loadString(assetName);
  }

  @override
  void initState() {
    super.initState();
    svgDataFuture = loadSvgData(widget.svgPath);
  }

  void addShape() {
    setState(() {
      if (_numShapes < _totalNumShapes) {
        _numShapes++;
        _buildPercent = _numShapes / _totalNumShapes;
      }
    });
  }

  String getBuilderSvg(String originalSvg, int numShapes) {
    // get svg string that will result in an svg with the desired number of shapes

    // Define a regular expression that matches the SVG root element
    final rootRegex = RegExp(r'<svg[^>]*>', multiLine: true);

    // Find the SVG root element
    final rootMatch = rootRegex.firstMatch(originalSvg);
    if (rootMatch == null) {
      throw Exception('No SVG root element found');
    }
    final rootElement = originalSvg.substring(rootMatch.start, rootMatch.end);

    // Define a regular expression that matches the shape elements
    final shapeRegex = RegExp(r'<path[^>]*?>', multiLine: true);

    // Find the shape elements
    final shapeMatches = shapeRegex.allMatches(originalSvg).toList();

    // Include only the required number of shapes
    final includedShapes = shapeMatches
        .take(numShapes)
        .map((match) => originalSvg.substring(match.start, match.end))
        .join('\n');

    // Return the new SVG string
    return '$rootElement\n$includedShapes\n</svg>';
  }

  int countPathsInSvg(String svgData) {
    // Define a regular expression that matches the path elements
    final pathRegex = RegExp(r'<path[^>]*>', multiLine: true);

    // Count the path elements
    final numPaths = pathRegex.allMatches(svgData).length;

    return numPaths;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: svgDataFuture,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        // get svg string data based on svg file and number of desired shapes
        String svgData = snapshot.data!;
        // find total number of shapes so we can tell user how close they are to being complete with this shape
        _totalNumShapes = countPathsInSvg(svgData);
        svgData = getBuilderSvg(svgData, _numShapes);

        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Theme.of(context).unselectedWidgetColor,
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Align(
                alignment: Alignment.topRight,
                child: Icon(
                  widget.biomeIcon,
                  color: Colors.black,
                  size: 30.0,
                ),
              ),
              SvgPicture.string(
                svgData,
                width: 200,
                height: 200,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '${(_buildPercent * 100).toStringAsFixed(0)}%',
                    style: const TextStyle(fontSize: 12),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Container(
                            height: 12,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4)),
                            ),
                          ),
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4)),
                            child: LinearProgressIndicator(
                              value: _buildPercent,
                              backgroundColor: Colors.transparent,
                              color: Colors.black,
                              minHeight: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    '$_numShapes/$_totalNumShapes shapes',
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ]),
          ),
        );
      },
    );
  }
}
