import 'package:flutter/material.dart';
import 'package:tetris_app/logic/score_board.dart';

class HighscoreScreen extends StatelessWidget {
  final ScoreBoard scoreBoard;

  const HighscoreScreen({super.key, required this.scoreBoard});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Highscores'),
        automaticallyImplyLeading: false, // kein Zurück-Pfeil
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            const Text(
              'Top 3',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            if (scoreBoard.entries.isEmpty)
              const Text('Noch keine Scores vorhanden.')
            else
              ...scoreBoard.entries.asMap().entries.map((entry) {
                final index = entry.key + 1;
                final score = entry.value;
                return ListTile(
                  leading: Text(
                    '$index.',
                    style: const TextStyle(fontSize: 20),
                  ),
                  title: Text('${score.score} Punkte'),
                  subtitle: Text('${score.lines} Linien'),
                );
              }),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Zurück zum Menü'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
