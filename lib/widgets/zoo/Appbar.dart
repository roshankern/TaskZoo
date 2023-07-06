import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

import 'package:taskzoo/models/biomes_model.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String jsonPath;

  CustomAppBar({required this.jsonPath});

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  int _selectedIcon = 0; // index of the selected icon
  late Future<Biomes> _biomesFuture;

  @override
  void initState() {
    super.initState();
    _biomesFuture = loadBiomesData(widget.jsonPath);
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
          return AppBar(
            title: Text('Loading...'),
          );
        } else if (snapshot.hasData) {
          final biomes = snapshot.data!.biomes;
          final icons = biomes.map((biome) => biome.icon).toList();

          return AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(icons.length, (index) {
                final BiomeIcon = icons[index];
                return IconButton(
                  icon: SvgPicture.asset(BiomeIcon.svgPath), 
                  onPressed: () {
                    setState(() {
                      _selectedIcon = index;
                    });
                  },
                  color: _selectedIcon == index ? Colors.white : Colors.black,
                );
              }),
            ),
          );
        } else {
          return AppBar(
            title: Text('Error loading data'),
          );
        }
      },
    );
  }
}
