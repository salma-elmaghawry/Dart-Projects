import 'package:lms_project/lms_system.dart';

import '../enums/enums.dart';
import '../mixins/mixins.dart';
import '../models/course.dart';
import 'instructor.dart';
import 'student.dart';
import 'user.dart';

class Admin extends User with ValidatableMixin {
  Admin({
    required super.id,
    required super.name,
  }) : super(role: UserRole.admin);

  Instructor createInstructor({
    required int id,
    required String name,
    required LMSSystem system,
  }) {
    validateName(name);
    final instructor = Instructor(id: id, name: name);
    system.addUser(instructor);
    system.track('Admin created Instructor: ${instructor.name}');
    return instructor;
  }

  Student createStudent({
    required int id,
    required String name,
    required LMSSystem system,
  }) {
    validateName(name);
    final student = Student(id: id, name: name);
    system.addUser(student);
    system.track('Admin created Student: ${student.name}');
    return student;
  }

  Course createCourse({
    required int id,
    required String title,
    required CourseLevel level,
    required LMSSystem system,
  }) {
    validateName(title);
    final course = Course(id: id, title: title, level: level);
    system.addCourse(course);
    system.track('Admin created Course: ${course.title}');
    return course;
  }

  @override
  void performAction(String action) {
    print('Admin $name performs: $action');
  }
}
