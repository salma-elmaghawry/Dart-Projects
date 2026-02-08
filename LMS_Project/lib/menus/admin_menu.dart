import 'dart:io';
import 'package:lms_project/lms_system.dart';
import 'package:lms_project/users/admin.dart';
import 'package:lms_project/users/instructor.dart';
import 'package:lms_project/users/student.dart';
import 'package:lms_project/models/course.dart';
import 'package:lms_project/enums/enums.dart';

class AdminMenu {
  final LMSSystem system;
  final Admin admin;
  final Map<int, Instructor> instructors;
  final Map<int, Student> students;
  final Map<int, Course> courses;

  AdminMenu({
    required this.system,
    required this.admin,
    required this.instructors,
    required this.students,
    required this.courses,
  });

  void show() {
    bool inAdminMenu = true;
    while (inAdminMenu) {
      print('\n--- Admin Menu ---');
      print('1. Create Instructor');
      print('2. Create Student');
      print('3. Create Course');
      print('4. Back to Main Menu');

      final choice = _getUserInput('Enter your choice: ');

      switch (choice) {
        case '1':
          _createInstructor();
          break;
        case '2':
          _createStudent();
          break;
        case '3':
          _createCourse();
          break;
        case '4':
          inAdminMenu = false;
          break;
        default:
          print('Invalid choice.');
      }
    }
  }

  void _createInstructor() {
    final id = int.tryParse(_getUserInput('Enter Instructor ID: ')) ?? 0;
    final name = _getUserInput('Enter Instructor Name: ');

    if (name.isEmpty) {
      print('Name cannot be empty.');
      return;
    }

    final instructor = admin.createInstructor(
      id: id,
      name: name,
      system: system,
    );
    instructors[id] = instructor;
    print('Instructor $name created successfully!');
  }

  void _createStudent() {
    final id = int.tryParse(_getUserInput('Enter Student ID: ')) ?? 0;
    final name = _getUserInput('Enter Student Name: ');

    if (name.isEmpty) {
      print('Name cannot be empty.');
      return;
    }

    final student = admin.createStudent(
      id: id,
      name: name,
      system: system,
    );
    students[id] = student;
    print('Student $name created successfully!');
  }

  void _createCourse() {
    final id = int.tryParse(_getUserInput('Enter Course ID: ')) ?? 0;
    final title = _getUserInput('Enter Course Title: ');

    if (title.isEmpty) {
      print('Title cannot be empty.');
      return;
    }

    print('\nCourse Levels: beginner, intermediate, advanced');
    final levelInput = _getUserInput('Enter Course Level: ').toLowerCase();

    final level = switch (levelInput) {
      'beginner' => CourseLevel.beginner,
      'intermediate' => CourseLevel.intermediate,
      'advanced' => CourseLevel.advanced,
      _ => CourseLevel.beginner,
    };

    final course = admin.createCourse(
      id: id,
      title: title,
      level: level,
      system: system,
    );
    courses[id] = course;
    print('Course $title created successfully!');
  }

  String _getUserInput(String prompt) {
    stdout.write(prompt);
    return stdin.readLineSync() ?? '';
  }
}
