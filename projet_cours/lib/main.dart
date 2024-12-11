import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_grid.dart';
import 'score_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ScoreModel(),
      child: MaterialApp(
        title: '2048 Game',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Text(
              '2048',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.cyan, // Couleur de l'AppBar
          ),
          body: Center(
            child: GameGrid(),
          ),
        ),
      ),
    );
  }
}


