import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

String startOfWeek = "Tuesday";

class TaskCard extends StatefulWidget {
  final String title;
  final String tag;
  final List<bool> daysOfWeek;
  final bool biDaily;
  final bool weekly;
  final bool monthly;
  final int daysPerMonth;
  final int daysPerWeek;

  const TaskCard({
    Key? key,
    required this.title,
    required this.tag,
    required this.daysOfWeek,
    required this.biDaily,
    required this.weekly,
    required this.monthly,
    required this.daysPerMonth,
    required this.daysPerWeek,
  }) : super(key: key);

  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool isCompleted = false;
  bool isVisible = false;
  late DateTime previousDate;
  bool _isTapped = false;
  late Set<DateTime> completedDates;
  int streakCount = 0;
  int longestStreak = 0;

  @override
  void initState() {
    super.initState();
    previousDate = DateTime.now();
    completedDates = HashSet<DateTime>();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    bool isTodayInDaysOfWeek = widget.daysOfWeek[now.weekday - 1];
    final last30DaysDates = _getLast30DaysDates();
    final completionCount = _getCompletionCount(last30DaysDates);

    String schedule = determineFrequency(
      widget.daysOfWeek,
      widget.biDaily,
      widget.weekly,
      widget.monthly,
    );

    //TODO: Implement Streaks functionality based on schedule here:
    DateTime nextCompletionDate =
        calculateNextCompletionDate(schedule, previousDate);
    bool isStreakContinued = now.isBefore(nextCompletionDate);

    if (isStreakContinued) {
      if (completedDates.contains(now)) {
        streakCount++;
        if (streakCount > longestStreak) {
          longestStreak = streakCount;
        }
      }
    } else {
      streakCount = 0;
    }

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isTapped = !_isTapped;
          });
        },
        onLongPress: isTodayInDaysOfWeek && !_isTapped
            ? () {
                setState(() {
                  isCompleted = true;
                  completedDates.add(now);
                });
              }
            : null,
        child: Container(
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Theme.of(context).unselectedWidgetColor,
          ),
          child: Opacity(
            opacity: isTodayInDaysOfWeek ? 1 : 0.5,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (!_isTapped)
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
                                    : Theme.of(context).dividerColor,
                                fontSize: 20.0,
                              ),
                            ),
                            Text(
                              widget.tag,
                              style: TextStyle(
                                color: isTodayInDaysOfWeek
                                    ? Colors.grey
                                    : Theme.of(context).dividerColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                if (!_isTapped)
                  Container(
                    height: 1.0,
                    color: Theme.of(context).dividerColor,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  ),
                Expanded(
                  flex: 4,
                  child: Center(
                    child: _isTapped
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.local_fire_department,
                                    color: Colors.orange,
                                  ),
                                  const SizedBox(width: 8.0),
                                  Text(
                                    '$streakCount',
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                  const SizedBox(width: 8.0),
                                  Text(
                                    '$longestStreak',
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.calendar_month,
                                    color: Colors.green,
                                  ),
                                  const SizedBox(width: 8.0),
                                  Text(
                                    '$completionCount',
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        : isTodayInDaysOfWeek
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
                            : const Text('Relax, not for today'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String determineFrequency(
    List<bool> daysOfWeek,
    bool biDaily,
    bool weekly,
    bool monthly,
  ) {
    if (daysOfWeek.any((day) => day == true)) {
      return 'custom';
    } else if (weekly) {
      return 'weekly';
    } else if (monthly) {
      return 'monthly';
    } else if (biDaily) {
      return 'biDaily';
    } else {
      return 'daily';
    }
  }

  String _getTimeUntilMidnight() {
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day + 1);
    final difference = midnight.difference(now);
    final hours = difference.inHours;
    final minutes = difference.inMinutes % 60;
    return hours > 0 ? "$hours hours left" : "$minutes minutes left";
  }

  List<DateTime> _getLast30DaysDates() {
    final today = DateTime.now();
    final last30DaysDates = <DateTime>[];
    for (int i = 0; i < 30; i++) {
      final date = today.subtract(Duration(days: i));
      last30DaysDates.add(DateTime(date.year, date.month, date.day));
    }
    return last30DaysDates;
  }

  int _getCompletionCount(List<DateTime> last30DaysDates) {
    int count = 0;
    for (final date in last30DaysDates) {
      if (completedDates.contains(date)) {
        count++;
      }
    }
    return count;
  }

  DateTime calculateNextCompletionDate(
      String schedule, DateTime previousCompletionDate) {
    DateTime nextValidDate = previousCompletionDate;
    print("invoked");
    print(schedule);
    switch (schedule) {
      case 'daily':
        return previousCompletionDate.add(const Duration(days: 1));
      case 'custom':
        final mondayShifted = shiftRight(widget.daysOfWeek, 1);
        final daysOfWeek = widget.daysOfWeek;
        final currentDay = previousCompletionDate.weekday;
        final nextValidDay = (currentDay) % 7; // Get the next day index
        final now = DateTime.now();

        if (mondayShifted[nextValidDay] == true) {
          nextValidDate = DateTime(now.year, now.month, now.day)
              .add(const Duration(hours: 23, minutes: 59));
          // print("Today's the day");
          // print(widget.daysOfWeek);
          // print('Next valid date: $nextValidDate');
          // print(DateFormat('EEEE').format(nextValidDate));
          return nextValidDate;
        }

        // Find the next true day of the week
        int count = 0;
        for (int i = nextValidDay; i < 7; i++) {
          count++;
          if (daysOfWeek[i]) {
            nextValidDate = DateTime(now.year, now.month, now.day + count)
                .add(const Duration(hours: 23, minutes: 59));
            // print("In at least a few days");
            // print(widget.daysOfWeek);
            // print('Next valid date: $nextValidDate');
            // print(DateFormat('EEEE').format(nextValidDate));
            break;
          }
        }
        return nextValidDate;
      case 'weekly':
        final currentDay = previousCompletionDate.weekday;
        final nextValidDay = _getNextValidDay(currentDay, startOfWeek);
        final daysToAdd = _getDaysToAdd(currentDay, nextValidDay);

        nextValidDate = previousCompletionDate.add(Duration(days: daysToAdd));
        nextValidDate = _getStartOfWeek(nextValidDate, startOfWeek);

        // print("Next week's start: $nextValidDate");
        return nextValidDate;

      case 'monthly':
        if (previousCompletionDate.month == 12) {
          nextValidDate = DateTime(previousCompletionDate.year + 1, 1, 1);
        } else {
          nextValidDate = DateTime(
              previousCompletionDate.year, previousCompletionDate.month + 1, 1);
        }
        // print("Next month's start: $nextValidDate");
        return nextValidDate;
      case 'bidaily':
        return previousCompletionDate.add(const Duration(days: 2));
      default:
        return previousCompletionDate.add(const Duration(days: 1));
    }
  }

  int _getNextValidDay(int currentDay, String startOfWeek) {
    final daysOfWeek = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday"
    ];
    final startDayIndex = daysOfWeek.indexOf(startOfWeek);
    final nextValidDayIndex = (startDayIndex + 7 - currentDay) % 7;
    return nextValidDayIndex;
  }

  int _getDaysToAdd(int currentDay, int nextValidDay) {
    return nextValidDay >= currentDay
        ? nextValidDay - currentDay
        : (nextValidDay + 7) - currentDay;
  }

  DateTime _getStartOfWeek(DateTime date, String startOfWeek) {
    final daysOfWeek = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday"
    ];
    final startDayIndex = daysOfWeek.indexOf(startOfWeek);
    final currentDayIndex = date.weekday - 1;
    final daysToAdd = startDayIndex >= currentDayIndex
        ? startDayIndex - currentDayIndex
        : (startDayIndex + 7) - currentDayIndex;
    return date.add(Duration(days: daysToAdd));
  }

  List<bool> shiftRight(List<bool> array, int n) {
    List<bool> shiftedArray = List.from(array);
    final int size = array.length;

    for (int i = 0; i < size; i++) {
      int newIndex = (i + n) % size;
      shiftedArray[newIndex] = array[i];
    }

    return shiftedArray;
  }
}
