
import 'package:lms_project/enums/enums.dart';
import 'package:lms_project/mixins/mixins.dart';
import 'package:lms_project/models/course.dart';
import 'package:lms_project/models/enrollment.dart';
import 'package:lms_project/users/user.dart';

class LMSSystem with TrackableMixin {
  final List<User> users = [];
  final List<Course> courses = [];
  final List<Enrollment> enrollments = [];

  void addUser(User user) {
    users.add(user);
  }

  void addCourse(Course course) {
    courses.add(course);
  }

  void addEnrollment(Enrollment enrollment) {
    enrollments.add(enrollment);
  }

  void printSummary() {
    print('--- LMS Summary ---');
    print('Users: ${users.length}');
    print('Courses: ${courses.length}');
    print('Enrollments: ${enrollments.length}');

    final taskStatusCounts = <TaskStatus, int>{};
    for (final course in courses) {
      for (final task in course.tasks) {
        taskStatusCounts[task.status] =
            (taskStatusCounts[task.status] ?? 0) + 1;
      }
    }
    print('Tasks by Status:');
    for (final status in TaskStatus.values) {
      final count = taskStatusCounts[status] ?? 0;
      print('- $status: $count');
    }

    final enrollmentStatusCounts = <EnrollmentStatus, int>{};
    for (final enrollment in enrollments) {
      enrollmentStatusCounts[enrollment.status] =
          (enrollmentStatusCounts[enrollment.status] ?? 0) + 1;
    }
    print('Enrollments by Status:');
    for (final status in EnrollmentStatus.values) {
      final count = enrollmentStatusCounts[status] ?? 0;
      print('- $status: $count');
    }

    print('--- Logs ---');
    if (history.isEmpty) {
      print('No logs recorded.');
    } else {
      for (final entry in history) {
        print(entry);
      }
    }
  }
}

