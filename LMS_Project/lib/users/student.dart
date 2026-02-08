import 'package:lms_project/lms_system.dart';

import '../enums/enums.dart';
import '../mixins/mixins.dart';
import '../models/course.dart';
import '../models/enrollment.dart';
import '../models/task.dart';
import 'user.dart';

class Student extends User with TrackableMixin {
  final List<Enrollment> enrollments = [];

  Student({
    required super.id,
    required super.name,
  }) : super(role: UserRole.student);

  Enrollment enrollInCourse({
    required Course course,
    required LMSSystem system,
  }) {
    final enrollment = Enrollment(studentId: id, courseId: course.id);
    enrollments.add(enrollment);
    system.addEnrollment(enrollment);
    track('Enrolled in ${course.title}');
    system.track('Student ${name} enrolled in ${course.title}');
    return enrollment;
  }

  void completeTask({
    required Course course,
    required Task task,
    required LMSSystem system,
  }) {
    if (task.status == TaskStatus.blocked) {
      track('Attempted blocked task: ${task.title}');
      system.track('Student ${name} attempted blocked task');
      return;
    }
    task.status = TaskStatus.done;
    track('Completed task: ${task.title}');
    system.track('Student ${name} completed ${task.title}');
  }

  void updateProgress({
    required Enrollment enrollment,
    required Course course,
    required LMSSystem system,
  }) {
    final increment = switch (course.level) {
      CourseLevel.beginner => 20,
      CourseLevel.intermediate => 15,
      CourseLevel.advanced => 10,
    };
    enrollment.addProgress(increment);
    track('Progress updated to ${enrollment.progress}% in ${course.title}');
    system.track('Progress ${enrollment.progress}% for ${name}');

    final allDone = course.tasks.isNotEmpty &&
        course.tasks.every((task) => task.status == TaskStatus.done);
    if (allDone) {
      enrollment.progress = 100;
      enrollment.status = EnrollmentStatus.completed;
      track('Completed course: ${course.title}');
      system.track('Enrollment completed for ${name}');
    }
  }

  @override
  void performAction(String action) {
    track('$name performs: $action');
  }
}
