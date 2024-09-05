import 'package:flutter/material.dart';
import 'game_grid.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '2048 Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('2048 Game'),
        ),
        body: Center(
          child: GameGrid(),
        ),
      ),
    );
  }
}
