import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:taskzoo/models/biomes_model.dart';

import 'package:taskzoo/notifiers/zoo_notifier.dart';

class ZooBody extends StatelessWidget {
  final Biomes biomesData;

  ZooBody({required this.biomesData});

  Widget getAnimalCard(BuildContext context, String svgPath, String animalName) {
    return Padding(
      padding: const EdgeInsets.all(00.0),
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
      padding: EdgeInsets.all(30.0),
      itemCount: animals.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 30.0,
        mainAxisSpacing: 30.0,
      ),
      itemBuilder: (BuildContext context, int index) {
        return getAnimalCard(context, animals[index].svgPath, animals[index].name);
      },
    );
  }
}