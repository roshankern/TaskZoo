import 'package:isar/isar.dart';
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
        [TaskSchema, AnimalPiecesSchema],
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
}
