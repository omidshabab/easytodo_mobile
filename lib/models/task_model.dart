import 'package:isar/isar.dart';

part 'task_model.g.dart';

@collection
class TaskModel {
  Id id = Isar.autoIncrement;

  late String title;

  late bool isDone = false;

  void toggleCompleted() {
    isDone = !isDone;
  }
}
