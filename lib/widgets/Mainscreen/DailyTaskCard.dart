import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const cardColor = Color.fromRGBO(175, 210, 210, 1);
const lineColor = Color.fromRGBO(140, 146, 146, 1);

class DailyTaskCard extends StatefulWidget {
  final String title;
  final String tag;
  final List<bool> daysOfWeek;

  DailyTaskCard(
      {required this.title, required this.tag, required this.daysOfWeek});

  @override
  _DailyTaskCardState createState() => _DailyTaskCardState();
}

class _DailyTaskCardState extends State<DailyTaskCard> {
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    // Determine if today is in daysOfWeek
    final now = DateTime.now();
    final isTodayInDaysOfWeek = widget.daysOfWeek[now.weekday - 1];

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onLongPress: isTodayInDaysOfWeek
            ? () {
                setState(() {
                  isCompleted = !isCompleted;
                });
              }
            : null,
        child: Container(
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: cardColor,
          ),
          child: Opacity(
            opacity: isTodayInDaysOfWeek ? 1 : 0.5,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 6,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isTodayInDaysOfWeek
                                  ? Colors.black
                                  : lineColor,
                              fontSize: 20.0,
                            ),
                          ),
                          Text(
                            widget.tag,
                            style: TextStyle(
                              color:
                                  isTodayInDaysOfWeek ? Colors.grey : lineColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 1.0,
                  color: lineColor,
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                ),
                Expanded(
                  flex: 4,
                  child: Center(
                    child: isTodayInDaysOfWeek
                        ? !isCompleted
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const Icon(FontAwesomeIcons.clock),
                                  const SizedBox(width: 8.0),
                                  Text(_getTimeUntilMidnight()),
                                ],
                              )
                            : const Icon(
                                FontAwesomeIcons.check,
                                color: Colors.black,
                              )
                        : Text('Relax, not for today'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getTimeUntilMidnight() {
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day + 1);
    final difference = midnight.difference(now);
    final hours = difference.inHours;
    final minutes = difference.inMinutes % 60;
    return hours > 0 ? "$hours hours left" : "$minutes minutes left";
  }
}
