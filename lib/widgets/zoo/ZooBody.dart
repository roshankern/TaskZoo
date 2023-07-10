import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:taskzoo/models/biomes_model.dart';

import 'package:taskzoo/notifiers/zoo_notifier.dart';

class ZooBody extends StatelessWidget {
  final Biomes biomesData;

  ZooBody({required this.biomesData});

  Widget getAnimalCard(BuildContext context, String svgPath, String animalName) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).unselectedWidgetColor,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).dividerColor.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: SvgPicture.asset(
          svgPath,
          semanticsLabel: animalName,
          fit: BoxFit.contain,
        ),
        ),
      ),
    );
  }

  Color _extractFillColor(String animalSvgString) {
    final fillAttributeRegex = RegExp(r'fill="([^"]+)"');
    final match = fillAttributeRegex.firstMatch(animalSvgString);
    final fillColor = match!.group(1);
    final rgbValues = fillColor!.substring(4, fillColor.length - 1).split(',');
    final red = int.parse(rgbValues[0].trim());
    final green = int.parse(rgbValues[1].trim());
    final blue = int.parse(rgbValues[2].trim());
    return Color.fromRGBO(red, green, blue, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    // get the ZooNotifier
    final zooNotifier = Provider.of<ZooNotifier>(context);

    // get the animals of the current biome
    final animals = biomesData.biomes[zooNotifier.currentBiome].animals;

    // rest of the code
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(20.0),
      itemCount: animals.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20.0,
        mainAxisSpacing: 20.0,
      ),
      itemBuilder: (BuildContext context, int index) {
        return getAnimalCard(
            context, animals[index].svgPath, animals[index].name);
      },
    );
  }
}
