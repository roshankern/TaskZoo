import 'package:flutter/material.dart';
import 'package:taskzoo/widgets/home/Appbar.dart';
import 'package:taskzoo/widgets/tasks/add_task.dart';
import 'package:taskzoo/widgets/tasks/task_card.dart';
import 'package:taskzoo/widgets/home/animal_builder.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<TaskCard> _tasks = [];
  final GlobalKey<AnimalBuilderState> _animalBuilderKey = GlobalKey();
  late String selectedSchedule;
  List<String> selectedTags = [];

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
          timesPerMonth: result['timesPerMonth'],
          timesPerWeek: result['timesPerWeek'],
          schedule: result['schedule'],
        ));
      });
    }

    List<String> getAllTags() {
      final Set<String> allTags = Set<String>();

      for (var task in _tasks) {
        allTags.add(task.tag);
      }

      return allTags.toList();
    }
  }

  List<TaskCard> getFilteredTagTasks(String selectedSchedule) {
    return _tasks
        .where((task) =>
            task.schedule == selectedSchedule &&
            (selectedTags.isEmpty ||
                selectedTags.any((tag) => task.tag.contains(tag))))
        .toList();
  }

  void updateSelectedSchedule(String schedule) {
    setState(() {
      selectedSchedule = schedule;
    });
  }

  void updateSelectedTags(List<String> tags) {
    setState(() {
      selectedTags = tags;
    });
  }

  @override
  void initState() {
    super.initState();
    selectedSchedule = 'Daily';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onAddTaskPressed: _createTaskButton,
        onSelectSchedule: updateSelectedSchedule,
        onUpdateSelectedTags: updateSelectedTags,
        tasks: _tasks,
      ),
      body: ListView(
        children: [
          AnimalBuilder(
            svgPath: "assets/biomes_data/mountain/wolf.svg",
            biomeIcon: Icons.terrain_outlined,
            backgroundColor: Color(0xffA1CC40),
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
            children: getFilteredTagTasks(selectedSchedule),
          ),
        ],
      ),
    );
  }
}
