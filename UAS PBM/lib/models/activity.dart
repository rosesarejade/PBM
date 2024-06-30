import 'package:flutter/material.dart';
import 'child_data.dart';

class Activity {
  final int? id;
  Child childId;
  DateTime date;
  double childTemperature;
  String childCondition;
  Map<String, bool> feelings;
  String otherFeeling;
  Map<String, bool> itemsNeeded;
  String otherItemNeeded;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  TimeOfDay dropOffTime = TimeOfDay.now();
  Map<String, Map<String, String>> meals;
  Toilet toilet;
  Rest nap;
  Bottle bottle;
  Other other;
  String comments;
  String showerTime;
  String activityDescription;
  String parentNote;

  Activity({
    this.id,
    required this.childId,
    required this.date,
    required this.dropOffTime,
    required this.childTemperature,
    required this.childCondition,
    required this.otherFeeling,
    required this.selectedDate,
    required this.selectedTime,
    required this.otherItemNeeded,
    this.meals = const {
      'Breakfast': {'food': '', 'quantity': '', 'comments': ''},
      'Lunch': {'food': '', 'quantity': '', 'comments': ''},
      'Dinner': {'food': '', 'quantity': '', 'comments': ''},
      'Fluids': {'food': '', 'quantity': '', 'comments': ''},
      'Other': {'food': '', 'quantity': '', 'comments': ''},
    },
    required this.toilet,
    required this.nap,
    required this.bottle,
    required this.other,
    required this.comments,
    required this.showerTime,
    required this.activityDescription,
    required this.parentNote,
    this.feelings = const {
      'Sad': false,
      'Happy': false,
      'Active': false,
      'Naughty': false,
      'Shy': false,
      'Sociable': false,
      'Other': false,
    },
    this.itemsNeeded = const {
      'Diapers': false,
      'Towel': false,
      'Hand Towel': false,
      'Soap': false,
      'Shampoo': false,
      'Cream': false,
      'Milk': false,
      'Clothes': false,
      'Tooth Paste': false,
      'Other': false,
    },
  });

  // Convert an Activity into a Map. The keys correspond to the names of the columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'childData': childId,
      'date': date.toIso8601String(),
      'childTemperature': childTemperature,
      'childCondition': childCondition,
      'feelings': feelings,
      'otherFeeling': otherFeeling,
      'itemsNeeded': itemsNeeded,
      'otherItemNeeded': otherItemNeeded,
      'selectedDate': selectedDate.toIso8601String(),
      'selectedTime': '${selectedTime.hour}:${selectedTime.minute}',
      'dropOffTime': '${dropOffTime.hour}:${dropOffTime.minute}',
      'meals': meals.map((key, value) => MapEntry(key, value)),
      'toilet': toilet.toMap(),
      'nap': nap.toMap(),
      'bottle': bottle.toMap(),
      'other': other.toMap(),
      'comments': comments,
      'showerTime': showerTime,
      'activityDescription': activityDescription,
      'parentNote': parentNote,
    };
  }

  factory Activity.fromMap(Map<String, dynamic> map) {
    return Activity(
      id: map['id']?.toInt() ?? 0,
      childId: map['childId']?.toInt() ?? 0,
      date: DateTime.parse(map['date']),
      childTemperature: map['childTemperature'],
      childCondition: map['childCondition'],
      feelings: (map['feelings'] as Map<String, dynamic>)
          .map((key, value) => MapEntry(key, value as bool)),
      otherFeeling: map['otherFeeling'],
      itemsNeeded: (map['itemsNeeded'] as Map<String, dynamic>)
          .map((key, value) => MapEntry(key, value as bool)),
      otherItemNeeded: map['otherItemNeeded'],
      selectedDate: DateTime.parse(map['selectedDate']),
      selectedTime: TimeOfDay(
          hour: int.parse(map['selectedTime'].split(':')[0]),
          minute: int.parse(map['selectedTime'].split(':')[1])),
      dropOffTime: TimeOfDay(
          hour: int.parse(map['dropOffTime'].split(':')[0]),
          minute: int.parse(map['dropOffTime'].split(':')[1])),
      meals: (map['meals'] as Map<String, dynamic>)
          .map((key, value) => MapEntry(key, value as Map<String, String>)),
      toilet: Toilet.fromMap(map['toilet'] as Map<String, dynamic>),
      nap: Rest.fromMap(map['nap'] as Map<String, dynamic>),
      bottle: Bottle.fromMap(map['bottle'] as Map<String, dynamic>),
      other: Other.fromMap(map['other'] as Map<String, dynamic>),
      comments: map['comments'],
      showerTime: map['showerTime'],
      activityDescription: map['activityDescription'],
      parentNote: map['parentNote'],
    );
  }

  @override
  String toString() {
    return 'Activity(id: $id, childData: $childId, date: $date, childTemperature: $childTemperature, childCondition: $childCondition, '
        'feelings: $feelings, otherFeeling: $otherFeeling, itemsNeeded: $itemsNeeded, otherItemNeeded: $otherItemNeeded, '
        'selectedDate: $selectedDate, selectedTime: $selectedTime, dropOffTime: $dropOffTime, meals: $meals, '
        'toilet: $toilet, nap: $nap, bottle: $bottle, other: $other, comments: $comments, showerTime: $showerTime, '
        'activityDescription: $activityDescription, parentNote: $parentNote)';
  }
}

