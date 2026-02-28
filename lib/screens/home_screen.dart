import 'package:flutter/material.dart';
import 'package:tetris_app/screens/game_screen.dart';
import 'package:tetris_app/logic/score_board.dart';
import 'package:tetris_app/screens/highscore_screen.dart';

class HomeScreen extends StatelessWidget {
  final String playerName;
  final ScoreBoard scoreBoard;

  const HomeScreen({
    super.key,
    required this.playerName,
    required this.scoreBoard,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Tetris',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 8,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Hallo, $playerName!',
                style: const TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => GameScreen(
                          playerName: playerName,
                          scoreBoard: scoreBoard,
                        ),
                      ),
                    );
                  },
                  child: const Text('Neues Spiel'),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => HighscoreScreen(scoreBoard: scoreBoard),
                      ),
                    );
                  },
                  child: const Text('Highscore'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
