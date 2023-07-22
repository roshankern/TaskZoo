import 'package:isar/isar.dart';
import 'package:taskzoo/widgets/tasks/task.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [TaskSchema],
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

  Future<List<Task>> getAllTasks() async {
    final isar = await db;
    //Returns a list of all tasks
    return await isar.tasks.where().findAll();
  }

  Future<void> saveTask(Task newTask) async {
    final isar = await db;
    //Return type int -> id of the inserted object
    isar.writeTxnSync<int>(() => isar.tasks.putSync(newTask));
  }

  Stream<List<Task>> getTasksBySchedule(String schedule) async* {
    final isar = await db;

    // Yield the current state of the database
    yield await isar.tasks.where().filter().scheduleEqualTo(schedule).findAll();

    // Set up a watcher that yields new data every time something changes in the database
    await for (var _
        in isar.tasks.where().filter().scheduleEqualTo(schedule).watch()) {
      yield await isar.tasks
          .where()
          .filter()
          .scheduleEqualTo(schedule)
          .findAll();
    }
  }

  Future<void> deleteTask(Task task) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.tasks.delete(task.id); // delete
    });
  }
}
