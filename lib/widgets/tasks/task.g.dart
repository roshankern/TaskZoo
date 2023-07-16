// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskAdapter extends TypeAdapter<Task> {
  @override
  final int typeId = 0;

  @override
  Task read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Task(
      title: fields[0] as String,
      tag: fields[1] as String,
      schedule: fields[2] as String,
      daysOfWeek: (fields[3] as List).cast<bool>(),
      biDaily: fields[4] as bool,
      weekly: fields[5] as bool,
      monthly: fields[6] as bool,
      timesPerMonth: fields[7] as int,
      timesPerWeek: fields[8] as int,
      isCompleted: fields[9] as bool,
      streakCount: fields[10] as int,
      longestStreak: fields[11] as int,
      isMeantForToday: fields[12] as bool,
      currentCycleCompletions: fields[13] as int,
      last30DaysDates: (fields[14] as List).cast<String>(),
      completionCount30days: fields[15] as int,
      completedDates: (fields[16] as List).cast<String>(),
      previousDate: fields[17] as String,
      nextCompletionDate: fields[18] as String,
      isStreakContinued: fields[19] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer
      ..writeByte(20)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.tag)
      ..writeByte(2)
      ..write(obj.schedule)
      ..writeByte(3)
      ..write(obj.daysOfWeek)
      ..writeByte(4)
      ..write(obj.biDaily)
      ..writeByte(5)
      ..write(obj.weekly)
      ..writeByte(6)
      ..write(obj.monthly)
      ..writeByte(7)
      ..write(obj.timesPerMonth)
      ..writeByte(8)
      ..write(obj.timesPerWeek)
      ..writeByte(9)
      ..write(obj.isCompleted)
      ..writeByte(10)
      ..write(obj.streakCount)
      ..writeByte(11)
      ..write(obj.longestStreak)
      ..writeByte(12)
      ..write(obj.isMeantForToday)
      ..writeByte(13)
      ..write(obj.currentCycleCompletions)
      ..writeByte(14)
      ..write(obj.last30DaysDates)
      ..writeByte(15)
      ..write(obj.completionCount30days)
      ..writeByte(16)
      ..write(obj.completedDates)
      ..writeByte(17)
      ..write(obj.previousDate)
      ..writeByte(18)
      ..write(obj.nextCompletionDate)
      ..writeByte(19)
      ..write(obj.isStreakContinued);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
