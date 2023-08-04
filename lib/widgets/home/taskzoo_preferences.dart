import 'package:isar/isar.dart';

part 'taskzoo_preferences.g.dart';

@Collection()
class TaskzooPreferences {
  @Index()
  Id taskid;

  int value;

  TaskzooPreferences({
    required this.taskid,
    required this.value,
  });
}
