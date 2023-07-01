import 'dart:collection';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

String startOfWeek = "Monday";

class TaskCard extends StatefulWidget {
  final String title;
  final String tag;
  final List<bool> daysOfWeek;
  final bool biDaily;
  final bool weekly;
  final bool monthly;
  final int timesPerMonth;
  final int timesPerWeek;
  bool isCompleted = false;
  int streakCount = 0;
  int longestStreak = 0;
  bool isMeantForToday = true;
  int currentCycleCompletions = 0;
  late List<DateTime> last30DaysDates;
  late int completionCount30days;
  late Set<DateTime> completedDates = HashSet<DateTime>();
  late DateTime previousDate = DateTime.now();
  late DateTime nextCompletionDate;
  late bool isStreakContinued;

  TaskCard({
    Key? key,
    required this.title,
    required this.tag,
    required this.daysOfWeek,
    required this.biDaily,
    required this.weekly,
    required this.monthly,
    required this.timesPerMonth,
    required this.timesPerWeek,
  }) : super(key: key);

  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _isTapped = false;

  late bool isStreakContinued;

  //Make modifications to previous date when storing data persistently
  @override
  void initState() {
    super.initState();
    widget.nextCompletionDate = calculateNextCompletionDate(
        determineFrequency(
          widget.daysOfWeek,
          widget.biDaily,
          widget.weekly,
          widget.monthly,
        ),
        widget.previousDate);
    widget.last30DaysDates = _getLast30DaysDates();
    widget.completionCount30days = _getCompletionCount(widget.last30DaysDates);
  }

