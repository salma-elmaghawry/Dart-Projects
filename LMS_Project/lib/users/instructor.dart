import 'package:lms_project/lms_system.dart';

import '../enums/enums.dart';
import '../mixins/mixins.dart';
import '../models/course.dart';
import '../models/task.dart';
import 'user.dart';

class Instructor extends User with LoggerMixin {
  Instructor({
    required super.id,
    required super.name,
  }) : super(role: UserRole.instructor);

  void addTaskToCourse({
    required Course course,
    required Task task,
    required LMSSystem system,
  }) {
    course.addTask(task);
    log('AddTask', 'Added ${task.title} to ${course.title}');
    system.track('Instructor ${name} added task ${task.title}');
  }

  void changeTaskStatus({
    required Task task,
    required TaskStatus status,
    required LMSSystem system,
  }) {
    if (task.status == TaskStatus.blocked && status == TaskStatus.done) {
      log('TaskStatus', 'Cannot mark blocked task as done: ${task.title}');
      system.track('Blocked task prevented completion: ${task.title}');
      return;
    }
    task.status = status;
    log('TaskStatus', '${task.title} -> $status');
    system.track('Instructor ${name} set ${task.title} to $status');
  }

  @override
  void performAction(String action) {
    log('InstructorAction', '$name performs: $action');
  }
}
