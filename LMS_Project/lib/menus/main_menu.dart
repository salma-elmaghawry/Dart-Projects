import 'dart:io';

class MainMenu {
  void display() {
    print('\n========== LMS SYSTEM MENU ==========');
    print('1. Admin Operations');
    print('2. Instructor Operations');
    print('3. Student Operations');
    print('4. View System Summary');
    print('5. Exit');
    print('====================================');
  }

  String getUserInput(String prompt) {
    stdout.write(prompt);
    return stdin.readLineSync() ?? '';
  }
}
