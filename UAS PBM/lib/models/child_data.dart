import 'dart:convert';

// models/child.dart
class Child {
  final int? id;
  String childName;
  String sex;
  int childAge;
  late int? parentId;
  // List<Activity> activities;

  Child({
    this.id,
    required this.childName,
    required this.sex,
    required this.childAge,
    this.parentId,
    // required this.activities
  });

// convert data to map
// columns in the database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': childName,
      'gender': sex,
      'age': childAge,
      'parent': parentId,
    };
  }

  factory Child.fromMap(Map<String, dynamic> map) {
    return Child(
        id: map['id']?.toInt() ?? 0,
        childName: map['childName'] ?? '',
        sex: map["sex"] ?? '',
        childAge: map['childAge']?.toInt ?? 0,
        parentId: map['parentId']?.toInt ?? 0);
  }

  @override
  String toString() =>
      'Child(id: $id, name: $childName, age: $childAge, sex: $sex, parent: $parentId)';
}
