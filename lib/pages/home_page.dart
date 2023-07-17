import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskzoo/widgets/home/Appbar.dart';
import 'package:taskzoo/widgets/tasks/add_task.dart';
import 'package:taskzoo/widgets/tasks/task.dart';
import 'package:taskzoo/widgets/tasks/task_card.dart';
import 'package:taskzoo/widgets/home/animal_builder.dart';
import 'package:hive/hive.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> selectedTags = [];
  ValueNotifier<String> selectedSchedule = ValueNotifier<String>('Daily');

  Future<Box<Task>> _openBox() async {
    final box = await Hive.openBox<Task>('tasks');
    return box;
  }

  @override
  void initState() {
    super.initState();
  }

  void _createTaskButton() async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddTaskSheet(),
    );
    if (result != null) {
      final newTask = Task(
        title: result['title'],
        tag: result['tag'],
        schedule: result['schedule'],
        daysOfWeek: result['daysOfWeek'],
        biDaily: result['biDaily'],
        weekly: result['weekly'],
        monthly: result['monthly'],
        timesPerMonth: result['timesPerMonth'],
        timesPerWeek: result['timesPerWeek'],
        isCompleted:
            false, // default values for properties not included in the form
        streakCount: 0,
        longestStreak: 0,
        isMeantForToday: false,
        currentCycleCompletions: 0,
        last30DaysDates: [],
        completionCount30days: 0,
        completedDates: [],
        previousDate: DateTime.now().toIso8601String(),
        nextCompletionDate: DateTime.now().toIso8601String(),
        isStreakContinued: false,
      );

      final box = Hive.box<Task>('tasks');
      await box.add(newTask);
    }
  }

  List<String> getAllTags(Box<Task> box) {
    final allTags = Set<String>();
    for (var task in box.values) {
      allTags.add(task.tag);
    }
    return allTags.toList();
  }

  List<Task> getFilteredTagTasks(String selectedSchedule, Box<Task> box) {
    return box.values
        .where((task) =>
            task.schedule == selectedSchedule &&
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Box<Task>>(
      future: _openBox(),
      builder: (context, AsyncSnapshot<Box<Task>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError)
            return Text('Error: ${snapshot.error}');
          else {
            var box = snapshot.data!;
            return Scaffold(
              appBar: CustomAppBar(
                onAddTaskPressed: _createTaskButton,
                selectedSchedule: selectedSchedule,
                onUpdateSelectedTags: updateSelectedTags,
                tasks: box.values.toList(),
              ),
              body: ValueListenableBuilder(
                valueListenable: selectedSchedule,
                builder: (context, String value, child) {
                  return ListView(
                    children: [
                      // Other widgets go here...
                      GridView.count(
                        key: ValueKey(box.values.length),
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        children:
                            getFilteredTagTasks(selectedSchedule.value, box)
                                .map((task) => TaskCard(task: task))
                                .toList(),
                      ),
                    ],
                  );
                },
              ),
            );
          }
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
