import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() => runApp(const xylophoneApp());

class xylophoneApp extends StatelessWidget {
  const xylophoneApp({super.key});

  void playSound(int SoundNum) {
    final player = AudioPlayer();
    player.play(AssetSource('note$SoundNum.wav'));
  }

  Expanded buildKey ({required int SoundNum, required Color buttonColor}) {
    return Expanded(
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: buttonColor,
          ),
          onPressed: () {
            playSound(SoundNum);
          },
          child: Text('SoundNumber: $SoundNum'),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blue[200],
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildKey(SoundNum: 1, buttonColor: Colors.red),
              buildKey(SoundNum: 2, buttonColor: Colors.orange),
              buildKey(SoundNum: 3, buttonColor: Colors.yellow),
              buildKey(SoundNum: 4, buttonColor: Colors.green),
              buildKey(SoundNum: 5, buttonColor: Colors.teal),
              buildKey(SoundNum: 6, buttonColor: Colors.blue),
              buildKey(SoundNum: 7, buttonColor: Colors.purple),
            ],
          ),
        ),
      ),
    );
  }
}