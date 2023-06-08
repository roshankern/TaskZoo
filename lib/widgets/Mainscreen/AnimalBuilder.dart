import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

const cardColor = Color.fromRGBO(175, 210, 210, 1);

class AnimalBuilder extends StatefulWidget {
  const AnimalBuilder({super.key, required this.svgPath});

  final String svgPath;

  @override
  State<AnimalBuilder> createState() => _AnimalBuilderState();
}

class _AnimalBuilderState extends State<AnimalBuilder> {
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


  void _incrementCounter() {
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
    const String originalSvgString = '''
<?xml version="1.0" encoding="utf-8"?>
<svg viewBox="0 0 500 500" xmlns="http://www.w3.org/2000/svg" xmlns:bx="https://boxy-svg.com">
  <path d="M 149.822 118.52 L 205.517 273.012 L 94.126 273.012 L 149.822 118.52 Z" style="" bx:shape="triangle 94.126 118.52 111.391 154.492 0.5 0 1@83216011"/>
  <path d="M 250.744 264.674 L 306.439 419.166 L 195.048 419.166 L 250.744 264.674 Z" style="fill: rgb(4, 0, 255);" bx:shape="triangle 195.048 264.674 111.391 154.492 0.5 0 1@1a79f46a"/>
  <path d="M 149.822 118.52 L 205.517 273.012 L 94.126 273.012 L 149.822 118.52 Z" style="fill: rgb(255, 0, 0);" transform="matrix(1, 0, 0, 1, 189.62174350698075, 6.294651852412102)" bx:shape="triangle 94.126 118.52 111.391 154.492 0.5 0 1@83216011"/>
</svg>
''';
    var currentSvgString = getBuilderSvg(originalSvgString, _numShapes);

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
            currentSvgString,
            width: 200,
            height: 200,
          ),
          SizedBox(height: 15),
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ])),
      ),
    );
  }
}
