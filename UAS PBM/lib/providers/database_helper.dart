import '../models/child_data.dart';
import '../models/activity.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

// Database service class to handle SQLite operations
class DatabaseService {
  // Singleton pattern
  static final DatabaseService _databaseService = DatabaseService._internal();
  factory DatabaseService() => _databaseService;
  DatabaseService._internal();

  static Database? _database;

  // Method to get reference to the database
  Future<Database> get database async {
    if (_database != null) return _database!;

    // If _database is null, initialize it
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDatabase() async {
    // Get the database path
    String databasePath = await getDatabasesPath();
    databasePath = join(databasePath, 'daycare_database.db');

    // Open/create the database
    return await openDatabase(
      databasePath,
      version: 1,
      onCreate: _onCreate,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  // Create tables when database is first created
  Future<void> _onCreate(Database db, int version) async {
    // Create Child table
    await db.execute(
        'CREATE TABLE child(id INTEGER PRIMARY KEY, childName TEXT, sex TEXT, childAge INTEGER, parentId INTEGER)');

    // Create tables for Activity and related classes
    await db.execute('''
      CREATE TABLE activities (
        id INTEGER PRIMARY KEY,
        FOREIGN KEY (childId) REFERENCES child(id) ON DELETE SET NULL,
        date TEXT,
        childTemperature REAL,
        childCondition TEXT,
        otherFeeling TEXT,
        otherItemNeeded TEXT,
        selectedDate TEXT,
        selectedTime TEXT,
        dropOffTime TEXT,
        comments TEXT,
        showerTime TEXT,
        activityDescription TEXT,
        parentNote TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE feelings (
        id INTEGER PRIMARY KEY,
        activityId INTEGER,
        feelingName TEXT,
        feelingValue INTEGER,
        FOREIGN KEY (activityId) REFERENCES activities(id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE itemsNeeded (
        id INTEGER PRIMARY KEY,
        activityId INTEGER,
        itemName TEXT,
        itemValue INTEGER,
        FOREIGN KEY (activityId) REFERENCES activities(id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE meals (
        id INTEGER PRIMARY KEY,
        activityId INTEGER,
        mealName TEXT,
        food TEXT,
        quantity TEXT,
        comments TEXT,
        FOREIGN KEY (activityId) REFERENCES activities(id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE toilet (
        id INTEGER PRIMARY KEY,
        activityId INTEGER,
        bathroomTime TEXT,
        type TEXT,
        notes TEXT,
        FOREIGN KEY (activityId) REFERENCES activities(id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE nap (
        id INTEGER PRIMARY KEY,
        activityId INTEGER,
        startTime TEXT,
        endTime TEXT,
        FOREIGN KEY (activityId) REFERENCES activities(id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE bottle (
        id INTEGER PRIMARY KEY,
        activityId INTEGER,
        time TEXT,
        amount REAL,
        type TEXT,
        FOREIGN KEY (activityId) REFERENCES activities(id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE other (
        id INTEGER PRIMARY KEY,
        activityId INTEGER,
        showerTime TEXT,
        funActivities TEXT,
        FOREIGN KEY (activityId) REFERENCES activities(id) ON DELETE CASCADE
      )
    ''');
  }

  // Insert an Activity into the database
  Future<void> insertActivity(Activity activity) async {
    final db = await database;
    await db.insert(
      'activities',
      activity.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    // Insert related data into child tables
    await _insertFeelings(activity.feelings, activity.id!);
    await _insertItemsNeeded(activity.itemsNeeded, activity.id!);
    await _insertMeals(activity.meals, activity.id!);
    await _insertToilet(activity.toilet, activity.id!);
    await _insertNap(activity.nap, activity.id!);
    await _insertBottle(activity.bottle, activity.id!);
    await _insertOther(activity.other, activity.id!);
  }

  // Insert Child Data records into the database
  Future<void> insertChild(Child child) async {
    // Get a reference to the database.
    final db = await _databaseService.database;

    // Insert the Breed into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same child is inserted twice.
    // In this case, replace any previous data.
    await db.insert(
      'child',
      child.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Insert Feelings records into the database
  Future<void> _insertFeelings(
      Map<String, bool> feelings, int activityId) async {
    final db = await database;
    feelings.forEach((key, value) async {
      await db.insert(
        'feelings',
        {
          'activityId': activityId,
          'feelingName': key,
          'feelingValue': value ? 1 : 0,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  // Insert ItemsNeeded records into the database
  Future<void> _insertItemsNeeded(
      Map<String, bool> itemsNeeded, int activityId) async {
    final db = await database;
    itemsNeeded.forEach((key, value) async {
      await db.insert(
        'itemsNeeded',
        {
          'activityId': activityId,
          'itemName': key,
          'itemValue': value ? 1 : 0,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  // Insert Meals records into the database
  Future<void> _insertMeals(
      Map<String, Map<String, String>> meals, int activityId) async {
    final db = await database;
    meals.forEach((mealName, mealData) async {
      await db.insert(
        'meals',
        {
          'activityId': activityId,
          'mealName': mealName,
          'food': mealData['food'],
          'quantity': mealData['quantity'],
          'comments': mealData['comments'],
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  // Insert Toilet record into the database
  Future<void> _insertToilet(Toilet toilet, int activityId) async {
    final db = await database;
    await db.insert(
      'toilet',
      {
        'activityId': activityId,
        'bathroomTime': toilet.bathroomTime.toString(),
        'type': toilet.type,
        'notes': toilet.notes,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Insert Nap record into the database
  Future<void> _insertNap(Rest nap, int activityId) async {
    final db = await database;
    await db.insert(
      'nap',
      {
        'activityId': activityId,
        'startTime': nap.startTime.toString(),
        'endTime': nap.endTime.toString(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Insert Bottle record into the database
  Future<void> _insertBottle(Bottle bottle, int activityId) async {
    final db = await database;
    await db.insert(
      'bottle',
      {
        'activityId': activityId,
        'time': bottle.time.toString(),
        'amount': bottle.amount,
        'type': bottle.type,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Insert Other record into the database
  Future<void> _insertOther(Other other, int activityId) async {
    final db = await database;
    await db.insert(
      'other',
      {
        'activityId': activityId,
        'showerTime': other.showerTime.toString(),
        'funActivities': other.funActivities,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Retrieve all activities from the database
  Future<List<Activity>> getActivities() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('activities');
    return List.generate(maps.length, (i) {
      return Activity(
        childData: [], // Initialize childData, feelings, itemsNeeded, etc. based on database query
        date: DateTime.parse(maps[i]['date']),
        childTemperature: maps[i]['childTemperature'],
        childCondition: maps[i]['childCondition'],
        otherFeeling: maps[i]['otherFeeling'],
        otherItemNeeded: maps[i]['otherItemNeeded'],
        selectedDate: DateTime.parse(maps[i]['selectedDate']),
        selectedTime:
            TimeOfDay.fromDateTime(DateTime.parse(maps[i]['selectedTime'])),
        dropOffTime:
            TimeOfDay.fromDateTime(DateTime.parse(maps[i]['dropOffTime'])),
        meals: json.decode(maps[i]['meals']),
        toilet: Toilet(
          bathroomTime: TimeOfDay.fromDateTime(
              DateTime.parse(maps[i]['toilet']['bathroomTime'])),
          type: maps[i]['toilet']['type'],
          notes: maps[i]['toilet']['notes'],
        ),
        nap: Rest(
          startTime: TimeOfDay.fromDateTime(
              DateTime.parse(maps[i]['nap']['startTime'])),
          endTime:
              TimeOfDay.fromDateTime(DateTime.parse(maps[i]['nap']['endTime'])),
        ),
        bottle: Bottle(
          time:
              TimeOfDay.fromDateTime(DateTime.parse(maps[i]['bottle']['time'])),
          amount: maps[i]['bottle']['amount'],
          type: maps[i]['bottle']['type'],
        ),
        other: Other(
          showerTime: TimeOfDay.fromDateTime(
              DateTime.parse(maps[i]['other']['showerTime'])),
          funActivities: maps[i]['other']['funActivities'],
        ),
        comments: maps[i]['comments'],
        showerTime: maps[i]['showerTime'],
        activityDescription: maps[i]['activityDescription'],
        parentNote: maps[i]['parentNote'],
      );
    });
  }

  // Update an activity in the database
  Future<void> updateActivity(Activity activity) async {
    final db = await database;
    await db.update(
      'activities',
      activity.toMap(),
      where: 'id = ?',
      whereArgs: [activity.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    // Update related data in child tables
    await _updateChildData(activity.childData, activity.id!);
    await _updateFeelings(activity.feelings, activity.id!);
    await _updateItemsNeeded(activity.itemsNeeded, activity.id!);
    await _updateMeals(activity.meals, activity.id!);
    await _updateToilet(activity.toilet, activity.id!);
    await _updateNap(activity.nap, activity.id!);
    await _updateBottle(activity.bottle, activity.id!);
    await _updateOther(activity.other, activity.id!);
  }

  // Update ChildData records in the database
  Future<void> _updateChildData(
      List<ChildData> childData, int activityId) async {
    final db = await database;
    // Delete existing child data for the activity
    await db
        .delete('childData', where: 'activityId = ?', whereArgs: [activityId]);
    // Insert updated child data
    for (var child in childData) {
      await db.insert(
        'childData',
        {
          'activityId': activityId,
          'childName': child.childName,
          'childAge': child.childAge,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  // Update Feelings records in the database
  Future<void> _updateFeelings(
      Map<String, bool> feelings, int activityId) async {
    final db = await database;
    // Delete existing feelings for the activity
    await db
        .delete('feelings', where: 'activityId = ?', whereArgs: [activityId]);
    // Insert updated feelings
    feelings.forEach((key, value) async {
      await db.insert(
        'feelings',
        {
          'activityId': activityId,
          'feelingName': key,
          'feelingValue': value ? 1 : 0,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  // Update ItemsNeeded records in the database
  Future<void> _updateItemsNeeded(
      Map<String, bool> itemsNeeded, int activityId) async {
    final db = await database;
    // Delete existing items needed for the activity
    await db.delete('itemsNeeded',
        where: 'activityId = ?', whereArgs: [activityId]);
    // Insert updated items needed
    itemsNeeded.forEach((key, value) async {
      await db.insert(
        'itemsNeeded',
        {
          'activityId': activityId,
          'itemName': key,
          'itemValue': value ? 1 : 0,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  // Update Meals records in the database
  Future<void> _updateMeals(
      Map<String, Map<String, String>> meals, int activityId) async {
    final db = await database;
    // Delete existing meals for the activity
    await db.delete('meals', where: 'activityId = ?', whereArgs: [activityId]);
    // Insert updated meals
    meals.forEach((mealName, mealData) async {
      await db.insert(
        'meals',
        {
          'activityId': activityId,
          'mealName': mealName,
          'food': mealData['food'],
          'quantity': mealData['quantity'],
          'comments': mealData['comments'],
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  // Update Toilet record in the database
  Future<void> _updateToilet(Toilet toilet, int activityId) async {
    final db = await database;
    // Update existing toilet record
    await db.update(
      'toilet',
      {
        'activityId': activityId,
        'bathroomTime': toilet.bathroomTime.toString(),
        'type': toilet.type,
        'notes': toilet.notes,
      },
      where: 'activityId = ?',
      whereArgs: [activityId],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Update Nap record in the database
  Future<void> _updateNap(Rest nap, int activityId) async {
    final db = await database;
    // Update existing nap record
    await db.update(
      'nap',
      {
        'activityId': activityId,
        'startTime': nap.startTime.toString(),
        'endTime': nap.endTime.toString(),
      },
      where: 'activityId = ?',
      whereArgs: [activityId],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Update Bottle record in the database
  Future<void> _updateBottle(Bottle bottle, int activityId) async {
    final db = await database;
    // Update existing bottle record
    await db.update(
      'bottle',
      {
        'activityId': activityId,
        'time': bottle.time.toString(),
        'amount': bottle.amount,
        'type': bottle.type,
      },
      where: 'activityId = ?',
      whereArgs: [activityId],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Update Other record in the database
  Future<void> _updateOther(Other other, int activityId) async {
    final db = await database;
    // Update existing other record
    await db.update(
      'other',
      {
        'activityId': activityId,
        'showerTime': other.showerTime.toString(),
        'funActivities': other.funActivities,
      },
      where: 'activityId = ?',
      whereArgs: [activityId],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Delete an activity from the database
  Future<void> deleteActivity(int id) async {
    final db = await database;
    await db.delete(
      'activities',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Close the database
  Future<void> close() async {
    final db = await database;
    db.close();
    _database = null;
  }
}
