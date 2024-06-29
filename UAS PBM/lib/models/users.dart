// models/user.dart
class User {
  final String uid;
  final String username;
  final String email;
  final String password;

  User(
      {required this.uid,
      required this.username,
      required this.email,
      required this.password});
}

// models/child.dart
class Child {
  final String name;
  final String age;
  final String sex;
  final String parentId;

  Child(
      {required this.name,
      required this.age,
      required this.sex,
      required this.parentId});
}
