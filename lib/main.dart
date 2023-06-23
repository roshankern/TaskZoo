import 'package:flutter/material.dart';
import 'package:taskzoo/pages/HomePage.dart';
import 'package:taskzoo/pages/ZooPage.dart';
import 'package:taskzoo/pages/StatsPage.dart';
import 'package:taskzoo/pages/SettingsPage.dart';
import 'package:taskzoo/widgets/home/Navbar.dart';

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
  int _navBarIndex = 1;

  @override
  Widget build(BuildContext context) {
    final pages = [
      StatsPage(),
      HomePage(),
      ZooPage(),
      SettingsPage(),
    ];
    return Scaffold(
      body: pages[_navBarIndex],
      bottomNavigationBar: CustomNavBar(
        currentIndex: _navBarIndex,
        onTap: (index) {
          if (index==0 || index==3){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => pages[index]),
            );
          }else{
            setState(() {
            _navBarIndex = index;
          });
          }
        },
      ),
    );
  }
}
