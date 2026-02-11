import 'package:lms_project/lms_app.dart';
import 'package:lms_project/lms_system.dart';
import 'package:lms_project/users/admin.dart';

void main() {
  final system = LMSSystem();
  final admin = Admin(id: 1, name: 'Admin');
  system.addUser(admin);
  system.track('System initialized');

  final app = LMSApp(system: system, admin: admin);
  app.run();
}
