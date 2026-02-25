import 'package:flutter/material.dart';
import 'package:tetris_app/logic/shape.dart';
import 'package:tetris_app/logic/tetromino_type.dart';
import 'package:tetris_app/widgets/board_widget.dart'; // tetrominoColors

class NextPieceWidget extends StatelessWidget {
  final Shape nextShape;

  const NextPieceWidget({super.key, required this.nextShape});

  @override
  Widget build(BuildContext context) {
    // Offsets des Steins in Rotation 0 (anchorRow=0, anchorCol=0)
    final offsets = tetrominoOffsets[nextShape.type]![0];
    final activeCells = offsets.toSet();

    return SizedBox(
      width: 80,
      height: 80,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
        itemCount: 16, // 4×4 Vorschauraster
        itemBuilder: (context, index) {
          final col = index % 4;
          final row = index ~/ 4;
          final isActive = activeCells.contains((col, row));

          return Container(
            margin: const EdgeInsets.all(0.5),
            decoration: BoxDecoration(
              color: isActive
                  ? tetrominoColors[nextShape.type]!
                  : Colors.grey.shade900,
              borderRadius: BorderRadius.circular(2),
            ),
          );
        },
      ),
    );
  }
}
