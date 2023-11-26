import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class TodosProvider with ChangeNotifier {
  TodosProvider() {
    init();
  }

  Isar? isar;

  List<TaskModel> _tasks = [];
  List<TaskModel> get tasks => _tasks;

  final taskFormKey = GlobalKey<FormState>();
  TextEditingController textfieldController = TextEditingController();
  String taskTextfieldValue = "";

  void init() async {
    final dir = await getApplicationCacheDirectory();

    isar ??= await Isar.open([TaskModelSchema], directory: dir.path);

    await isar!.txn(() async {
      final todosCollection = isar!.taskModels;
      _tasks = await todosCollection.where().findAll();
      notifyListeners();
    });
  }

  void update() {
    notifyListeners();
  }

  void addTask(TaskModel task) async {
    await isar!.writeTxn(() async {
      await isar!.taskModels.put(task);
    });
    _tasks.add(task);
    notifyListeners();
  }

  void toggleTask(TaskModel task) async {
    final taskIndex = _tasks.indexOf(task);
    await isar!.writeTxn(() async {
      TaskModel? todo = await isar!.taskModels.get(task.id);
      todo!.isDone = !todo.isDone;
      await isar!.taskModels.put(todo);
    });
    _tasks[taskIndex].toggleCompleted();
    notifyListeners();
  }

  void deleteTask(TaskModel task) async {
    await isar!.writeTxn(() async {
      bool deleted = await isar!.taskModels.delete(task.id);
      if (deleted) _tasks.remove(task);
      notifyListeners();
    });
  }
}
