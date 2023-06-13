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
  final List<DailyTaskCard> _tasks = [];
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
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text(
                    'Add a New Task',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: backgroundColor,
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildTextField('Task Name', _titleController),
                  const SizedBox(height: 16),
                  _buildTextField('Tag Name', _tagController),
                  const SizedBox(height: 16),
                  ExpansionPanelList(
                    elevation: 1,
                    expandedHeaderPadding: const EdgeInsets.all(0),
                    dividerColor: Colors.transparent,
                    expansionCallback: (int index, bool isExpanded) =>
                        setState(() => _isExpanded = !isExpanded),
                    children: [
                      ExpansionPanel(
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return const ListTile(
                            title: Text('Additional Options',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                          );
                        },
                        body: Column(
                          children: [
                            _buildDaySelector(),
                            Divider(color: Theme.of(context).dividerColor),
                            const SizedBox(height: 16),
                            _buildBiDailySwitch(),
                          ],
                        ),
                        isExpanded: _isExpanded,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildSubmitButton(context),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextFormField(
      maxLength: maxCharLimit,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a $label';
        }
        return null;
      },
    );
  }

  Widget _buildDaySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Select days of the week for the task:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          alignment: WrapAlignment.spaceEvenly,
          children: [
            for (int i = 0; i < 7; i++)
              ChoiceChip(
                label: Text(
                  ['M', 'T', 'W', 'T', 'F', 'S', 'S'][i],
                  style: TextStyle(
                      color: _daysOfWeek[i] ? Colors.white : Colors.black),
                ),
                selected: _daysOfWeek[i],
                selectedColor: Theme.of(context).primaryColor,
                onSelected: (selected) {
                  setState(() {
                    _daysOfWeek[i] = selected;
                  });
                },
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildBiDailySwitch() {
    return SwitchListTile(
      title: const Text('BiDaily Option:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      value: _biDaily,
      onChanged: (value) {
        setState(() {
          _biDaily = value;
        });
      },
      activeColor: Theme.of(context).primaryColor,
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).primaryColor,
        onPrimary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 32.0),
      ),
      child: const Text('Add Task'),
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
    );
  }
}
