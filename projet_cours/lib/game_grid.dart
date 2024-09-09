import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:math';
import 'score_model.dart';

class GameGrid extends StatefulWidget {
  @override
  _GameGridState createState() => _GameGridState();
}

class _GameGridState extends State<GameGrid> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  List<List<int>> grid = List.generate(4, (_) => List.generate(4, (_) => 0));

  @override
  void initState() {
    super.initState();
    addRandomTile();
    addRandomTile();
  }

  void _playSound() async {
    await _audioPlayer
        .play(AssetSource('move.mp3')); // Utilise play pour déclencher le son
  }

  void _restart() {
    setState(() {
      grid = List.generate(4, (_) => List.generate(4, (_) => 0));
      addRandomTile();
      addRandomTile();
    });
  }

  void _showLoserPopup(BuildContext context) {
    showDialog(
        context: context,
        barrierColor:
            Colors.black.withOpacity(0.5), // Couleur du fond avec transparence
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor:
                Colors.transparent, // Fond transparent pour la popup
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white
                    .withOpacity(0.9), // Fond légèrement opaque pour le contenu
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text(
                    'Vous avez perdu!',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _restart();
                      Navigator.of(context).pop(); // Ferme la popup
                    },
                    child: Text('Fermer'),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void addRandomTile() {
    List<int> emptyCells = [];
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (grid[i][j] == 0) {
          emptyCells.add(i * 4 + j);
        }
      }
    }
    if (emptyCells.isNotEmpty) {
      int randomIndex = emptyCells[Random().nextInt(emptyCells.length)];
      int row = randomIndex ~/ 4;
      int col = randomIndex % 4;
      grid[row][col] = 2;
    }
  }

  bool _checkGameOver() {
    List<List<int>> newGrid =
        List.generate(4, (_) => List.generate(4, (_) => 0));

    // case up
    for (int col = 0; col < 4; col++) {
      List<int> column = [];
      for (int row = 0; row < 4; row++) {
        if (grid[row][col] != 0) {
          column.add(grid[row][col]);
        }
      }
      column = mergeTiles(column);
      for (int row = 0; row < column.length; row++) {
        newGrid[row][col] = column[row];
      }
    }

    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (grid[i][j] != newGrid[i][j]) {
          return false;
        }
      }
    }

    // case down
    newGrid = List.generate(4, (_) => List.generate(4, (_) => 0));

    for (int col = 0; col < 4; col++) {
      List<int> column = [];
      for (int row = 3; row >= 0; row--) {
        if (grid[row][col] != 0) {
          column.add(grid[row][col]);
        }
      }
      column = mergeTiles(column);
      for (int row = 0; row < column.length; row++) {
        newGrid[3 - row][col] = column[row];
      }
    }

    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (grid[i][j] != newGrid[i][j]) {
          return false;
        }
      }
    }

    // case left
    newGrid = List.generate(4, (_) => List.generate(4, (_) => 0));

    for (int row = 0; row < 4; row++) {
      List<int> rowList = [];
      for (int col = 0; col < 4; col++) {
        if (grid[row][col] != 0) {
          rowList.add(grid[row][col]);
        }
      }
      rowList = mergeTiles(rowList);
      for (int col = 0; col < rowList.length; col++) {
        newGrid[row][col] = rowList[col];
      }
    }

    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (grid[i][j] != newGrid[i][j]) {
          return false;
        }
      }
    }

    // case right
    newGrid = List.generate(4, (_) => List.generate(4, (_) => 0));

    for (int row = 0; row < 4; row++) {
      List<int> rowList = [];
      for (int col = 3; col >= 0; col--) {
        if (grid[row][col] != 0) {
          rowList.add(grid[row][col]);
        }
      }
      rowList = mergeTiles(rowList);
      for (int col = 0; col < rowList.length; col++) {
        newGrid[row][3 - col] = rowList[col];
      }
    }

    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (grid[i][j] != newGrid[i][j]) {
          return false;
        }
      }
    }

    return true;
  }

  void move(Direction direction) {
    List<List<int>> newGrid =
        List.generate(4, (_) => List.generate(4, (_) => 0));
    bool moved = false;
    int newScore = 0;

    switch (direction) {
      case Direction.up:
        for (int col = 0; col < 4; col++) {
          List<int> column = [];
          for (int row = 0; row < 4; row++) {
            if (grid[row][col] != 0) {
              column.add(grid[row][col]);
            }
          }
          column = mergeTiles(column);
          for (int row = 0; row < column.length; row++) {
            newGrid[row][col] = column[row];
          }
        }
        break;
      case Direction.down:
        for (int col = 0; col < 4; col++) {
          List<int> column = [];
          for (int row = 3; row >= 0; row--) {
            if (grid[row][col] != 0) {
              column.add(grid[row][col]);
            }
          }
          column = mergeTiles(column);
          for (int row = 0; row < column.length; row++) {
            newGrid[3 - row][col] = column[row];
          }
        }
        break;
      case Direction.left:
        for (int row = 0; row < 4; row++) {
          List<int> rowList = [];
          for (int col = 0; col < 4; col++) {
            if (grid[row][col] != 0) {
              rowList.add(grid[row][col]);
            }
          }
          rowList = mergeTiles(rowList);
          for (int col = 0; col < rowList.length; col++) {
            newGrid[row][col] = rowList[col];
          }
        }
        break;
      case Direction.right:
        for (int row = 0; row < 4; row++) {
          List<int> rowList = [];
          for (int col = 3; col >= 0; col--) {
            if (grid[row][col] != 0) {
              rowList.add(grid[row][col]);
            }
          }
          rowList = mergeTiles(rowList);
          for (int col = 0; col < rowList.length; col++) {
            newGrid[row][3 - col] = rowList[col];
          }
        }
        break;
    }

    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (grid[i][j] != newGrid[i][j]) {
          moved = true;
        }
      }
    }

    if (moved) {
      _playSound();
      setState(() {
        grid = newGrid;
      });
      Provider.of<ScoreModel>(context, listen: false).updateScore(newScore);
      Future.delayed(Duration(milliseconds: 200), () {
        setState(() {
          addRandomTile();
          if (_checkGameOver()) {
            _showLoserPopup(context);
          }
        });
      });
    }
  }

  List<int> mergeTiles(List<int> tiles) {
    List<int> mergedTiles = [];
    int newScore = 0;
    for (int i = 0; i < tiles.length; i++) {
      if (i + 1 < tiles.length && tiles[i] == tiles[i + 1]) {
        mergedTiles.add(tiles[i] * 2);
        newScore += tiles[i] * 2;
        i++;
      } else {
        mergedTiles.add(tiles[i]);
      }
    }
    Provider.of<ScoreModel>(context, listen: false).updateScore(newScore);
    return mergedTiles;
  }

  Color getTileColor(int value) {
    switch (value) {
      case 0:
        return Colors.grey[300]!;
      case 2:
        return Colors.lightBlue[100]!;
      case 4:
        return Colors.lightBlue[200]!;
      case 8:
        return Colors.lightBlue[300]!;
      case 16:
        return Colors.lightBlue[400]!;
      case 32:
        return Colors.lightBlue[500]!;
      case 64:
        return Colors.lightBlue[600]!;
      case 128:
        return Colors.lightBlue[700]!;
      case 256:
        return Colors.lightBlue[800]!;
      case 512:
        return Colors.lightBlue[900]!;
      case 1024:
        return Colors.blue[900]!;
      case 2048:
        return Colors.blue[800]!;
      default:
        return Colors.blue[700]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<ScoreModel>(
            builder: (context, scoreModel, child) {
              return Text(
                'Score: ${scoreModel.score}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              );
            },
          ),
        ),
        Expanded(
          child: GestureDetector(
            onHorizontalDragEnd: (details) {
              if (details.primaryVelocity! > 0) {
                move(Direction.right);
              } else {
                move(Direction.left);
              }
            },
            onVerticalDragEnd: (details) {
              if (details.primaryVelocity! > 0) {
                move(Direction.down);
              } else {
                move(Direction.up);
              }
            },
            child: GridView.builder(
              physics:
                  NeverScrollableScrollPhysics(), // Désactive le défilement de la grille
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemCount: 16,
              itemBuilder: (context, index) {
                int row = index ~/ 4;
                int col = index % 4;
                int value = grid[row][col];
                return Container(
                  margin: EdgeInsets.all(4.0),
                  color: getTileColor(value),
                  child: Center(
                    child: Text(
                      value == 0 ? '' : value.toString(),
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

enum Direction {
  up,
  down,
  left,
  right,
}
