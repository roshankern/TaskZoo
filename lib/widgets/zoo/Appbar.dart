import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  int _selectedIcon = 0;  // index of the selected icon

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent, // make AppBar clear
      elevation: 0, // remove shadow
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (int i = 0; i < 3; i++)
            IconButton(
              icon: _getIcon(i),
              color: _selectedIcon == i ? Colors.white : Colors.black,
              onPressed: () => _updateSelectedIcon(i),
            ),
        ],
      ),
    );
  }

  Icon _getIcon(int index) {
    switch (index) {
      case 0:
        return Icon(Icons.ac_unit);
      case 1:
        return Icon(Icons.sunny);
      case 2:
        return Icon(Icons.landscape);
      default:
        return Icon(Icons.error); // return error icon if index is out of range
    }
  }

  void _updateSelectedIcon(int index) {
    setState(() {
      _selectedIcon = index;
    });
  }
}
