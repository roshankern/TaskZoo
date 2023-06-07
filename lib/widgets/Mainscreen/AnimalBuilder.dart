import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    const String originalSvg = '''
<?xml version="1.0" encoding="utf-8"?>
<svg viewBox="0 0 500 500" xmlns="http://www.w3.org/2000/svg" xmlns:bx="https://boxy-svg.com">
  <path d="M 149.822 118.52 L 205.517 273.012 L 94.126 273.012 L 149.822 118.52 Z" style="" bx:shape="triangle 94.126 118.52 111.391 154.492 0.5 0 1@83216011"/>
  <path d="M 250.744 264.674 L 306.439 419.166 L 195.048 419.166 L 250.744 264.674 Z" style="fill: rgb(4, 0, 255);" bx:shape="triangle 195.048 264.674 111.391 154.492 0.5 0 1@1a79f46a"/>
  <path d="M 149.822 118.52 L 205.517 273.012 L 94.126 273.012 L 149.822 118.52 Z" style="fill: rgb(255, 0, 0);" transform="matrix(1, 0, 0, 1, 189.62174350698075, 6.294651852412102)" bx:shape="triangle 94.126 118.52 111.391 154.492 0.5 0 1@83216011"/>
</svg>
''';

    var currentSvgString = getBuilderSvg(originalSvg, _counter);

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Animal Builder"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.string(
              currentSvgString,
              width: 500,
              height: 500,
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
