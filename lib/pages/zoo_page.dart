import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ZooPage extends StatefulWidget {
  const ZooPage({Key? key}) : super(key: key);

  @override
  _ZooPageState createState() => _ZooPageState();
}

class _ZooPageState extends State<ZooPage> {
  Future<Widget> loadBiomeData() async {
    final String biomesData =
        await rootBundle.loadString('assets/biomes_data.json');
    Map<String, dynamic> json = jsonDecode(biomesData);

    // Retrieve the list of animals from the JSON data
    List<dynamic> animals = json['biomes']['arctic']['animals'];

    // Create a GridView from the list of animals
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: animals.length,
      itemBuilder: (BuildContext context, int index) {
        return SvgPicture.asset(
          animals[index]['svg_path'],
          semanticsLabel: animals[index]['name'],
          fit: BoxFit.contain,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
        future: loadBiomeData(),
        builder:
            (BuildContext context, AsyncSnapshot<Widget> biomeWidgetSnapshot) {
          if (biomeWidgetSnapshot.connectionState == ConnectionState.waiting) {
            // The JSON file is still being loaded.
            return Center(child: CircularProgressIndicator());
          } else if (biomeWidgetSnapshot.connectionState ==
              ConnectionState.done) {
            // The JSON file is still being loaded.
            return biomeWidgetSnapshot.data ?? Center(child: Text('No data'));
          } else {
            // The JSON file could not be loaded or parsed.
            return Center(child: Text('Error: ${biomeWidgetSnapshot.error}'));
          }
        });
  }
}
