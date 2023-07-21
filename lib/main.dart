import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:taskzoo/pages/home_page.dart';
import 'package:taskzoo/pages/zoo_page.dart';
import 'package:taskzoo/pages/stats_page.dart';
import 'package:taskzoo/pages/settings_page.dart';

import 'package:taskzoo/widgets/home/navbar.dart';

import 'package:taskzoo/notifiers/zoo_notifier.dart';
import 'package:taskzoo/widgets/tasks/task.dart';

const maxCharLimit = 20;
const selectedColor = Colors.black;
const lineColor = const Color(0xff8c9292);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);

  Hive.registerAdapter<Task>(TaskAdapter());

  try {
    // Open the 'tasks' box
    if (Hive.isBoxOpen('tasks')) {
      await Hive.box('tasks').close();
    }
    await Hive.openBox<Task>('tasks');

    // Open the 'settings' box
    if (Hive.isBoxOpen('settings')) {
      await Hive.box('settings').close();
    }
    var settingsBox = await Hive.openBox('settings');

    // Check if the settings keys exist, if not, put the default values
    checkAndSetDefaultSettings(settingsBox);
  } catch (e) {
    print('Failed to open box: $e');
  }

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
        scaffoldBackgroundColor: Colors.white,
        //unslectedWidgetColor is for icons when unselected
        unselectedWidgetColor: Color.fromARGB(255, 201, 201, 201),
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
  int _navBarIndex = 1;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController =
        PageController(initialPage: _navBarIndex - 1); // Adjust the initialPage
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(),
      ChangeNotifierProvider(
        create: (context) => ZooNotifier(),
        child: const ZooPage(),
      ),
    ];
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _navBarIndex = index + 1;
          });
        },
        children: pages,
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndex: _navBarIndex,
        onTap: (index) {
          if (index == 0 || index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      index == 0 ? const StatsPage() : const SettingsPage()),
            );
          } else {
            _pageController.jumpToPage(index - 1);
          }
        },
      ),
    );
  }
}

void checkAndSetDefaultSettings(Box<dynamic> settingsBox) {
  // Check if the settings keys exist, if not, put the default values
  if (!settingsBox.containsKey('weekdayStart')) {
    settingsBox.put('weekdayStart', 'Monday');
  }

  if (!settingsBox.containsKey('biome')) {
    settingsBox.put('biome', 'Forest');
  }
}
