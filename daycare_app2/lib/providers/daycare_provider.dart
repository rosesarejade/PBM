// // providers/daycare_provider.dart
// import 'package:flutter/material.dart';
// import '../models/child.dart';
// import '../models/user.dart';
// import '../models/activity.dart';

// // class DaycareProvider with ChangeNotifier {
// //   List<Child> _children = [
// //     Child(
// //       id: '1',
// //       name: 'John',
// //       sex: 'Male',
// //       age: 5,
// //       parentId: 'p1',
// //       activities: [
// //         Activity(
// //           childName: 'John',
// //           date: DateTime.now(),
// //           arrivalTime: TimeOfDay(hour: 9, minute: 0),
// //           bodyTemperature: 36.6,
// //           condition: 'Healthy & Active',
// //           meal: Meal(type: 'Breakfast', food: 'Cereal', quantity: 'Some'),
// //           toilet: Toilet(
// //               time: TimeOfDay(hour: 10, minute: 0),
// //               type: 'Potty',
// //               notes: 'Normal'),
// //           nap: Rest(
// //               startTime: TimeOfDay(hour: 13, minute: 0),
// //               endTime: TimeOfDay(hour: 14, minute: 0)),
// //           bottle: Bottle(
// //               time: TimeOfDay(hour: 15, minute: 0),
// //               amount: 200.0,
// //               type: 'Milk'),
// //           other: Other(
// //               showerTime: TimeOfDay(hour: 16, minute: 0),
// //               funActivities: 'Playing with toys'),
// //           comments: 'Had a good day.',
// //         ),
// //       ],
// //     ),
// //   ];

// //   List<Parent> _parents = [
// //     Parent(id: 'p1', name: 'Alice', childId: '1'),
// //   ];

// //   List<Child> get children => _children;
// //   List<Parent> get parents => _parents;

// //   void addChild(Child child) {
// //     _children.add(child);
// //     notifyListeners();
// //   }

// //   void addParent(Parent parent) {
// //     _parents.add(parent);
// //     notifyListeners();
// //   }

// //   void updateChildActivity(String childId, Activity activity) {
// //     var child = _children.firstWhere((c) => c.id == childId);
// //     child.activities.add(activity);
// //     notifyListeners();
// //   }
// // }

// providers/daycare_provider.dart
import 'package:flutter/material.dart';
import '../models/child.dart';
import '../models/activity.dart';

class DaycareProvider with ChangeNotifier {
  List<Child> _children = [
    Child(
      id: '1',
      name: 'Alice Hatter',
      sex: 'Female',
      age: 5,
      parentId: 'parent1',
      activities: [
        Activity(
          childName: 'Alice',
          date: DateTime.now(),
          arrivalTime: TimeOfDay.now(),
          bodyTemperature: 37.5,
          condition: 'Good',
          meal: Meal(type: 'Lunch', food: 'Pasta', quantity: 'Some'),
          toilet:
              Toilet(time: TimeOfDay.now(), type: 'Potty', notes: 'No issues'),
          nap: Rest(startTime: TimeOfDay.now(), endTime: TimeOfDay.now()),
          bottle: Bottle(time: TimeOfDay.now(), amount: 200, type: 'Milk'),
          other: Other(showerTime: TimeOfDay.now(), funActivities: 'Drawing'),
          comments: 'Had a great day!',
        ),
      ],
    ),
    Child(
      id: '2',
      name: 'Ben Hope',
      sex: 'Male',
      age: 3,
      parentId: 'parent1',
      activities: [
        Activity(
          childName: 'Ben Hope',
          date: DateTime.now(),
          arrivalTime: TimeOfDay(hour: 8, minute: 0),
          bodyTemperature: 36.5,
          condition: 'Happy',
          meal: Meal(type: 'Breakfast', food: 'Cereal', quantity: 'Some'),
          toilet: Toilet(
              time: TimeOfDay(hour: 10, minute: 0),
              type: 'Potty',
              notes: 'Normal'),
          nap: Rest(
              startTime: TimeOfDay(hour: 12, minute: 0),
              endTime: TimeOfDay(hour: 14, minute: 0)),
          bottle: Bottle(
              time: TimeOfDay(hour: 15, minute: 0),
              amount: 150,
              type: 'Formula'),
          other: Other(
              showerTime: TimeOfDay(hour: 18, minute: 0),
              funActivities: 'Play with toys'),
          comments: 'Made some new friends, please bring extra clothes',
        ),
      ],
    ),
  ];

  List<Child> get children => _children;

  void addChild(Child child) {
    _children.add(child);
    notifyListeners();
  }

//   void updateActivity(String childId, Activity updatedActivity) {
//     // Child child = _children.firstWhere((child) => child.id == childId);
//     // int activityIndex = child.activities
//     //     .indexWhere((activity) => activity.date == updatedActivity.date);
//     // if (activityIndex != -1) {
//     //   child.activities[activityIndex] = updatedActivity;
//     //   notifyListeners();
//     final childIndex = _children.indexWhere((child) => child.id == childId);
//     if (childIndex != -1) {
//       final activities = _children[childIndex].activities;
//       final activityIndex = activities
//           .indexWhere((activity) => activity.date == updatedActivity.date);
//       if (activityIndex != -1) {
//         activities[activityIndex] = updatedActivity;
//         notifyListeners();
//       }
//     }
//   }
// }

  void updateActivity(Activity updatedActivity) {
    for (var child in _children) {
      for (var activity in child.activities) {
        if (activity.date == updatedActivity.date) {
          // Assuming child name and date combination is unique
          activity = updatedActivity; // Update activity
          notifyListeners();
          return;
        }
      }
    }
  }
}
