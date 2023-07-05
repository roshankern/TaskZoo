import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:taskzoo/widgets/zoo/Appbar.dart';

class ZooPage extends StatefulWidget {
  const ZooPage({Key? key}) : super(key: key);

  @override
  _ZooPageState createState() => _ZooPageState();
}

class _ZooPageState extends State<ZooPage> {
  Widget getAnimalCard(String svgPath, String animalName) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Theme.of(context).unselectedWidgetColor,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 5,
            ),
          ],
        ),
        child: Center(
          child: SvgPicture.asset(
            svgPath,
            semanticsLabel: animalName,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

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
        return getAnimalCard(
            animals[index]['svg_path'], animals[index]['name']);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(jsonPath: 'assets/biomes_data.json'),
      body: FutureBuilder<Widget>(
        future: loadBiomeData(),
        builder:
            (BuildContext context, AsyncSnapshot<Widget> biomeWidgetSnapshot) {
          if (biomeWidgetSnapshot.connectionState == ConnectionState.waiting) {
            // The JSON file is still being loaded.
            return Center(child: CircularProgressIndicator());
          } else if (biomeWidgetSnapshot.connectionState ==
              ConnectionState.done) {
            // The JSON file is loaded.
            return biomeWidgetSnapshot.data ?? Center(child: Text('No data'));
          } else {
            // The JSON file could not be loaded or parsed.
            return Center(child: Text('Error: ${biomeWidgetSnapshot.error}'));
          }
        },
      ),
    );
  }
}
