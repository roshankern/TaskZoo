import 'dart:collection';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taskzoo/widgets/tasks/edit_task.dart';
import 'package:taskzoo/widgets/tasks/task.dart';

String startOfWeek = "Monday";

class TaskCard extends StatefulWidget {
  final Task task;

  TaskCard({Key? key, required this.task}) : super(key: key);

  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _isTapped = false;
  late DateTime previousDate;
  late DateTime nextCompletionDate;
  late HashSet<DateTime> completedDates;

  @override
  void didUpdateWidget(TaskCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.task.title != oldWidget.task.title ||
        widget.task.tag != oldWidget.task.tag ||
        widget.task.daysOfWeek != oldWidget.task.daysOfWeek ||
        widget.task.biDaily != oldWidget.task.biDaily ||
        widget.task.weekly != oldWidget.task.weekly ||
        widget.task.monthly != oldWidget.task.monthly ||
        widget.task.timesPerMonth != oldWidget.task.timesPerMonth ||
        widget.task.timesPerWeek != oldWidget.task.timesPerWeek ||
        widget.task.schedule != oldWidget.task.schedule) {
      // Trigger an update by calling setState
      setState(() {});
    }
  }

  //Make modifications to previous date when storing data persistently
  @override
  void initState() {
    super.initState();
    previousDate = DateTime.parse(widget.task.previousDate);
    nextCompletionDate = DateTime.parse(widget.task.nextCompletionDate);
    completedDates = HashSet<DateTime>.from(
        widget.task.completedDates.map((date) => DateTime.parse(date)));

    nextCompletionDate = calculateNextCompletionDate(
        determineFrequency(
          widget.task.daysOfWeek,
          widget.task.biDaily,
          widget.task.weekly,
          widget.task.monthly,
        ),
        previousDate);
    widget.task.last30DaysDates = _getLast30DaysDates();
    widget.task.completionCount30days =
        _getCompletionCount(widget.task.last30DaysDates);
  }

  @override
  Widget build(BuildContext context) {
    String schedule = determineFrequency(
      widget.task.daysOfWeek,
      widget.task.biDaily,
      widget.task.weekly,
      widget.task.monthly,
    );

    String monthlyOrWeekly = (schedule == "monthly") ? "month" : "week";

    print("Created TaskCard");

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
        onLongPress: !widget.task.isCompleted && !_isTapped
            ? () {
                setState(() {
                  widget.task.isCompleted = true;
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
            opacity: widget.task.isMeantForToday ? 1 : 0.5,
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    if (!_isTapped)
                      Expanded(
                        flex: 6,
                        child: Center(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  widget.task.title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: widget.task.isMeantForToday
                                        ? Colors.black
                                        : Theme.of(context).dividerColor,
                                    fontSize: 20.0,
                                  ),
                                ),
                                Text(
                                  widget.task.tag,
                                  style: TextStyle(
                                    color: widget.task.isMeantForToday
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
                                        widget.task.streakCount.toString(),
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
                                        widget.task.longestStreak.toString(),
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
                                        widget.task.completionCount30days
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            : widget.task.isMeantForToday
                                ? !widget.task.isCompleted
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              const Icon(
                                                  FontAwesomeIcons.clock),
                                              const SizedBox(width: 8.0),
                                              Text(
                                                  _getTimeUntilNextCompletionDate()),
                                            ],
                                          ),
                                          if (_setCompletionStatus(schedule) >
                                              0)
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Text(
                                                '${_setCompletionStatus(schedule)} more this $monthlyOrWeekly',
                                              ),
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
                if (_isTapped)
                  Positioned(
                    top: 10.0,
                    right: 10.0,
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet<Map<String, dynamic>>(
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (BuildContext context) {
                            return EditTaskSheet(
                              title: widget.task.title,
                              tag: widget.task.tag,
                              daysOfWeek: widget.task.daysOfWeek,
                              biDaily: widget.task.biDaily,
                              weekly: widget.task.weekly,
                              monthly: widget.task.monthly,
                              timesPerWeek: widget.task.timesPerWeek,
                              timesPerMonth: widget.task.timesPerMonth,
                              onUpdateTask: (editedTaskData) {
                                if (editedTaskData != null) {
                                  // Update the task data in the TaskCard widget
                                  setState(() {
                                    widget.task.title = editedTaskData['title'];
                                    widget.task.tag = editedTaskData['tag'];
                                    widget.task.daysOfWeek =
                                        editedTaskData['daysOfWeek'];
                                    widget.task.biDaily =
                                        editedTaskData['biDaily'];
                                    widget.task.weekly =
                                        editedTaskData['weekly'];
                                    widget.task.monthly =
                                        editedTaskData['monthly'];
                                    widget.task.timesPerWeek =
                                        editedTaskData['timesPerWeek'];
                                    widget.task.timesPerMonth =
                                        editedTaskData['timesPerMonth'];
                                    widget.task.schedule =
                                        editedTaskData['schedule'];
                                    isCompletedFalse(schedule);
                                  });
                                }
                              },
                            );
                          },
                        );
                      },
                      child: const Icon(
                        Icons.edit,
                        color: Colors.grey,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Rest of the code remains the same...

  void isCompletedFalse(String schedule) {
    if (completedDates.isNotEmpty) {
      DateTime earliestDate =
          completedDates.reduce((a, b) => a.isBefore(b) ? a : b);
      completedDates.remove(earliestDate);
      setState(() {
        widget.task.isCompleted = false;
      });
    }
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

  String _getTimeUntilNextCompletionDate() {
    final now = DateTime.now();
    final difference = nextCompletionDate.difference(now);

    final days = difference.inDays;
    final hours = difference.inHours % 24;
    final minutes = difference.inMinutes % 60;

    if (days > 1) {
      return "$days days left";
    } else if (days == 1) {
      return "1 day left";
    } else if (hours > 0) {
      return "$hours hours left";
    } else {
      return "$minutes minutes left";
    }
  }

  List<String> _getLast30DaysDates() {
    final today = DateTime.now();
    final last30DaysDates = <String>[];
    for (int i = 0; i < 30; i++) {
      final date = today.subtract(Duration(days: i));
      last30DaysDates
          .add(DateTime(date.year, date.month, date.day).toIso8601String());
    }
    return last30DaysDates;
  }

  int _getCompletionCount(List<String> last30DaysDates) {
    int count = 0;
    for (final date in last30DaysDates) {
      if (completedDates.contains(DateTime.parse(date))) {
        count++;
      }
    }
    return count;
  }

  int _setCompletionStatus(String schedule) {
    int remainingCompletions = 0;
    if (schedule == "weekly") {
      if (widget.task.currentCycleCompletions < widget.task.timesPerWeek) {
        widget.task.isCompleted = false;
        remainingCompletions =
            widget.task.timesPerWeek - widget.task.currentCycleCompletions;
        return remainingCompletions;
      } else {
        return 0;
      }
    } else if (schedule == "monthly") {
      if (widget.task.currentCycleCompletions < widget.task.timesPerMonth) {
        widget.task.isCompleted = false;
        remainingCompletions =
            widget.task.timesPerMonth - widget.task.currentCycleCompletions;
        return remainingCompletions;
      } else {
        return 0;
      }
    } else {
      return -1;
    }
  }

  //TODO: Refactor this method before release
  void _streakAndStatsHandler(String schedule) {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day, 0, 0, 0);
    if (schedule == "daily") {
      widget.task.isStreakContinued = now.isBefore(nextCompletionDate);
      if (widget.task.isStreakContinued && widget.task.isCompleted) {
        if (!completedDates.contains(today)) {
          completedDates.add(today);
          widget.task.last30DaysDates = _getLast30DaysDates();
          widget.task.completionCount30days =
              _getCompletionCount(widget.task.last30DaysDates);
          widget.task.streakCount++;
          if (widget.task.streakCount > widget.task.longestStreak) {
            widget.task.longestStreak = widget.task.streakCount;
          }
          previousDate = today;
          nextCompletionDate =
              calculateNextCompletionDate(schedule, previousDate);
        }
      }
      if (!widget.task.isStreakContinued) {
        widget.task.streakCount = 0;
        nextCompletionDate =
            calculateNextCompletionDate(schedule, DateTime.now());
      }
    } else if (schedule == "custom") {
      //Requires further testing
      widget.task.isMeantForToday = widget.task.daysOfWeek[now.weekday - 1];
      widget.task.isStreakContinued =
          previousDate.isBefore(nextCompletionDate) ||
              !widget.task.isMeantForToday;
      if (widget.task.isStreakContinued &&
          widget.task.isCompleted &&
          widget.task.isMeantForToday) {
        if (!completedDates.contains(today)) {
          if (widget.task.isMeantForToday) {
            completedDates.add(today);
            widget.task.last30DaysDates = _getLast30DaysDates();
            widget.task.completionCount30days =
                _getCompletionCount(widget.task.last30DaysDates);
            widget.task.streakCount++;
            if (widget.task.streakCount > widget.task.longestStreak) {
              widget.task.longestStreak = widget.task.streakCount;
            }
            previousDate = today;
            nextCompletionDate =
                calculateNextCompletionDate(schedule, previousDate);
          }
        }
      }
      if (!widget.task.isStreakContinued) {
        widget.task.streakCount = 0;
        nextCompletionDate =
            calculateNextCompletionDate(schedule, DateTime.now());
      }
    } else if (schedule == "biDaily") {
      widget.task.isStreakContinued = now.isBefore(nextCompletionDate);
      if (widget.task.isStreakContinued && widget.task.isCompleted) {
        if (!completedDates.contains(today)) {
          completedDates.add(today);
          widget.task.last30DaysDates = _getLast30DaysDates();
          widget.task.completionCount30days =
              _getCompletionCount(widget.task.last30DaysDates);
          widget.task.streakCount++;
          if (widget.task.streakCount > widget.task.longestStreak) {
            widget.task.longestStreak = widget.task.streakCount;
          }
          previousDate = today;
          nextCompletionDate =
              calculateNextCompletionDate(schedule, previousDate);
        }
      }
      if (!widget.task.isStreakContinued) {
        widget.task.streakCount = 0;
        nextCompletionDate =
            calculateNextCompletionDate(schedule, DateTime.now());
      }
    } else if (schedule == "weekly") {
      widget.task.isStreakContinued = now.isBefore(nextCompletionDate);
      if (widget.task.isStreakContinued && widget.task.isCompleted) {
        if (!completedDates.contains(today)) {
          _getCompletionCount(widget.task.last30DaysDates);
          widget.task.currentCycleCompletions++;
          if (widget.task.currentCycleCompletions < widget.task.timesPerWeek) {
            return;
          }
          completedDates.add(today);
          widget.task.last30DaysDates = _getLast30DaysDates();
          widget.task.completionCount30days = widget.task.streakCount++;
          widget.task.longestStreak =
              max<int>(widget.task.longestStreak, widget.task.streakCount);
          previousDate = today;
          nextCompletionDate =
              calculateNextCompletionDate(schedule, previousDate);
        }
      }
      if (!widget.task.isStreakContinued) {
        widget.task.streakCount = 0;
        nextCompletionDate =
            calculateNextCompletionDate(schedule, DateTime.now());
      }
    } else if (schedule == "monthly") {
      widget.task.isStreakContinued = now.isBefore(nextCompletionDate);
      if (widget.task.isStreakContinued && widget.task.isCompleted) {
        if (!completedDates.contains(today)) {
          _getCompletionCount(widget.task.last30DaysDates);
          widget.task.currentCycleCompletions++;
          if (widget.task.currentCycleCompletions < widget.task.timesPerMonth) {
            return;
          }
          completedDates.add(today);
          widget.task.last30DaysDates = _getLast30DaysDates();
          widget.task.completionCount30days = widget.task.streakCount++;
          widget.task.longestStreak =
              max<int>(widget.task.longestStreak, widget.task.streakCount);
          previousDate = today;
          nextCompletionDate =
              calculateNextCompletionDate(schedule, previousDate);
        }
      }
      if (!widget.task.isStreakContinued) {
        widget.task.streakCount = 0;
        nextCompletionDate =
            calculateNextCompletionDate(schedule, DateTime.now());
      }
    }
  }

  //TODO: Remove Print Statements before release
  void _completionResetHandler() {
    if (widget.task.isCompleted &&
        !(completedDates.contains(DateTime(DateTime.now().year,
            DateTime.now().month, DateTime.now().day, 0, 0, 0)))) {
      print("resetting completion");
      print(completedDates);
      print(widget.task.isCompleted);
      widget.task.isCompleted = false;
    } else {
      print("No Reset");
      print(widget.task.isCompleted);
    }
  }

  DateTime calculateNextCompletionDate(
      String schedule, DateTime previousCompletionDate) {
    DateTime nextValidDate = previousCompletionDate;

    switch (schedule) {
      case 'daily':
        return previousCompletionDate.add(const Duration(days: 1));
      case 'custom':
        final mondayShifted = shiftRight(widget.task.daysOfWeek, 1);
        final daysOfWeek = widget.task.daysOfWeek;
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
        final currentDate = DateTime.now();
        final currentDay = currentDate.weekday;
        final daysUntilNextMonday = (8 - currentDay) % 7;
        final nextMonday = currentDate.add(Duration(days: daysUntilNextMonday));
        final nextMondayAtMidnight =
            DateTime(nextMonday.year, nextMonday.month, nextMonday.day);
        return nextMondayAtMidnight;

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
