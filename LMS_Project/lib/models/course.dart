import '../enums/enums.dart';
import 'task.dart';

class Course {
  final int id;
  final String title;
  final CourseLevel level;
  late List<Task> tasks;

  Course({
    required this.id,
    required this.title,
    required this.level,
    List<Task>? tasks,
  }) {
    this.tasks = tasks ?? [];
  }

  void addTask(Task task) {
    tasks.add(task);
  }
}
