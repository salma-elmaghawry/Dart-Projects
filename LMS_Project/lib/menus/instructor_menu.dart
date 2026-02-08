import 'dart:io';
import 'package:lms_project/lms_system.dart';
import 'package:lms_project/users/instructor.dart';
import 'package:lms_project/models/course.dart';
import 'package:lms_project/models/task.dart';
import 'package:lms_project/enums/enums.dart';

class InstructorMenu {
  final LMSSystem system;
  final Map<int, Instructor> instructors;
  final Map<int, Course> courses;

  InstructorMenu({
    required this.system,
    required this.instructors,
    required this.courses,
  });

  void show() {
    if (instructors.isEmpty) {
      print('No instructors available. Create one first from Admin Menu.');
      return;
    }

    print('\n--- Available Instructors ---');
    instructors.forEach((id, instructor) {
      print('$id: ${instructor.name}');
    });

    final instructorId =
        int.tryParse(_getUserInput('Select Instructor ID: ')) ?? 0;
    final instructor = instructors[instructorId];

    if (instructor == null) {
      print('Instructor not found.');
      return;
    }

    bool inInstructorMenu = true;
    while (inInstructorMenu) {
      print('\n--- Instructor: ${instructor.name} ---');
      print('1. Add Task to Course');
      print('2. View Course Tasks');
      print('3. Change Task Status');
      print('4. Back to Main Menu');

      final choice = _getUserInput('Enter your choice: ');

      switch (choice) {
        case '1':
          _addTaskToCourse(instructor);
          break;
        case '2':
          _viewCourseTasks();
          break;
        case '3':
          _changeTaskStatus(instructor);
          break;
        case '4':
          inInstructorMenu = false;
          break;
        default:
          print('Invalid choice.');
      }
    }
  }

  void _addTaskToCourse(Instructor instructor) {
    if (courses.isEmpty) {
      print('No courses available. Create one first from Admin Menu.');
      return;
    }

    print('\n--- Available Courses ---');
    courses.forEach((id, course) {
      print('$id: ${course.title}');
    });

    final courseId = int.tryParse(_getUserInput('Select Course ID: ')) ?? 0;
    final course = courses[courseId];

    if (course == null) {
      print('Course not found.');
      return;
    }

    final taskId = int.tryParse(_getUserInput('Enter Task ID: ')) ?? 0;
    final taskTitle = _getUserInput('Enter Task Title: ');
    final priority = int.tryParse(_getUserInput('Enter Task Priority: ')) ?? 1;

    if (taskTitle.isEmpty) {
      print('Task title cannot be empty.');
      return;
    }

    final task = Task(id: taskId, title: taskTitle, priority: priority);
    instructor.addTaskToCourse(
      course: course,
      task: task,
      system: system,
    );
    print('Task "$taskTitle" added to course "${course.title}" successfully!');
  }

  void _viewCourseTasks() {
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

    if (course == null) {
      print('Course not found.');
      return;
    }

    print('\n--- Tasks in "${course.title}" ---');
    if (course.tasks.isEmpty) {
      print('No tasks available.');
    } else {
      for (final task in course.tasks) {
        print(
            'ID: ${task.id}, Title: ${task.title}, Status: ${task.status}, Priority: ${task.priority}');
      }
    }
  }

  void _changeTaskStatus(Instructor instructor) {
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
      print(
          'ID: ${task.id}, Title: ${task.title}, Current Status: ${task.status}');
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

    print('\nTask Statuses: todo, inProgress, done, blocked');
    final statusInput = _getUserInput('Enter new status: ').toLowerCase();

    final status = switch (statusInput) {
      'todo' => TaskStatus.todo,
      'inprogress' => TaskStatus.inProgress,
      'done' => TaskStatus.done,
      'blocked' => TaskStatus.blocked,
      _ => TaskStatus.todo,
    };

    instructor.changeTaskStatus(task: task, status: status, system: system);
    print('Task status updated successfully!');
  }

  String _getUserInput(String prompt) {
    stdout.write(prompt);
    return stdin.readLineSync() ?? '';
  }
}
