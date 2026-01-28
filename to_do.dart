import 'dart:io';

dynamic addTask(Map<String, String> tasks) {
  print("Please enter the task title:");
  String? title = stdin.readLineSync();
  print("Please enter the task description:");
  String? description = stdin.readLineSync();

  if (title == null || title.isEmpty) {
    return 'Title is required';
  }
  if (description == null || description.isEmpty) {
    return 'Description is required';
  }
  tasks[title] = description;
  print('Task added successfully.');
  return tasks;
}

viewTasks(Map<String, String> tasks) {
  if (tasks.isEmpty) {
    print('No tasks available.');
    return;
  }
  print('---Task List---');
  tasks.forEach((title, description) {
    print('Title: $title');
    print('Description: $description');
    print('----------------');
  });
}

removeTask(Map<String, String> tasks) {
  print("Please enter the title of the task to remove:");
  String? title = stdin.readLineSync();
  if (title == null || title.isEmpty) {
    return 'Title is required';
  }

  if (tasks.containsKey(title)) {
    tasks.remove(title);
    return 'Task "$title" removed successfully.';
  } else {
    return 'Task "$title" not found.';
  }
}

void main() {
  Map<String, String> tasks = {};
  String? choice;
  do {
    print("---To Do List Application---");
    print("1. Add Task");
    print("2. View Tasks");
    print("3. Remove Task");
    print("4. Exit");
    print("Select an option:");

    choice = stdin.readLineSync();
    if (choice == null || choice.isEmpty) {
      print('Invalid input. Please enter a number.');
      continue;
    }

    switch (choice) {
      case 1:
        addTask(tasks);
        break;
      case 2:
        viewTasks(tasks);
        break;
      case 3:
        removeTask(tasks);
        break;
      case 4:
        print('Exiting application.');
        return;
      default:
        print('Invalid choice. Please select a valid option.');
    }
  } while (choice != 4);
}
