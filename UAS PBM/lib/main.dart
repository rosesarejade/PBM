// main.dart
import 'package:flutter/material.dart';
import 'screens/login.dart';
import 'screens/register.dart';
import 'screens/input_activity.dart';
import 'screens/input_children.dart';
import 'screens/child_activities.dart';
import 'screens/login_selection.dart';
import 'screens/home_parent.dart';
import 'screens/caregiver_home.dart';

void main() {
  runApp(DaycareApp());
}

class DaycareApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'pooh'),
      title: 'Daycare App',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginSelectionPage(),
        '/register': (context) => const RegisterPage(),
        '/login': (context) => LoginPage(),
        '/home_caregiver': (context) =>
            CaretakerHomescreen(), // ActivityInputPage(),
        '/home_parent': (context) => HomeScreen(), //ChildInputPage(),
        '/child_activities': (context) => const ChildActivitiesPage(
              childName: '',
              childAge: 0,
            ),
      },
    );
  }
}

// Little Einsteins Daycare / In the Center of The Hundred Acre Woods / Robin's Friends Daycare