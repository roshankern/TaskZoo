import 'package:flutter/material.dart';
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
  int _selectedIcon = 0;  // index of the selected icon

  Future<Biomes> loadBiomes() async {
    String jsonString = await rootBundle.loadString(widget.jsonPath);
    final jsonData = json.decode(jsonString);
    //print(jsonData);
    final Biomes biomeData = Biomes.fromJson(jsonData);
    biomeData.printBiomes();
    return biomeData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Biomes>(
      future: loadBiomes(),
      builder: (BuildContext context, AsyncSnapshot<Biomes> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return AppBar(title: CircularProgressIndicator());
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            //print(snapshot.error);
            return AppBar(title: Text('Error: ${snapshot.error}'));
          }

          List<BiomeIcon> icons = [];
          snapshot.data!.biomes.forEach((key, value) {
            icons.add(value.icon);
          });

          return AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int i = 0; i < icons.length; i++)
                  IconButton(
                    // using network icon for the demo, you should load svg in your actual application
                    icon: ImageIcon(NetworkImage(icons[i].svgPath)),
                    color: _selectedIcon == i ? Colors.white : Colors.black,
                    onPressed: () => _updateSelectedIcon(i),
                  ),
              ],
            ),
          );
        } else {
          return AppBar(title: Text('Unexpected state'));
        }
      },
    );
  }

  void _updateSelectedIcon(int index) {
    setState(() {
      _selectedIcon = index;
    });
  }
}