import 'package:flutter/material.dart';
import 'package:taskzoo/widgets/Mainscreen/Appbar.dart';
import 'package:taskzoo/widgets/Mainscreen/DailyTaskCard.dart';
import 'package:taskzoo/widgets/Mainscreen/AnimalBuilder.dart';

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
        primaryColor: Colors.white,
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
  final List<DailyTaskCard> _tasks = [];
  final GlobalKey<AnimalBuilderState> _animalBuilderKey = GlobalKey();

  void _createTaskButton() async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      builder: (context) {
        return AddTaskSheet();
      },
    );

    if (result != null) {
      setState(() {
        _tasks.add(DailyTaskCard(
          title: result['title'],
          tag: result['tag'],
          daysOfWeek: result['daysOfWeek'],
          biDaily: result['biDaily'],
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

class AddTaskSheet extends StatefulWidget {
  const AddTaskSheet({Key? key}) : super(key: key);

  @override
  _AddTaskSheetState createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _tagController = TextEditingController();
  final List<bool> _daysOfWeek = List.filled(7, false);
  bool _biDaily = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                maxLength: maxCharLimit,
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Task Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a task name';
                  }
                  return null;
                },
              ),
              TextFormField(
                maxLength: maxCharLimit,
                controller: _tagController,
                decoration: InputDecoration(labelText: 'Tag Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a tag name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text('Select days of the week for the task:'),
              SizedBox(height: 8),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                alignment: WrapAlignment.spaceEvenly,
                children: [
                  for (int i = 0; i < 7; i++)
                    FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          _daysOfWeek[i] = !_daysOfWeek[i];
                        });
                      },
                      child: Text(
                        ['M', 'T', 'W', 'T', 'F', 'S', 'S'][i],
                        style: TextStyle(color: Colors.black),
                      ),
                      backgroundColor:
                          _daysOfWeek[i] ? Colors.green : Colors.grey,
                    ),
                ],
              ),
              SizedBox(height: 16),
              Text('BiDaily Option:'),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Off'),
                  SizedBox(width: 8),
                  Switch(
                    value: _biDaily,
                    onChanged: (value) {
                      setState(() {
                        _biDaily = value;
                      });
                    },
                  ),
                  SizedBox(width: 8),
                  Text('On'),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                child: Text('Add Task'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final taskData = {
                      'title': _titleController.text,
                      'tag': _tagController.text,
                      'daysOfWeek': _daysOfWeek,
                      'biDaily': _biDaily,
                    };
                    Navigator.pop(context, taskData);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
