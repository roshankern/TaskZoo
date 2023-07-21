import 'package:hive/hive.dart';
import 'dart:collection';

part 'task.g.dart'; // This line will generate the adapter

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String tag;
  @HiveField(2)
  String schedule;
  @HiveField(3)
  List<bool> daysOfWeek;
  @HiveField(4)
  bool biDaily;
  @HiveField(5)
  bool weekly;
  @HiveField(6)
  bool monthly;
  @HiveField(7)
  int timesPerMonth;
  @HiveField(8)
  int timesPerWeek;
  @HiveField(9)
  bool isCompleted;
  @HiveField(10)
  int streakCount;
  @HiveField(11)
  int longestStreak;
  @HiveField(12)
  bool isMeantForToday;
  @HiveField(13)
  int currentCycleCompletions;
  @HiveField(14)
  List<String> last30DaysDates;
  @HiveField(15)
  int completionCount30days;
  @HiveField(16)
  List<String> completedDates;
  @HiveField(17)
  String previousDate;
  @HiveField(18)
  String nextCompletionDate;
  @HiveField(19)
  bool isStreakContinued;
  @HiveField(20)
  int piecesObtained;

  Task({
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
