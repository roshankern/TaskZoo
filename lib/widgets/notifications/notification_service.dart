import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:taskzoo/widgets/isar_service.dart';
import 'package:taskzoo/widgets/notifications/active_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> scheduleNotifications(
  List<bool> daysToSchedule,
  int taskId,
  String timeOfDayString,
  IsarService service,
) async {
  tz.initializeTimeZones();

  // Convert the Stringified TimeOfDay to TimeOfDay object
  TimeOfDay timeOfDay = TimeOfDay(
    hour: int.parse(timeOfDayString.substring(10, 12)),
    minute: int.parse(timeOfDayString.substring(13, 15)),
  );

  // Convert the TimeOfDay to DateTime
  DateTime notificationTime = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    timeOfDay.hour,
    timeOfDay.minute,
  );

  // Create a set to store the scheduled notification details
  Set<String> scheduledNotifications =
      await service.getNotificationIdsForTaskID(taskId);

  // Loop through the boolean list and schedule notifications for selected days
  for (int i = 0; i < daysToSchedule.length; i++) {
    if (daysToSchedule[i]) {
      final scheduledDateTime = tz.TZDateTime(
        tz.local,
        notificationTime.year,
        notificationTime.month,
        notificationTime.day +
            ((i - notificationTime.weekday + 8) %
                7), // Calculate the next occurrence of the selected day of the week
        timeOfDay.hour,
        timeOfDay.minute,
      );

      // Generate a unique key for the scheduled notification based on taskId and scheduled date
      final notificationKey = '$taskId-$scheduledDateTime';

      // Check if there is already a scheduled notification with the same key
      if (!scheduledNotifications.contains(notificationKey)) {
        // If a notification with the same key doesn't exist, schedule the notification
        await _scheduleNotificationForDay(
            scheduledDateTime, notificationKey.hashCode.abs());
        // Add the notification key to the set to mark it as scheduled
        scheduledNotifications.add(notificationKey);
        final activeNotifications = ActiveNotifications(
            taskid: taskId, notificationIds: scheduledNotifications.toList());
        service.saveActiveNotificationForTask(activeNotifications);
      }
    }
  }
}

Future<void> _scheduleNotificationForDay(
  DateTime scheduledDateTime,
  int taskId,
) async {
  const channelId = 'channel_id';
  const channelName = 'Channel Name';
  const channelDescription = 'Custom Notification Channel';

  // Android notification details
  const androidPlatformChannelSpecifics = AndroidNotificationDetails(
    channelId,
    channelName,
    channelDescription: channelDescription,
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',
    playSound: true,
    enableVibration: true,
    enableLights: true,
    color: Colors.blue,
    ledColor: Colors.white,
    ledOnMs: 1000,
    ledOffMs: 500,
  );

  // iOS and macOS notification details (using DarwinNotificationDetails)
  const iOSPlatformChannelSpecifics = DarwinNotificationDetails();

  // Combined notification details
  const platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: iOSPlatformChannelSpecifics,
  );

  // Calculate the difference between the scheduled date and the current date
  final difference = scheduledDateTime.difference(DateTime.now());

  // Schedule the notification
  await flutterLocalNotificationsPlugin.zonedSchedule(
    taskId, // Use the taskId as the unique ID for the notification
    'Scheduled Notification',
    'This is a scheduled notification',
    tz.TZDateTime.now(tz.local).add(difference),
    platformChannelSpecifics,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    androidAllowWhileIdle: true,
    matchDateTimeComponents: DateTimeComponents.time,
  );

  // Print statement to show when the notification has been scheduled
  print('Notification scheduled for taskId: $taskId, at: $scheduledDateTime');
}

Future<void> printAllScheduledNotifications() async {
  final List<PendingNotificationRequest> notifications =
      await flutterLocalNotificationsPlugin.pendingNotificationRequests();

  if (notifications.isEmpty) {
    print('No scheduled notifications.');
  } else {
    print('Scheduled Notifications:');
    for (final notification in notifications) {
      print('ID: ${notification.id}');
      print('Title: ${notification.title}');
      print('Body: ${notification.body}');
      print('Scheduled Date: ${notification.payload}');
      print('---');
    }
  }
}
