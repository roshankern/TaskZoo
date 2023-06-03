import 'package:flutter/material.dart';
import 'package:taskzoo/widgets/DailyTaskCard.dart';

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
        primaryColor: Colors.lightBlue,
        scaffoldBackgroundColor: Colors.lightBlue,
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
  int _counter = 0;

  void _createTaskButton() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0,
        backgroundColor: Colors.lightBlue,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(_counter, (index) {
          return DailyTaskCard(
            title: 'Task $index',
            tag: 'Tag $index',
            daysOfWeek: List.generate(
                7,
                (index) =>
                    false), // assuming task needs to be completed everyday
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createTaskButton,
        tooltip: 'Create Task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
