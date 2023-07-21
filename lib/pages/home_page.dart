import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskzoo/widgets/home/Appbar.dart';
import 'package:taskzoo/widgets/stats/task_info_bar.dart';
import 'package:taskzoo/widgets/tasks/add_task.dart';
import 'package:taskzoo/widgets/tasks/rear_task_card_item.dart';
import 'package:taskzoo/widgets/tasks/task.dart';
import 'package:taskzoo/widgets/tasks/task_card.dart';
import 'package:taskzoo/widgets/home/animal_builder.dart';
import 'package:hive/hive.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List<String> selectedTags = [];
  ValueNotifier<String> selectedSchedule = ValueNotifier<String>('Daily');
  final GlobalKey<AnimalBuilderState> _animalBuilderKey = GlobalKey();

  String getMidnightIso8601String() {
    DateTime now = DateTime.now();
    DateTime midnight = DateTime(now.year, now.month, now.day, 0, 0, 0);
    String iso8601String = midnight.toIso8601String();
    return iso8601String;
  }

  void _createTaskButton() {
    showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddTaskSheet(),
    );
  }

  List<Task> getFilteredTagTasks(
      ValueNotifier<String> selectedSchedule, Box<Task> box) {
    return box.values
        .where((task) =>
            task.schedule == selectedSchedule.value &&
            (selectedTags.isEmpty ||
                selectedTags.any((tag) => task.tag.contains(tag))))
        .toList();
  }

  void updateSelectedSchedule(ValueNotifier<String> schedule) {
    selectedSchedule = schedule;
  }

  void updateSelectedTags(List<String> tags) {
    setState(() {
      selectedTags = tags;
    });
  }

  double getTaskCompletionPercent(String schedule) {
    // Get the 'tasks' box
    final box = Hive.box<Task>('tasks');

    // Get all tasks of the specified schedule
    final tasks =
        box.values.where((task) => task.schedule == schedule).toList();

    // Check if there are no tasks of the specified schedule
    if (tasks.isEmpty) {
      return 0.0;
    }

    // Get all completed tasks of the specified schedule
    final completedTasks =
        tasks.where((task) => task.isCompleted == true).toList();

    // Calculate the percent of completed tasks
    final completionPercent = completedTasks.length / tasks.length;

    return completionPercent;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Box<Task>>(
      future: Hive.openBox<Task>('tasks'),
      builder: (BuildContext context, AsyncSnapshot<Box<Task>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final box = snapshot.data!;
            return Column(
              children: <Widget>[
                Expanded(
                  child: StreamBuilder(
                    stream: box.watch(),
                    builder: (context, snapshot) {
                      return Scaffold(
                        appBar: CustomAppBar(
                          onAddTaskPressed: _createTaskButton,
                          selectedSchedule: selectedSchedule,
                          onUpdateSelectedTags: updateSelectedTags,
                          tasks: box.values.toList(),
                        ),
                        body: ListView(
                          children: [
                            const RearTaskCard(
                              icons: [
                                RearTaskCardIcon(
                                  icon: Icon(FontAwesomeIcons.puzzlePiece,
                                      color: Colors.black),
                                  text: "10",
                                ),
                                RearTaskCardIcon(
                                  icon: Icon(FontAwesomeIcons.percent,
                                      color: Colors.black),
                                  text: "3",
                                ),
                                RearTaskCardIcon(
                                  icon: Icon(FontAwesomeIcons.list,
                                      color: Colors.black),
                                  text: "5",
                                ),
                              ],
                            ),
                            ValueListenableBuilder<String>(
                              valueListenable: selectedSchedule,
                              builder: (context, value, child) {
                                return GridView.count(
                                  key: ValueKey(box.values.length),
                                  crossAxisCount: 2,
                                  shrinkWrap: true,
                                  children:
                                      getFilteredTagTasks(selectedSchedule, box)
                                          .map((task) => TaskCard(task: task))
                                          .toList(),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
