import 'package:flutter/material.dart';
import 'dart:math';

class GameGrid extends StatefulWidget {
  @override
  _GameGridState createState() => _GameGridState();
}

class _GameGridState extends State<GameGrid> {
  List<List<int>> grid = List.generate(4, (_) => List.generate(4, (_) => 0));

  @override
  void initState() {
    super.initState();
    addRandomTile();
    addRandomTile();
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

  void move(Direction direction) {
    List<List<int>> newGrid = List.generate(4, (_) => List.generate(4, (_) => 0));
    bool moved = false;

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
      setState(() {
        grid = newGrid;
        addRandomTile();
      });
    }
  }

  List<int> mergeTiles(List<int> tiles) {
    List<int> mergedTiles = [];
    for (int i = 0; i < tiles.length; i++) {
      if (i + 1 < tiles.length && tiles[i] == tiles[i + 1]) {
        mergedTiles.add(tiles[i] * 2);
        i++;
      } else {
        mergedTiles.add(tiles[i]);
      }
    }
    return mergedTiles;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
        physics: NeverScrollableScrollPhysics(), // Désactive le défilement de la grille
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
            color: value == 0 ? Colors.grey[300] : Colors.blue,
            child: Center(
              child: Text(
                value == 0 ? '' : value.toString(),
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }
}

enum Direction {
  up,
  down,
  left,
  right,
}


