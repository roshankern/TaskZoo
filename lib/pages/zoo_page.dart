import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:taskzoo/widgets/zoo/Appbar.dart';
import 'package:taskzoo/widgets/zoo/ZooBody.dart';
import 'package:taskzoo/models/biomes_model.dart';

class ZooPage extends StatefulWidget {
  const ZooPage({Key? key}) : super(key: key);

  @override
  _ZooPageState createState() => _ZooPageState();
}

class _ZooPageState extends State<ZooPage> {
  late Future<Biomes> _biomesFuture;

  @override
  void initState() {
    super.initState();
    _biomesFuture = loadBiomesData('assets/biomes_data.json');
  }

  Future<Biomes> loadBiomesData(String jsonPath) async {
    String jsonString = await rootBundle.loadString(jsonPath);
    final jsonData = json.decode(jsonString);
    final biomesData = Biomes.fromJson(jsonData);

    return biomesData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Biomes>(
      future: _biomesFuture,
      builder: (BuildContext context, AsyncSnapshot<Biomes> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error loading data'),
            ),
          );
        } else {
          return Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            appBar: CustomAppBar(biomesData: snapshot.data!),
            body: ListView(
              padding: EdgeInsets.only(top: 0),
              children: [
                SvgPicture.asset(
                  snapshot.data!.biomes[0].backgroundSvgPath,
                  fit: BoxFit.fitHeight,
                ),
                ZooBody(biomesData: snapshot.data!)
              ],
            ),
          );
        }
      },
    );
  }
}
