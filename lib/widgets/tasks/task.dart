import 'package:isar/isar.dart';

part 'task.g.dart'; // This line will generate the adapter

@Collection()
class Task {
  Id id = Isar.autoIncrement;
  String title;

  @Index()
  String tag;

  @Index()
  String schedule;

  List<bool> daysOfWeek;

  bool biDaily;

  bool weekly;

  bool monthly;

  int timesPerMonth;

  int timesPerWeek;

  bool isCompleted;

  int streakCount;

  int longestStreak;

  bool isMeantForToday;

  int currentCycleCompletions;

  List<String> last30DaysDates;

  int completionCount30days;

  List<String> completedDates;

  String previousDate;

  String nextCompletionDate;

  bool isStreakContinued;

  int piecesObtained;

  Task({
    Id id = Isar.autoIncrement,
    required this.title,
    required this.tag,
    required this.schedule,
    required this.daysOfWeek,
    required this.biDaily,
    required this.weekly,
    required this.monthly,
    required this.timesPerMonth,
    required this.timesPerWeek,
    required this.isCompleted,
    required this.streakCount,
    required this.longestStreak,
    required this.isMeantForToday,
    required this.currentCycleCompletions,
    required this.last30DaysDates,
    required this.completionCount30days,
    required this.completedDates,
    required this.previousDate,
    required this.nextCompletionDate,
    required this.isStreakContinued,
    required this.piecesObtained,
  });
}
