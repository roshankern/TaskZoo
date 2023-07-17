import 'package:flutter/material.dart';
import 'package:taskzoo/widgets/tasks/task.dart';

const double appBarSize = 40.0;

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final VoidCallback onAddTaskPressed;
  final ValueNotifier<String> selectedSchedule;
  final Function(List<String>) onUpdateSelectedTags;
  final List<Task> tasks;

  const CustomAppBar({
    Key? key,
    required this.onAddTaskPressed,
    required this.selectedSchedule,
    required this.onUpdateSelectedTags,
    required this.tasks,
  }) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  int selectedIndex = 0;
  List<String> selectedTags = [];

  void selectButton(int index) {
    setState(() {
      selectedIndex = index;
      if (index == 0) {
        widget.selectedSchedule.value = 'Daily';
      } else if (index == 1) {
        widget.selectedSchedule.value = 'Weekly';
      } else if (index == 2) {
        widget.selectedSchedule.value = 'Monthly';
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
                key: ValueKey('D-${selectedIndex == 0}'), // add ValueKey
                label: 'D',
                isSelected: selectedIndex == 0,
                onTap: () => selectButton(0),
              ),
              const SizedBox(width: 8),
              CircleButton(
                key: ValueKey('W-${selectedIndex == 1}'),
                label: 'W',
                isSelected: selectedIndex == 1,
                onTap: () => selectButton(1),
              ),
              const SizedBox(width: 8),
              CircleButton(
                key: ValueKey('M-${selectedIndex == 2}'),
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
              showTagDropdown(context, selectedTags);
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

  void showTagDropdown(BuildContext context, List<String> selectedTags) {
    final List<String> allTags = getAllTags();
    bool hasTasks = allTags.isNotEmpty;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Tags',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (hasTasks)
                    Expanded(
                      child: ListView.builder(
                        itemCount: allTags.length,
                        itemBuilder: (BuildContext context, int index) {
                          final tag = allTags[index];
                          final bool isSelected = selectedTags.contains(tag);
                          return ListTile(
                            title: Text(
                              tag,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            trailing: Checkbox(
                              value: isSelected,
                              onChanged: (bool? value) {
                                setState(() {
                                  if (value == true) {
                                    selectedTags.add(tag);
                                  } else {
                                    selectedTags.remove(tag);
                                  }
                                });
                              },
                            ),
                            onTap: () {
                              setState(() {
                                if (isSelected) {
                                  selectedTags.remove(tag);
                                } else {
                                  selectedTags.add(tag);
                                }
                              });
                            },
                          );
                        },
                      ),
                    ),
                  if (!hasTasks)
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Add Tasks To Filter By Tags',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 32.0),
                    child: ElevatedButton(
                      onPressed: hasTasks
                          ? () {
                              widget.onUpdateSelectedTags(selectedTags);
                              Navigator.of(context).pop();
                            }
                          : null,
                      child: const Text('Done'),
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 32.0),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
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
    Key? key, // Add key parameter
    required this.label,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key); // Pass key to superclass

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
          color: isSelected ? Colors.black : Colors.white,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
