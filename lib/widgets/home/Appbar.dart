import 'package:flutter/material.dart';

const double appBarSize = 40.0;

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final VoidCallback onAddTaskPressed;
  final Function(String) onSelectSchedule;

  const CustomAppBar({
    Key? key,
    required this.onAddTaskPressed,
    required this.onSelectSchedule,
  }) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  int selectedIndex = 0;

  void selectButton(int index) {
    setState(() {
      selectedIndex = index;
      if (index == 0) {
        widget.onSelectSchedule('Daily');
      } else if (index == 1) {
        widget.onSelectSchedule('Weekly');
      } else if (index == 2) {
        widget.onSelectSchedule('Monthly');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      title: Row(
        children: [
          Row(
            children: [
              CircleButton(
                label: 'D',
                isSelected: selectedIndex == 0,
                onTap: () => selectButton(0),
              ),
              const SizedBox(width: 8),
              CircleButton(
                label: 'W',
                isSelected: selectedIndex == 1,
                onTap: () => selectButton(1),
              ),
              const SizedBox(width: 8),
              CircleButton(
                label: 'M',
                isSelected: selectedIndex == 2,
                onTap: () => selectButton(2),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            iconSize: appBarSize / 1.5,
            icon: const Icon(Icons.keyboard_control),
            color: Theme.of(context).indicatorColor,
            onPressed: () {
              // Perform settings action
            },
          ),
          Container(
            width: 1,
            height: appBarSize,
            color: Theme.of(context).indicatorColor,
            margin: const EdgeInsets.symmetric(horizontal: 8),
          ),
          IconButton(
            iconSize: appBarSize / 1.5,
            icon: const Icon(Icons.add),
            color: Theme.of(context).indicatorColor,
            onPressed: widget.onAddTaskPressed,
          ),
        ],
      ),
    );
  }
}

class CircleButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const CircleButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: appBarSize,
        height: appBarSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Theme.of(context).dialogBackgroundColor,
            width: 1,
          ),
          color: isSelected
              ? Theme.of(context).dialogBackgroundColor
              : Theme.of(context).unselectedWidgetColor,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected
                  ? Colors.white
                  : Theme.of(context).dialogBackgroundColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
