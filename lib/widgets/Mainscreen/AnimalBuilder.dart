import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

const cardColor = Color.fromRGBO(175, 210, 210, 1);

class AnimalBuilder extends StatefulWidget {
  AnimalBuilder({required this.svgPath, Key? key}) : super(key: key);

  final String svgPath;

  @override
  State<AnimalBuilder> createState() => AnimalBuilderState();
}

class AnimalBuilderState extends State<AnimalBuilder> {
  int _numShapes = 0;
  late Future<String> svgDataFuture;

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
      _numShapes++;
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: svgDataFuture,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        // svg data starts with empty image (this wont change if no data is loaded)
        String svgData =
            '''<?xml version="1.0" encoding="UTF-8"?><svg xmlns="http://www.w3.org/2000/svg" width="1" height="1"/>''';

        if (snapshot.connectionState == ConnectionState.done) {
          // get svg string data based on svg file and number of desired shapes
          svgData = snapshot.data!;
          svgData = getBuilderSvg(svgData, _numShapes);
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: cardColor,
            ),
            child: Center(
                child: Column(children: [
              SvgPicture.string(
                svgData,
                width: 200,
                height: 200,
              )
            ])),
          ),
        );
      },
    );
  }
}
