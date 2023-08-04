import 'package:isar/isar.dart';

part 'active_notifications.g.dart'; // This line will generate the adapter

@Collection()
class ActiveNotifications {
  @Index()
  Id taskid;

  List<String> notificationIds = [];

  ActiveNotifications({
    required this.taskid,
    required this.notificationIds,
  });
}
