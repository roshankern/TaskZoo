import 'package:flutter/material.dart';
import 'package:taskzoo/widgets/Mainscreen/Appbar.dart';
import 'package:taskzoo/widgets/Mainscreen/DailyTaskCard.dart';
import 'package:taskzoo/widgets/Mainscreen/AnimalBuilder.dart';

const maxCharLimit = 20;
const backgroundColor = Color.fromRGBO(141, 183, 182, 1);

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
        primaryColor: backgroundColor,
        scaffoldBackgroundColor: backgroundColor,
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
  final String originalSvgString = '''
<?xml version="1.0" encoding="utf-8"?>
<svg viewBox="0 0 500 500" xmlns="http://www.w3.org/2000/svg" xmlns:bx="https://boxy-svg.com">
  <path d="M 149.822 118.52 L 205.517 273.012 L 94.126 273.012 L 149.822 118.52 Z" style="" bx:shape="triangle 94.126 118.52 111.391 154.492 0.5 0 1@83216011"/>
  <path d="M 250.744 264.674 L 306.439 419.166 L 195.048 419.166 L 250.744 264.674 Z" style="fill: rgb(4, 0, 255);" bx:shape="triangle 195.048 264.674 111.391 154.492 0.5 0 1@1a79f46a"/>
  <path d="M 149.822 118.52 L 205.517 273.012 L 94.126 273.012 L 149.822 118.52 Z" style="fill: rgb(255, 0, 0);" transform="matrix(1, 0, 0, 1, 189.62174350698075, 6.294651852412102)" bx:shape="triangle 94.126 118.52 111.391 154.492 0.5 0 1@83216011"/>
</svg>
''';

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
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(onAddTaskPressed: _createTaskButton),
      body: AnimalBuilder(originalSvgString: originalSvgString,),
    );
  }
}

class AddTaskSheet extends StatefulWidget {
  const AddTaskSheet({super.key});

  @override
  _AddTaskSheetState createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _tagController = TextEditingController();
  final List<bool> _daysOfWeek = List.filled(7, false);

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
                  )
              ],
            ),
            ElevatedButton(
              child: Text('Add Task'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final taskData = {
                    'title': _titleController.text,
                    'tag': _tagController.text,
                    'daysOfWeek': _daysOfWeek,
                  };
                  Navigator.pop(context, taskData);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
