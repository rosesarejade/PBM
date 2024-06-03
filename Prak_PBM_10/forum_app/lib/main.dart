import 'package:flutter/material.dart';
import '../views/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Forum Application',
      theme: ThemeData(
        colorSchemeSeed: Colors.yellow,
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}
