import 'package:isar/isar.dart';
import 'package:taskzoo/widgets/stats/dailycompletions.dart';
import 'package:taskzoo/widgets/tasks/task.dart';
import 'package:path_provider/path_provider.dart';
import 'package:taskzoo/widgets/zoo/animalpieces.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [TaskSchema, AnimalPiecesSchema, DailyCompletionEntrySchema],
        inspector: true,
        directory: dir.path,
      );
    }

    return Future.value(Isar.getInstance());
  }

  Stream<List<Task>> listenToTasks() async* {
    final isar = await db;
    // Yield an initial event with the current state of the database
    yield await isar.tasks.where().findAll();

    // Set up a watcher that yields new data every time something changes in the database
    await for (var _ in isar.tasks.where().watch()) {
      yield await isar.tasks.where().findAll();
    }
  }

  Stream<List<Task>> getAllTasks() async* {
    final isar = await db;
    // Yield an initial event with the current state of the database
    yield await isar.tasks.where().findAll();

    // Set up a watcher that yields new data every time something changes in the database
    await for (var _ in isar.tasks.where().watch()) {
      yield await isar.tasks.where().findAll();
    }
  }

  Stream<int> countAllTasks() async* {
    final isar = await db;

    // Initial task count
    yield await isar.tasks.where().findAll().then((tasks) => tasks.length);

    // Watch for changes in the tasks and yield the updated count
    await for (var _ in isar.tasks.where().watch()) {
      yield await isar.tasks.where().findAll().then((tasks) => tasks.length);
    }
  }

  Stream<int> countAllCompletedTasks() async* {
    // Listen to the stream of tasks obtained from getAllTasks()
    await for (var tasks in getAllTasks()) {
      // When the stream emits new data, update the completedTaskCount
      yield await tasks.where((task) => task.isCompleted).length;
    }
  }

  Stream<double> percentTasksCompleted() async* {
    // Get the stream of tasks
    Stream<List<Task>> tasksStream = getAllTasks();

    int totalTaskCount = 0;
    int completedTaskCount = 0;

    // Listen to the stream of tasks
    await for (var tasks in tasksStream) {
      // When the stream emits new data, update the totalTaskCount and completedTaskCount
      totalTaskCount += tasks.length;
      completedTaskCount += tasks.where((task) => task.isCompleted).length;

      // Calculate the percentage and yield it
      if (totalTaskCount == 0) {
        yield 0;
        continue;
      }
      double percentage = (completedTaskCount / totalTaskCount) * 100;
      yield percentage;
    }
  }

  Stream<int> countTasks(String schedule, List<String> selectedTags) async* {
    // Watch for changes in the tasks and yield the updated count
    await for (var tasks
        in filterTasksByScheduleAndSelectedTags(schedule, selectedTags)) {
      yield tasks.length;
    }
  }

  Stream<int> countCompletedTasks(
      String schedule, List<String> selectedTags) async* {
    // Listen to the stream of tasks obtained from getAllTasks()
    await for (var tasks
        in filterTasksByScheduleAndSelectedTags(schedule, selectedTags)) {
      // When the stream emits new data, update the completedTaskCount
      yield tasks.where((task) => task.isCompleted).length;
    }
  }

  Future<int> getNumShapesFromAnimalPieces(String svgPath) async {
    final isar = await db;
    int svgPathId = svgPath.hashCode.abs();

    // Find the AnimalPieces item with the matching ID
    AnimalPieces? animalPieces = await isar.animalPieces
        .where()
        .filter()
        .idEqualTo(svgPathId)
        .findFirst();

    // If the AnimalPieces item exists, set the _numShapes variable to its 'pieces' value
    if (animalPieces != null) {
      animalPieces.pieces;
      return animalPieces.pieces;
      // Return the updated _numShapes value
    } else {
      // If the AnimalPieces item does not exist, return 0 or any other appropriate default value
      return 0;
    }
  }

  //If Task id not found in Schema Table, it will be added else replace value
  Future<void> saveTask(Task task) async {
    final isar = await db;
    //Return type int -> id of the inserted object
    isar.writeTxnSync<int>(() => isar.tasks.putSync(task));
  }

  Future<void> saveAnimalPieces(AnimalPieces tuple) async {
    final isar = await db;
    //Return type int -> id of the inserted object
    isar.writeTxnSync<int>(() => isar.animalPieces.putSync(tuple));
  }

  Stream<List<Task>> filterTasksByScheduleAndSelectedTags(
      String schedule, List<String> selectedTags) async* {
    final isar = await db;

    // Yield the current state of the database filtered by schedule
    var allTasks =
        await isar.tasks.where().filter().scheduleEqualTo(schedule).findAll();

    // pain there is no filtering by list of values >:(
    // Filter tasks by tags only if there are any selected tags
    var filteredTasks = selectedTags.isEmpty
        ? allTasks
        : allTasks.where((task) => selectedTags.contains(task.tag)).toList();
    yield filteredTasks;

    // Set up a watcher that yields new data every time something changes in the database
    await for (var _
        in isar.tasks.where().filter().scheduleEqualTo(schedule).watch()) {
      allTasks =
          await isar.tasks.where().filter().scheduleEqualTo(schedule).findAll();
      filteredTasks = selectedTags.isEmpty
          ? allTasks
          : allTasks.where((task) => selectedTags.contains(task.tag)).toList();
      yield filteredTasks;
    }
  }

  Future<void> deleteTask(Task task) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.tasks.delete(task.id); // deletes based off of id
    });
  }

  Future<void> saveDailyCompletionEntry(
      DailyCompletionEntry dailycompletion) async {
    final isar = await db;
    //Return type int -> id of the inserted object
    isar.writeTxnSync<int>(
        () => isar.dailyCompletionEntrys.putSync(dailycompletion));
  }

  Future<void> updateDailyCompletionEntry(bool shouldIncrement) async {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);

    final isar = await db;
    int encodedDate = encodeDate(today);

    DailyCompletionEntry? existingEntry = await isar.dailyCompletionEntrys
        .where()
        .idEqualTo(encodedDate)
        .findFirst();

    if (existingEntry != null) {
      // Entry already exists, increment the completion count
      double percent = await getCompletionPercentage();
      existingEntry.completionPercent = percent;
      if (shouldIncrement) {
        existingEntry.completionCount += 1;
      }
      await saveDailyCompletionEntry(existingEntry);
    } else {
      // Entry doesn't exist, create a new one with completionCount as 1
      double percent = await getCompletionPercentage();
      int startingCount = 0;
      if (shouldIncrement) {
        startingCount = 1;
      }
      DailyCompletionEntry newEntry = DailyCompletionEntry(
          id: encodedDate,
          date: today.toIso8601String(),
          completionCount: startingCount,
          completionPercent: percent);
      await saveDailyCompletionEntry(newEntry);
    }
  }

  Stream<List<int>> getCompletionCountsLast30Days() async* {
    final isar = await db;
    DateTime today = DateTime.now();

    // Calculate the cutoff date which is 30 days ago from today
    DateTime cutoffDate = today.subtract(Duration(days: 30));
    int cutoffEncodedDate = encodeDate(cutoffDate);

    // Query all entries with encodedDate greater than the cutoff date
    var entries = await isar.dailyCompletionEntrys
        .where()
        .idGreaterThan(cutoffEncodedDate)
        .findAll();

    // Extract the completionCount values from the entries
    List<int> completionCounts =
        entries.map((entry) => entry.completionCount).toList();

    // Yield the completionCounts list
    yield completionCounts;
  }

  //Function used to encode a specific date into a numerical value
  int encodeDate(DateTime date) {
    DateTime referenceDate = DateTime(0);
    int differenceInDays = date.difference(referenceDate).inDays;
    return differenceInDays;
  }

  //Function used to support stats Stream
  String formatDateToMonthDay(String isoString) {
    DateTime dateTime = DateTime.parse(isoString);
    String formattedDate = "${dateTime.month}/${dateTime.day}";
    return formattedDate;
  }

  Future<double> getCompletionPercentage() async {
    List<Task> allTasks = await getAllTasks().first;
    int completedTaskCount = allTasks.where((task) => task.isCompleted).length;
    double completionPercent = completedTaskCount / allTasks.length;
    return completionPercent;
  }

  List<int> getEncodedDatesForPast7Days() {
    DateTime now = DateTime.now();
    List<int> encodedDates = [];

    for (int i = 0; i < 7; i++) {
      DateTime currentDate = now.subtract(Duration(days: i));
      int encodedDate = encodeDate(currentDate);
      encodedDates.add(encodedDate);
    }

    return encodedDates;
  }

  List<String> getDecodedDatesForPast7Days() {
    DateTime now = DateTime.now();
    List<String> encodedDates = [];

    for (int i = 0; i < 7; i++) {
      DateTime currentDate = now.subtract(Duration(days: i));
      encodedDates.add(currentDate.toIso8601String());
    }

    return encodedDates;
  }

  String getWeekday(String isoString) {
    DateTime dateTime = DateTime.parse(isoString);
    String weekday = '';

    switch (dateTime.weekday) {
      case DateTime.monday:
        weekday = 'Monday';
        break;
      case DateTime.tuesday:
        weekday = 'Tuesday';
        break;
      case DateTime.wednesday:
        weekday = 'Wednesday';
        break;
      case DateTime.thursday:
        weekday = 'Thursday';
        break;
      case DateTime.friday:
        weekday = 'Friday';
        break;
      case DateTime.saturday:
        weekday = 'Saturday';
        break;
      case DateTime.sunday:
        weekday = 'Sunday';
        break;
    }

    return weekday;
  }

// Function to compute completion percentage for past 7 days
  Stream<Map<String, double>> getCompletionPercentForPast7Days() async* {
    List<int> encodedDates = getEncodedDatesForPast7Days();
    List<String> decodedDates = getDecodedDatesForPast7Days();

    Map<String, double> completionData = {};

    final isar = await db;

    int i = 0;
    for (int encodedDate in encodedDates) {
      DailyCompletionEntry? entry = await isar.dailyCompletionEntrys
          .where()
          .idEqualTo(encodedDate)
          .findFirst();

      //String key = formatDateToMonthDay(decodedDates[i]);
      String key = getWeekday(decodedDates[i]);
      double completionPercent = entry?.completionPercent ?? 0.0;

      completionData[key] = completionPercent;
      i += 1;
    }

    // Yield the completion data map
    yield completionData;
  }
}
