import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const cardColor = Color.fromRGBO(175, 210, 210, 1);

class AnimalBuilder extends StatefulWidget {
  const AnimalBuilder({super.key, required this.originalSvgString});

  final String originalSvgString;

  @override
  State<AnimalBuilder> createState() => _AnimalBuilderState();
}

class _AnimalBuilderState extends State<AnimalBuilder> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
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
    var currentSvgString = getBuilderSvg(widget.originalSvgString, _counter);

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
            width: 500,
            height: 500,
          ),
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
