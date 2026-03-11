import 'package:flutter/material.dart';
import 'package:tetris_app/models/score_board.dart';
import 'package:tetris_app/screens/game_screen.dart';
import 'package:tetris_app/screens/home_screen.dart';
import 'package:tetris_app/models/game_settings.dart';

class GameOverScreen extends StatelessWidget {
  final int score;
  final String playerName;
  final ScoreBoard scoreBoard;
  final GameSettings settings;

  const GameOverScreen({
    super.key,
    required this.score,
    required this.playerName,
    required this.scoreBoard,
    required this.settings,
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
                'GAME OVER',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 16),
              Text('$score Punkte', style: const TextStyle(fontSize: 32)),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => GameScreen(
                          playerName: playerName,
                          scoreBoard: scoreBoard,
                          settings: settings,
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
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (_) => HomeScreen(
                          playerName: playerName,
                          scoreBoard: scoreBoard,
                          settings: settings,
                        ),
                      ),
                      (route) => route.isFirst,
                    );
                  },
                  child: const Text('Zurück zum Hauptmenü'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
