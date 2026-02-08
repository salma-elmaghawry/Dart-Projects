import 'dart:io';
import 'package:lms_project/lms_system.dart';
import 'package:lms_project/users/student.dart';
import 'package:lms_project/models/course.dart';
import 'package:lms_project/models/task.dart';
import 'package:lms_project/models/enrollment.dart';

class StudentMenu {
  final LMSSystem system;
  final Map<int, Student> students;
  final Map<int, Course> courses;

  StudentMenu({
    required this.system,
    required this.students,
    required this.courses,
  });

  void show() {
    if (students.isEmpty) {
      print('No students available. Create one first from Admin Menu.');
      return;
    }

    print('\n--- Available Students ---');
    students.forEach((id, student) {
      print('$id: ${student.name}');
    });

    final studentId = int.tryParse(_getUserInput('Select Student ID: ')) ?? 0;
    final student = students[studentId];

    if (student == null) {
      print('Student not found.');
      return;
    }

    bool inStudentMenu = true;
    while (inStudentMenu) {
      print('\n--- Student: ${student.name} ---');
      print('1. Enroll in Course');
      print('2. Complete Task');
      print('3. View Profile');
      print('4. Back to Main Menu');

      final choice = _getUserInput('Enter your choice: ');

      switch (choice) {
        case '1':
          _enrollInCourse(student);
          break;
        case '2':
          _completeTask(student);
          break;
        case '3':
          student.viewProfile();
          break;
        case '4':
          inStudentMenu = false;
          break;
        default:
          print('Invalid choice.');
      }
    }
  }

  void _enrollInCourse(Student student) {
    if (courses.isEmpty) {
      print('No courses available. Create one first from Admin Menu.');
      return;
    }

    print('\n--- Available Courses ---');
    courses.forEach((id, course) {
      print('$id: ${course.title} (Level: ${course.level})');
    });

    final courseId = int.tryParse(_getUserInput('Select Course ID: ')) ?? 0;
    final course = courses[courseId];

    if (course == null) {
      print('Course not found.');
      return;
    }

    final enrollment = student.enrollInCourse(course: course, system: system);
    print('Successfully enrolled in "${course.title}"!');
    print('Enrollment Status: ${enrollment.status}');
  }

  void _completeTask(Student student) {
    if (courses.isEmpty) {
      print('No courses available.');
      return;
    }

    print('\n--- Available Courses ---');
    courses.forEach((id, course) {
      print('$id: ${course.title}');
    });

    final courseId = int.tryParse(_getUserInput('Select Course ID: ')) ?? 0;
    final course = courses[courseId];

    if (course == null || course.tasks.isEmpty) {
      print('Course or tasks not found.');
      return;
    }

    print('\n--- Tasks ---');
    for (final task in course.tasks) {
      print('ID: ${task.id}, Title: ${task.title}, Status: ${task.status}');
    }

    final taskId = int.tryParse(_getUserInput('Select Task ID: ')) ?? 0;
    final task = course.tasks.firstWhere(
      (t) => t.id == taskId,
      orElse: () => Task(id: -1, title: '', priority: 0),
    );

    if (task.id == -1) {
      print('Task not found.');
      return;
    }

    student.completeTask(course: course, task: task, system: system);

    final enrollment = student.enrollments.firstWhere(
      (e) => e.courseId == course.id,
      orElse: () => Enrollment(studentId: student.id, courseId: -1),
    );

    if (enrollment.courseId != -1) {
      student.updateProgress(
        enrollment: enrollment,
        course: course,
        system: system,
      );
      print('Task completed! Progress: ${enrollment.progress}%');
    }
  }

  String _getUserInput(String prompt) {
    stdout.write(prompt);
    return stdin.readLineSync() ?? '';
  }
}