  @override
  Widget build(BuildContext context) {
    String schedule = determineFrequency(
      widget.daysOfWeek,
      widget.biDaily,
      widget.weekly,
      widget.monthly,
    );

    String monthlyOrWeekly = (schedule == "monthly") ? "month" : "week";

    //Reset completion
    _completionResetHandler();

    //Handle setting and resetting stats based on the schedule
    _streakAndStatsHandler(schedule);

    //Handles Weekly/Monthly completions
    _setCompletionStatus(schedule);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isTapped = !_isTapped;
          });
        },
        onLongPress: !widget.isCompleted && !_isTapped
            ? () {
                setState(() {
                  widget.isCompleted = true;
                  _streakAndStatsHandler(schedule);
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
            opacity: widget.isMeantForToday ? 1 : 0.5,
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
                                color: widget.isMeantForToday
                                    ? Colors.black
                                    : Theme.of(context).dividerColor,
                                fontSize: 20.0,
                              ),
                            ),
                            Text(
                              widget.tag,
                              style: TextStyle(
                                color: widget.isMeantForToday
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
                                    widget.streakCount.toString(),
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
                                    widget.longestStreak.toString(),
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
                                    widget.completionCount30days.toString(),
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        : widget.isMeantForToday
                            ? !widget.isCompleted
                                ? Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          const Icon(FontAwesomeIcons.clock),
                                          const SizedBox(width: 8.0),
                                          Text(_getTimeUntilMidnight()),
                                        ],
                                      ),
                                      if (_setCompletionStatus(schedule) > 0)
                                        Text(
                                          '${_setCompletionStatus(schedule)} times left this $monthlyOrWeekly',
                                        ),
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
      if (widget.completedDates.contains(date)) {
        count++;
      }
    }
    return count;
  }

  int _setCompletionStatus(String schedule) {
    int remainingCompletions = 0;
    if (schedule == "weekly") {
      if (widget.currentCycleCompletions < widget.timesPerWeek) {
        widget.isCompleted = false;
        remainingCompletions =
            widget.timesPerWeek - widget.currentCycleCompletions;
        return remainingCompletions;
      } else {
        return 0;
      }
    } else if (schedule == "monthly") {
      if (widget.currentCycleCompletions < widget.timesPerMonth) {
        widget.isCompleted = false;
        remainingCompletions =
            widget.timesPerMonth - widget.currentCycleCompletions;
        return remainingCompletions;
      } else {
        return 0;
      }
    } else {
      return -1;
    }
  }

  void _streakAndStatsHandler(String schedule) {
    DateTime now = DateTime.now();
    if (schedule == "daily") {
      DateTime today = DateTime(now.year, now.month, now.day, 0, 0, 0);
      isStreakContinued = now.isBefore(widget.nextCompletionDate);
      if (isStreakContinued && widget.isCompleted) {
        if (!widget.completedDates.contains(today)) {
          widget.completedDates.add(today);
          widget.last30DaysDates = _getLast30DaysDates();
          widget.completionCount30days =
              _getCompletionCount(widget.last30DaysDates);
          widget.streakCount++;
          if (widget.streakCount > widget.longestStreak) {
            widget.longestStreak = widget.streakCount;
          }
          widget.previousDate = today;
          widget.nextCompletionDate =
              calculateNextCompletionDate(schedule, widget.previousDate);
        }
      }
      if (!isStreakContinued) {
        widget.streakCount = 0;
        widget.nextCompletionDate =
            calculateNextCompletionDate(schedule, DateTime.now());
      }
    } else if (schedule == "custom") {
      //Requires further testing
      DateTime today = DateTime(now.year, now.month, now.day, 0, 0, 0);
      widget.isMeantForToday = widget.daysOfWeek[now.weekday - 1];

      isStreakContinued =
          widget.previousDate.isBefore(widget.nextCompletionDate) ||
              !widget.isMeantForToday;
      if (isStreakContinued && widget.isCompleted && widget.isMeantForToday) {
        if (!widget.completedDates.contains(today)) {
          if (widget.isMeantForToday) {
            widget.completedDates.add(today);
            widget.last30DaysDates = _getLast30DaysDates();
            widget.completionCount30days =
                _getCompletionCount(widget.last30DaysDates);
            widget.streakCount++;
            if (widget.streakCount > widget.longestStreak) {
              widget.longestStreak = widget.streakCount;
            }
            widget.previousDate = today;
            widget.nextCompletionDate =
                calculateNextCompletionDate(schedule, widget.previousDate);
          }
        }
      }
      if (!isStreakContinued) {
        widget.streakCount = 0;
        widget.nextCompletionDate =
            calculateNextCompletionDate(schedule, DateTime.now());
      }
    } else if (schedule == "biDaily") {
      DateTime today = DateTime(now.year, now.month, now.day, 0, 0, 0);
      isStreakContinued = now.isBefore(widget.nextCompletionDate);
      if (isStreakContinued && widget.isCompleted) {
        if (!widget.completedDates.contains(today)) {
          widget.completedDates.add(today);
          widget.last30DaysDates = _getLast30DaysDates();
          widget.completionCount30days =
              _getCompletionCount(widget.last30DaysDates);
          widget.streakCount++;
          if (widget.streakCount > widget.longestStreak) {
            widget.longestStreak = widget.streakCount;
          }
          widget.previousDate = today;
          widget.nextCompletionDate =
              calculateNextCompletionDate(schedule, widget.previousDate);
        }
      }
      if (!isStreakContinued) {
        widget.streakCount = 0;
        widget.nextCompletionDate =
            calculateNextCompletionDate(schedule, DateTime.now());
      }
    } else if (schedule == "weekly") {
      DateTime today = DateTime(now.year, now.month, now.day, 0, 0, 0);
      isStreakContinued = now.isBefore(widget.nextCompletionDate);
      if (isStreakContinued && widget.isCompleted) {
        if (!widget.completedDates.contains(today)) {
          _getCompletionCount(widget.last30DaysDates);
          widget.currentCycleCompletions++;
          if (widget.currentCycleCompletions < widget.timesPerWeek) {
            return;
          }
          widget.completedDates.add(today);
          widget.last30DaysDates = _getLast30DaysDates();
          widget.completionCount30days = widget.streakCount++;
          widget.longestStreak = max(widget.longestStreak, widget.streakCount);
          widget.previousDate = today;
          widget.nextCompletionDate =
              calculateNextCompletionDate(schedule, widget.previousDate);
        }
      }
      if (!isStreakContinued) {
        widget.streakCount = 0;
        widget.nextCompletionDate =
            calculateNextCompletionDate(schedule, DateTime.now());
      }
    } else if (schedule == "monthly") {
      DateTime today = DateTime(now.year, now.month, now.day, 0, 0, 0);
      isStreakContinued = now.isBefore(widget.nextCompletionDate);
      if (isStreakContinued && widget.isCompleted) {
        if (!widget.completedDates.contains(today)) {
          _getCompletionCount(widget.last30DaysDates);
          widget.currentCycleCompletions++;
          if (widget.currentCycleCompletions < widget.timesPerMonth) {
            return;
          }
          widget.completedDates.add(today);
          widget.last30DaysDates = _getLast30DaysDates();
          widget.completionCount30days = widget.streakCount++;
          widget.longestStreak = max(widget.longestStreak, widget.streakCount);
          widget.previousDate = today;
          widget.nextCompletionDate =
              calculateNextCompletionDate(schedule, widget.previousDate);
        }
      }
      if (!isStreakContinued) {
        widget.streakCount = 0;
        widget.nextCompletionDate =
            calculateNextCompletionDate(schedule, DateTime.now());
      }
    }
  }

  void _completionResetHandler() {
    if (widget.isCompleted &&
        !(widget.completedDates.contains(DateTime(DateTime.now().year,
            DateTime.now().month, DateTime.now().day, 0, 0, 0)))) {
      print("resetting completion");
      print(widget.completedDates);
      print(widget.isCompleted);
      widget.isCompleted = false;
    } else {
      print("No Reset");
      print(widget.isCompleted);
    }
  }

  DateTime calculateNextCompletionDate(
      String schedule, DateTime previousCompletionDate) {
    DateTime nextValidDate = previousCompletionDate;

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
          return nextValidDate;
        }

        // Find the next true day of the week
        int count = 0;
        for (int i = nextValidDay; i < 7; i++) {
          count++;
          if (daysOfWeek[i]) {
            nextValidDate = DateTime(now.year, now.month, now.day + count)
                .add(const Duration(hours: 23, minutes: 59));
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
        return nextValidDate;

      case 'monthly':
        if (previousCompletionDate.month == 12) {
          nextValidDate = DateTime(previousCompletionDate.year + 1, 1, 1);
        } else {
          nextValidDate = DateTime(
              previousCompletionDate.year, previousCompletionDate.month + 1, 1);
        }
        return nextValidDate;
      case 'biDaily':
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
