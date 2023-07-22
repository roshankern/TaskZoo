import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taskzoo/widgets/home/Appbar.dart';
import 'package:taskzoo/widgets/stats/task_info_bar.dart';
import 'package:taskzoo/widgets/tasks/add_task.dart';
import 'package:taskzoo/widgets/tasks/rear_task_card_item.dart';
import 'package:taskzoo/widgets/tasks/task.dart';
import 'package:taskzoo/widgets/tasks/task_card.dart';
import 'package:taskzoo/widgets/home/animal_builder.dart';
import 'package:taskzoo/widgets/isar_service.dart';

class HomePage extends StatefulWidget {
  final IsarService service;
  HomePage({Key? key, required this.service}) : super(key: key);

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
      builder: (context) => AddTaskSheet(widget.service),
    );
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
    return Scaffold(
        appBar: CustomAppBar(
          onAddTaskPressed: _createTaskButton,
          selectedSchedule: selectedSchedule,
          onUpdateSelectedTags: updateSelectedTags,
          tasks: widget.service.getAllTasks(),
        ),
        body: ValueListenableBuilder<String>(
          valueListenable: selectedSchedule,
          builder: (context, value, child) {
            return StreamBuilder<List<Task>>(
              stream: widget.service
                  .filterTasksByScheduleAndSelectedTags(value, selectedTags),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
                if (snapshot.hasData) {
                  final tasks = snapshot.data!;
                  return GridView.count(
                    crossAxisCount: 2,
                    children: tasks
                        .map((task) =>
                            TaskCard(task: task, service: widget.service))
                        .toList(),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return const CircularProgressIndicator();
                }
              },
            );
          },
        ));
  }
}
