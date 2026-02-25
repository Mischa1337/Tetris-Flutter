import 'package:flutter/material.dart';
import 'package:tetris_app/logic/board.dart';
import 'package:tetris_app/logic/shape.dart';
import 'package:tetris_app/logic/tetromino_type.dart';

// Klassische Tetris-Farben für jeden Steintyp
const Map<TetrominoType, Color> tetrominoColors = {
  TetrominoType.I: Colors.cyan,
  TetrominoType.O: Colors.yellow,
  TetrominoType.T: Colors.purple,
  TetrominoType.L: Colors.orange,
  TetrominoType.J: Colors.blue,
  TetrominoType.S: Colors.green,
  TetrominoType.Z: Colors.red,
};

class BoardWidget extends StatelessWidget {
  final Board board;
  final Shape currentShape;

  const BoardWidget({
    super.key,
    required this.board,
    required this.currentShape,
  });

  @override
  Widget build(BuildContext context) {
    // Welche Board-Indizes belegt der aktive Stein gerade?
    final activeIndices = board.indicesOf(currentShape).toSet();

    return AspectRatio(
      aspectRatio: boardWidth / boardHeight,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(), // kein Scrollen
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: boardWidth,
        ),
        itemCount: boardWidth * boardHeight,
        itemBuilder: (context, index) {
          final Color color;

          if (activeIndices.contains(index)) {
            // Aktiver, fallender Stein
            color = tetrominoColors[currentShape.type]!;
          } else if (board.cells[index] != 0) {
            // Eingefrorener Stein — Farbe aus dem gespeicherten Index
            final type = TetrominoType.values[board.cells[index] - 1];
            color = tetrominoColors[type]!;
          } else {
            // Leere Zelle
            color = Colors.grey.shade900;
          }

          return Container(
            margin: const EdgeInsets.all(0.5),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          );
        },
      ),
    );
  }
}
