import 'package:flutter/material.dart';
import 'package:taskzoo/widgets/home/Appbar.dart';
import 'package:taskzoo/widgets/tasks/AddTask.dart';
import 'package:taskzoo/widgets/tasks/TaskCard.dart';
import 'package:taskzoo/widgets/home/AnimalBuilder.dart';

const maxCharLimit = 20;
const selectedColor = Colors.black;
const backgroundColor = Color.fromRGBO(141, 183, 182, 1);
const unselectedColor = Color.fromRGBO(175, 210, 210, 1);
const lineColor = Color.fromRGBO(140, 146, 146, 1);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TaskZoo',
      theme: ThemeData(
        //primaryColor is for items when selected
        primaryColor: backgroundColor,
        //scaffoldBackgroundColor is for the background
        scaffoldBackgroundColor: backgroundColor,
        //unslectedWidgetColor is for icons when unselected
        unselectedWidgetColor: unselectedColor,
        //dividerColor is for the lines
        dividerColor: lineColor,
        //IndicatorColor is for Icons
        indicatorColor: Colors.black,
        //dialogBackgroundColor is for extras, selections & containers
        dialogBackgroundColor: Colors.black,
      ),
      home: const MyHomePage(title: 'TaskZoo Task Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
