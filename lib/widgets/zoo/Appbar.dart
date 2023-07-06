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
    final backgroundSvgPath = biomes[_selectedIcon].backgroundSvgPath;

    return SafeArea(
  top: false,  // We don't want to apply padding at the top
  child: Container(
    height: 280,
    child: Stack(
      alignment: Alignment.bottomRight,
      children: [
        Positioned.fill(
            child: SvgPicture.asset(
              backgroundSvgPath,
              fit: BoxFit.fitWidth,
            ),
          ),
        AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: icons.map((BiomeIcon) {
              int iconIndex = icons.indexOf(BiomeIcon);
              return IconButton(
                icon: SvgPicture.asset(
                  BiomeIcon.svgPath,
                  colorFilter: ColorFilter.mode(
                      _selectedIcon == iconIndex ? Colors.white : Colors.black,
                      BlendMode.srcIn),
                ),
                onPressed: () {
                  setState(() {
                    _selectedIcon = iconIndex;
                  });
                },
              );
            }).toList(),
          ),
        ),
      ],
    ),
  ),
);

  }
}



