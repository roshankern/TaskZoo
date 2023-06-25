import 'package:flutter/material.dart';

// const selectedColor = Theme.of(context).indicatorColor;
const appBarSize = 40.0;

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  final VoidCallback onAddTaskPressed;

  const CustomAppBar({super.key, required this.onAddTaskPressed});

  @override
  _CustomAppBarState createState() =>
      // ignore: no_logic_in_create_state
      _CustomAppBarState(onAddTaskPressed: onAddTaskPressed);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  final VoidCallback onAddTaskPressed;
  int selectedIndex = 0;

  _CustomAppBarState({required this.onAddTaskPressed});

  void selectButton(int index) {
    setState(() {
      selectedIndex = index;
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
            onPressed: onAddTaskPressed,
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
