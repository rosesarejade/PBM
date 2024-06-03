// // models/parent.dart
// class Parent {
//   String id;
//   String name;
//   String childId;

//   Parent({required this.id, required this.name, required this.childId});
// }

// models/user.dart
class User {
  String id;
  String username;
  String password;
  String role; // 'parent' or 'caretaker'

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.role,
  });
}
