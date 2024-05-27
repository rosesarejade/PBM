import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prak_pbm_09/models/notes_operation.dart';
import 'package:prak_pbm_09/screen/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NotesOperation>(
        create: (context) => NotesOperation(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
        ));
  }
}
