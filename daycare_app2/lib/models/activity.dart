import 'package:flutter/material.dart';

// models/activity.dart
class Activity {
  String childName;
  DateTime date;
  TimeOfDay arrivalTime;
  double bodyTemperature;
  String condition;
  Meal meal;
  Toilet toilet;
  Rest nap;
  Bottle bottle;
  Other other;
  String comments;

  Activity(
      {required this.childName,
      required this.date,
      required this.arrivalTime,
      required this.bodyTemperature,
      required this.condition,
      required this.meal,
      required this.toilet,
      required this.nap,
      required this.bottle,
      required this.other,
      required this.comments});
}

class Meal {
  String type;
  String food;
  String quantity;

  Meal({required this.type, required this.food, required this.quantity});
}

class Toilet {
  TimeOfDay time;
  String type;
  String notes;

  Toilet({required this.time, required this.type, required this.notes});
}

class Rest {
  TimeOfDay startTime;
  TimeOfDay endTime;

  Rest({required this.startTime, required this.endTime});
}

class Bottle {
  TimeOfDay time;
  double amount;
  String type;

  Bottle({required this.time, required this.amount, required this.type});
}

class Other {
  TimeOfDay showerTime;
  String funActivities;

  Other({required this.showerTime, required this.funActivities});
}
