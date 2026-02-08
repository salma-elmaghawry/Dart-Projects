import 'enums/enums.dart';
import 'users/admin.dart';
import 'users/instructor.dart';
import 'users/student.dart';
import 'models/course.dart';
import 'lms_system.dart';
import 'menus/main_menu.dart';
import 'menus/admin_menu.dart';
import 'menus/instructor_menu.dart';
import 'menus/student_menu.dart';

void main() {
  final system = LMSSystem();
  final admin = Admin(id: 1, name: 'Admin');
  system.addUser(admin);
  system.track('System initialized');

  final app = LMSApp(system: system, admin: admin);
  app.run();
}

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
