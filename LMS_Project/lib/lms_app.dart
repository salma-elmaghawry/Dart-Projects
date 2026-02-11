import 'package:lms_project/lms_system.dart';
import 'package:lms_project/menus/admin_menu.dart';
import 'package:lms_project/menus/instructor_menu.dart';
import 'package:lms_project/menus/main_menu.dart';
import 'package:lms_project/menus/student_menu.dart';
import 'package:lms_project/models/course.dart';
import 'package:lms_project/users/admin.dart';
import 'package:lms_project/users/instructor.dart';
import 'package:lms_project/users/student.dart';

class LMSApp {
  final LMSSystem system;
  final Admin admin;
  final Map<int, Instructor> instructors = {};
  final Map<int, Student> students = {};
  final Map<int, Course> courses = {};
  final MainMenu mainMenu = MainMenu();

  LMSApp({required this.system, required this.admin});

  void run() {
    bool running = true;
    while (running) {
      mainMenu.display();
      final choice = mainMenu.getUserInput('Enter your choice: ');

      switch (choice) {
        case '1':
          final adminMenu = AdminMenu(
            system: system,
            admin: admin,
            instructors: instructors,
            students: students,
            courses: courses,
          );
          adminMenu.show();
          break;
        case '2':
          final instructorMenu = InstructorMenu(
            system: system,
            instructors: instructors,
            courses: courses,
          );
          instructorMenu.show();
          break;
        case '3':
          final studentMenu = StudentMenu(
            system: system,
            students: students,
            courses: courses,
          );
          studentMenu.show();
          break;
        case '4':
          _viewSystemSummary();
          break;
        case '5':
          running = false;
          print('\nThank you for using LMS System. Goodbye!');
          break;
        default:
          print('Invalid choice. Please try again.');
      }
      print('');
    }
  }

  void _viewSystemSummary() {
    system.printSummary();
  }
}
