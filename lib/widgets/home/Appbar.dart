import 'package:flutter/material.dart';
import 'package:taskzoo/widgets/tasks/task_card.dart';

const double appBarSize = 40.0;

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final VoidCallback onAddTaskPressed;
  final Function(String) onSelectSchedule;
  final Function(List<String>) onUpdateSelectedTags;
  final List<TaskCard> tasks;

  const CustomAppBar({
    Key? key,
    required this.onAddTaskPressed,
    required this.onSelectSchedule,
    required this.onUpdateSelectedTags,
    required this.tasks,
  }) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  int selectedIndex = 0;
  List<String> selectedTags = [];

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
              showTagDropdown(context);
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

  void showTagDropdown(BuildContext context) {
    final List<String> allTags = getAllTags();

    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (BuildContext context, setState) {
            return Container(
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Tags',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                  ...allTags.map((tag) {
                    return CheckboxListTile(
                      title: Text(tag),
                      value: selectedTags.contains(tag),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            selectedTags.add(tag);
                          } else {
                            selectedTags.remove(tag);
                          }
                        });
                      },
                    );
                  }).toList(),
                  ElevatedButton(
                    onPressed: () {
                      widget.onUpdateSelectedTags(selectedTags);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Done'),
                  ),
                ],
              ),
            );
          });
        });
  }

  List<String> getAllTags() {
    final Set<String> allTags = Set<String>();

    for (var task in widget.tasks) {
      allTags.add(task.tag);
    }

    return allTags.toList();
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
