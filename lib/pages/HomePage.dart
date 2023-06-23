import 'package:flutter/material.dart';
import 'package:taskzoo/widgets/home/Appbar.dart';
import 'package:taskzoo/widgets/tasks/AddTask.dart';
import 'package:taskzoo/widgets/tasks/TaskCard.dart';
import 'package:taskzoo/widgets/home/AnimalBuilder.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<TaskCard> _tasks = [];
  final GlobalKey<AnimalBuilderState> _animalBuilderKey = GlobalKey();

  void _createTaskButton() async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return const AddTaskSheet();
      },
    );

    if (result != null) {
      setState(() {
        _tasks.add(TaskCard(
          title: result['title'],
          tag: result['tag'],
          daysOfWeek: result['daysOfWeek'],
          biDaily: result['biDaily'],
          weekly: result['weekly'],
          monthly: result['monthly'],
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(onAddTaskPressed: _createTaskButton),
        body: ListView(children: [
          AnimalBuilder(
            svgPath: "assets/low_poly_curled_fox.svg",
            biomeIcon: Icons.terrain_outlined,
            key: _animalBuilderKey,
          ),
          FloatingActionButton(
            onPressed: () => _animalBuilderKey.currentState?.addShape(),
            child: const Icon(Icons.add),
          ),
          GridView.count(
            key: ValueKey(_tasks.length),
            crossAxisCount: 2,
            shrinkWrap: true,
            children: _tasks,
          ),
        ]));
  }
}
