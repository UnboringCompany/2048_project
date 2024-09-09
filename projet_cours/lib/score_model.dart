import 'package:flutter/material.dart';

class ScoreModel with ChangeNotifier {
  int _score = 0;

  int get score => _score;

  void updateScore(int newScore) {
    _score += newScore;
    notifyListeners();
  }
}
