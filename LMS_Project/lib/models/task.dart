import '../enums/enums.dart';

class Task {
  final int id;
  final String title;
  TaskStatus status;
  final int priority;

  Task({
    required this.id,
    required this.title,
    this.status = TaskStatus.todo,
    required this.priority,
  });
}
