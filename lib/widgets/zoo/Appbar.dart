import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:taskzoo/models/biomes_model.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Biomes biomesData;

  CustomAppBar({required this.biomesData});

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  int _selectedIcon = 0; // index of the selected icon

  @override
  Widget build(BuildContext context) {
    final biomes = widget.biomesData.biomes;
    final icons = biomes.map((biome) => biome.icon).toList();
    print(icons);

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: icons.map((BiomeIcon) {
          return IconButton(
            icon: SvgPicture.asset(BiomeIcon.svgPath), 
            onPressed: () {
              int iconIndex = icons.indexOf(BiomeIcon);
              setState(() {
                _selectedIcon = iconIndex;
              });
            },
            color: _selectedIcon == icons.indexOf(BiomeIcon) ? Colors.white : Colors.black,
          );
        }).toList(),
      ),
    );
  }

}
