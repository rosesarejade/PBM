import '../models/activity.dart';

// models/child.dart
class Child {
  String id;
  String name;
  String sex;
  int age;
  String parentId;
  List<Activity> activities;

  Child(
      {required this.id,
      required this.name,
      required this.sex,
      required this.age,
      required this.parentId,
      required this.activities});
}
