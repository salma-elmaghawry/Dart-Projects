import '../enums/enums.dart';

class Enrollment {
  final int studentId;
  final int courseId;
  EnrollmentStatus status;
  int progress;

  Enrollment({
    required this.studentId,
    required this.courseId,
    this.status = EnrollmentStatus.active,
    this.progress = 0,
  });

  void addProgress(int amount) {
    progress += amount;
    if (progress > 100) {
      progress = 100;
    }
  }
}