class Toilet {
  TimeOfDay bathroomTime;
  String type;
  String notes;

  Toilet({
    required this.bathroomTime,
    required this.type,
    required this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      'bathroomTime': '${bathroomTime.hour}:${bathroomTime.minute}',
      'type': type,
      'notes': notes,
    };
  }

  factory Toilet.fromMap(Map<String, dynamic> map) {
    return Toilet(
      bathroomTime: TimeOfDay(
          hour: int.parse(map['bathroomTime'].split(':')[0]),
          minute: int.parse(map['bathroomTime'].split(':')[1])),
      type: map['type'],
      notes: map['notes'],
    );
  }
}

class Rest {
  TimeOfDay startTime;
  TimeOfDay endTime;

  Rest({
    required this.startTime,
    required this.endTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'startTime': '${startTime.hour}:${startTime.minute}',
      'endTime': '${endTime.hour}:${endTime.minute}',
    };
  }

  factory Rest.fromMap(Map<String, dynamic> map) {
    return Rest(
      startTime: TimeOfDay(
          hour: int.parse(map['startTime'].split(':')[0]),
          minute: int.parse(map['startTime'].split(':')[1])),
      endTime: TimeOfDay(
          hour: int.parse(map['endTime'].split(':')[0]),
          minute: int.parse(map['endTime'].split(':')[1])),
    );
  }
}

class Bottle {
  TimeOfDay time;
  double amount;
  String type;

  Bottle({
    required this.time,
    required this.amount,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'time': '${time.hour}:${time.minute}',
      'amount': amount,
      'type': type,
    };
  }

  factory Bottle.fromMap(Map<String, dynamic> map) {
    return Bottle(
      time: TimeOfDay(
          hour: int.parse(map['time'].split(':')[0]),
          minute: int.parse(map['time'].split(':')[1])),
      amount: map['amount'],
      type: map['type'],
    );
  }
}

class Other {
  TimeOfDay showerTime;
  String funActivities;

  Other({
    required this.showerTime,
    required this.funActivities,
  });

  Map<String, dynamic> toMap() {
    return {
      'showerTime': '${showerTime.hour}:${showerTime.minute}',
      'funActivities': funActivities,
    };
  }

  factory Other.fromMap(Map<String, dynamic> map) {
    return Other(
      showerTime: TimeOfDay(
          hour: int.parse(map['showerTime'].split(':')[0]),
          minute: int.parse(map['showerTime'].split(':')[1])),
      funActivities: map['funActivities'],
    );
  }
}
