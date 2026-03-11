import 'package:flutter/material.dart';
import 'package:tetris_app/logic/shape.dart';
import 'package:tetris_app/widgets/next_piece_widget.dart';

class GameHudWidget extends StatelessWidget {
  const GameHudWidget({
    super.key,
    required this.score,
    required this.level,
    required this.lines,
    required this.nextShape,
    required this.isPaused,
    required this.onPauseTop,
  });

  final int score;
  final int level;
  final int lines;
  final Shape nextShape;
  final bool isPaused;
  final VoidCallback onPauseTop;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _InfoBox(label: 'SCORE', value: '$score'),
          _InfoBox(label: 'LEVEL', value: '$level'),
          _InfoBox(label: 'LINES', value: '$lines'),
          Column(
            children: [
              const Text(
                'NEXT',
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),
              const SizedBox(height: 4),
              NextPieceWidget(nextShape: nextShape),
            ],
          ),
          IconButton(
            icon: Icon(
              isPaused ? Icons.play_arrow : Icons.pause,
              color: Colors.white,
              size: 48,
            ),
            onPressed: onPauseTop,
          ),
        ],
      ),
    );
  }
}

class _InfoBox extends StatelessWidget {
  const _InfoBox({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white54, fontSize: 12),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
