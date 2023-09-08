import 'package:flutter/material.dart';
import 'package:dimensions_theme/dimensions_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskzoo/main.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;

class CustomNavBar extends StatefulWidget {
  // icon sizes
  final double dotIconSize = 10;
  final double otherIconSize = 25;

  final int currentIndex;
  final Function onTap;
  final bool isFirstTime;

  CustomNavBar(
      {required this.currentIndex,
      required this.onTap,
      required this.isFirstTime});

  @override
  _CustomNavBarState createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  void askForNotiPerms() async {
    tz.initializeTimeZones();
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(
            'app_icon'); // Replace 'app_icon' with the app's icon name also make sure to add the icon to android/app/src/main/res/drawable

    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {},
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void onOnboardingComplete(BuildContext context) async {
    askForNotiPerms();
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('is_first_time', false);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => MyHomePage(title: 'TaskZoo Task Page')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      child: SafeArea(
        child: Container(
          height: 50,
          color: Theme.of(context).cardColor,
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.of(context).insets.medium),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (widget.isFirstTime) {
                        onOnboardingComplete(context);
                      } else {
                        Navigator.pop(context);
                        askForNotiPerms();
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.of(context).insets.medium),
                      child: Text(
                        'Skip',
                        style: TextStyle(
                            color: Theme.of(context).dividerColor,
                            fontSize: 18),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (widget.currentIndex < 4) {
                        widget.onTap(widget.currentIndex + 1);
                      } else {
                        if (widget.isFirstTime) {
                          onOnboardingComplete(context);
                        } else {
                          Navigator.pop(context);
                          askForNotiPerms();
                        }
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text('Next', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ],
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      color: widget.currentIndex == 0
                          ? Theme.of(context).indicatorColor
                          : Theme.of(context).dividerColor,
                      icon: const Icon(Icons.circle),
                      onPressed: () {
                        widget.onTap(0);
                      },
                      iconSize: widget.dotIconSize,
                      padding: EdgeInsets.all(5),
                      constraints: BoxConstraints(),
                    ),
                    IconButton(
                      color: widget.currentIndex == 1
                          ? Theme.of(context).indicatorColor
                          : Theme.of(context).dividerColor,
                      icon: const Icon(Icons.circle),
                      onPressed: () {
                        widget.onTap(1);
                      },
                      iconSize: widget.dotIconSize,
                      padding: EdgeInsets.all(5),
                      constraints: BoxConstraints(),
                    ),
                    IconButton(
                      color: widget.currentIndex == 2
                          ? Theme.of(context).indicatorColor
                          : Theme.of(context).dividerColor,
                      icon: const Icon(Icons.circle),
                      onPressed: () {
                        widget.onTap(2);
                      },
                      iconSize: widget.dotIconSize,
                      padding: EdgeInsets.all(5),
                      constraints: BoxConstraints(),
                    ),
                    IconButton(
                      color: widget.currentIndex == 3
                          ? Theme.of(context).indicatorColor
                          : Theme.of(context).dividerColor,
                      icon: const Icon(Icons.circle),
                      onPressed: () {
                        widget.onTap(3);
                      },
                      iconSize: widget.dotIconSize,
                      padding: EdgeInsets.all(5),
                      constraints: BoxConstraints(),
                    ),
                    IconButton(
                      color: widget.currentIndex == 4
                          ? Theme.of(context).indicatorColor
                          : Theme.of(context).dividerColor,
                      icon: const Icon(Icons.circle),
                      onPressed: () {
                        widget.onTap(4);
                      },
                      iconSize: widget.dotIconSize,
                      padding: EdgeInsets.all(5),
                      constraints: BoxConstraints(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
