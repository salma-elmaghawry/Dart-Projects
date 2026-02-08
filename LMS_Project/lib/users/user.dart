import '../enums/enums.dart';

abstract class User {
  final int id;
  final String name;
  final UserRole role;

  User({
    required this.id,
    required this.name,
    required this.role,
  });

  void viewProfile() {
    print('User #$id: $name ($role)');
  }

  void performAction(String action);
}
