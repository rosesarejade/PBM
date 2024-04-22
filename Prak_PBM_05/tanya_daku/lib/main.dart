import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const TanyaDakuApp());
}

class TanyaDakuApp extends StatelessWidget {
  const TanyaDakuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BallHomepage(),
    );
  }
}

class BallHomepage extends StatelessWidget {
  const BallHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[200],
        title: const Text(
          "Ask Daku Anything!",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const Ball(),
      backgroundColor: Colors.pink[200],
    );
  }
}

class Ball extends StatefulWidget {
  const Ball({super.key});

  @override
  State<Ball> createState() => _BolaState();
}

class _BolaState extends State<Ball> {
  int NumBall = 1;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          setState(() {
            NumBall = Random().nextInt(5) + 1;
          });
        },
        child: Image.asset(
            'images/ball$NumBall.png'
        ),
      ),
    );
  }
}
