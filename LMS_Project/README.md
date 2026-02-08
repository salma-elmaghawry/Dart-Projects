# LMS Project - Learning Management System

An interactive console-based Learning Management System built with Dart, featuring role-based operations for Admins, Instructors, and Students.

## 🚀 Quick Start

### Run the Application

```zsh
dart run
```

Or directly:

```zsh
dart lib/main.dart
```

## 📁 Project Structure

```
lib/
├── main.dart                 # Application entry point and main orchestrator
├── lms_system.dart          # Core LMS system with tracking
├── enums/
│   └── enums.dart           # Enums: UserRole, CourseLevel, TaskStatus, EnrollmentStatus
├── mixins/
│   └── mixins.dart          # Mixins: TrackableMixin, LoggerMixin, ValidatableMixin
├── models/
│   ├── course.dart          # Course model with tasks
│   ├── enrollment.dart      # Enrollment model with progress tracking
│   └── task.dart            # Task model with status and priority
├── users/
│   ├── user.dart            # Abstract User base class
│   ├── admin.dart           # Admin class with creation methods
│   ├── instructor.dart      # Instructor class with task management
│   └── student.dart         # Student class with enrollment and task completion
└── menus/
    ├── main_menu.dart       # Main menu display and navigation
    ├── admin_menu.dart      # Admin operations menu
    ├── instructor_menu.dart # Instructor operations menu
    └── student_menu.dart    # Student operations menu
```

## 👥 User Roles & Operations

### 1. **Admin** 👨‍💼
Administrators have full control over the system and can manage users and courses.

#### Operations:
- **Create Instructor** - Add new instructors to the system
- **Create Student** - Add new students to the system
- **Create Course** - Create new courses with different difficulty levels (beginner, intermediate, advanced)

#### Access:
Select option `1` from the main menu → Admin Operations

---

### 2. **Instructor** 👨‍🏫
Instructors manage courses and tasks assigned to their courses.

#### Operations:
- **Add Task to Course** - Create and assign tasks to a specific course with priority levels
- **View Course Tasks** - Display all tasks in a course with their status (todo, inProgress, done, blocked)
- **Change Task Status** - Update task status to manage course progress
  - `todo` - Task not started
  - `inProgress` - Task in progress
  - `done` - Task completed
  - `blocked` - Task blocked (cannot be completed by students)

#### Access:
Select option `2` from the main menu → Select an instructor → Instructor Operations

---

### 3. **Student** 🎓
Students engage with courses and complete assigned tasks.

#### Operations:
- **Enroll in Course** - Register for a course (shows course level)
- **Complete Task** - Mark tasks as done (respects task status: cannot complete blocked tasks)
- **View Profile** - Display student information including ID, name, and role
- **Track Progress** - Automatic progress calculation based on:
  - Course level difficulty (beginner: +20%, intermediate: +15%, advanced: +10%)
  - Automatic course completion when all tasks are done

#### Access:
Select option `3` from the main menu → Select a student → Student Operations

---

## 📊 Core Features

### Task Management
- Tasks have unique IDs, titles, and priority levels
- Task statuses: `todo`, `inProgress`, `done`, `blocked`
- Blocked tasks cannot be completed by students
- Instructor can change task status

### Course Management
- Courses have titles and difficulty levels
- Each course contains multiple tasks
- Students can enroll in multiple courses
- Progress tracking per enrollment

### Progress Tracking
- Students' progress is tracked per enrollment
- Progress updates with each task completion
- Automatically marks course as complete when progress reaches 100%

### System Logging
- All operations are logged with timestamps
- View complete system summary including:
  - User count and roles
  - Course statistics
  - Task status distribution
  - Enrollment status distribution
  - Complete activity history

---

## 🔧 Key Technologies & Concepts

### OOP (Object-Oriented Programming)
- Abstract base class (`User`) with role-based subclasses
- Encapsulation of user data and operations

### Enums
- `UserRole` - admin, instructor, student
- `CourseLevel` - beginner, intermediate, advanced
- `TaskStatus` - todo, inProgress, done, blocked
- `EnrollmentStatus` - active, completed, dropped

### Mixins
- `TrackableMixin` - Provides tracking and history functionality
- `LoggerMixin` - Provides logging capabilities for instructors
- `ValidatableMixin` - Provides validation methods for data input

### Menu Architecture
- Modular menu system with separate files for each role
- Interactive command-line interface
- Input validation and error handling

---

## 📋 Main Menu Navigation

```
========== LMS SYSTEM MENU ==========
1. Admin Operations
2. Instructor Operations
3. Student Operations
4. View System Summary
5. Exit
====================================
```

---

## 💡 Example Workflow

1. **Create System Entities** (Admin):
   - Create an instructor "Dr. Ahmed"
   - Create students "Ali" and "Fatima"
   - Create course "Web Development" (intermediate level)

2. **Manage Course** (Instructor):
   - Add tasks: "HTML Basics", "CSS Styling", "JavaScript"
   - Set task priorities
   - Change task statuses as needed

3. **Complete Course** (Student):
   - Enroll in "Web Development"
   - Complete tasks one by one
   - Track progress automatically
   - View profile

4. **Review System** (Admin):
   - View system summary
   - Check all logs and statistics

---

## �� System Summary Report

The `View System Summary` option displays:
- Total users, courses, and enrollments
- Task distribution by status
- Enrollment distribution by status
- Complete activity log with timestamps

---

## 📝 Notes

- The system is fully interactive - all operations require user input
- Data is stored in memory during the session
- All operations are logged for audit trail
- The application demonstrates real-world LMS functionality in a simplified console environment
