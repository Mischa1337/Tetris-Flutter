import 'package:flutter/material.dart';
import 'package:tetris_app/logic/game_controller.dart';
import 'package:tetris_app/widgets/board_widget.dart';
import 'package:tetris_app/widgets/next_piece_widget.dart';

// StatefulWidget: hat einen veränderbaren State (den GameController)
class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  // Der Controller lebt hier — genau so lang wie der Screen
  final GameController _ctrl = GameController();

  @override
  void initState() {
    super.initState();
    // onUpdate: nach jedem Tick → setState() → Flutter zeichnet neu
    _ctrl.onUpdate = () => setState(() {});
    _ctrl.start();
  }

  @override
  void dispose() {
    // Timer stoppen wenn der Screen geschlossen wird
    _ctrl.ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // ── Score-Zeile oben ──────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _infoBox('SCORE', '${_ctrl.score}'),
                  _infoBox('LEVEL', '${_ctrl.level}'),
                  _infoBox('LINES', '${_ctrl.linesCleared}'),
                ],
              ),
            ),

            // ── Spielfeld + Seitenleiste ──────────────────────
            Expanded(
              child: Row(
                children: [
                  // Das Board nimmt den meisten Platz ein
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: BoardWidget(
                        board: _ctrl.board,
                        currentShape: _ctrl.currentShape,
                      ),
                    ),
                  ),
                  // Seitenleiste: nächster Stein
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'NEXT',
                          style: TextStyle(color: Colors.white54, fontSize: 12),
                        ),
                        const SizedBox(height: 4),
                        NextPieceWidget(nextShape: _ctrl.nextShape),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ── Game Over Banner ──────────────────────────────
            if (_ctrl.isGameOver)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  children: [
                    const Text(
                      'GAME OVER',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () => setState(() {
                        _ctrl.reset();
                        _ctrl.start();
                      }),
                      child: const Text('Nochmal'),
                    ),
                  ],
                ),
              ),

            // ── Steuerbuttons (Mobile) ────────────────────────
            if (!_ctrl.isGameOver) _buildControls(),
          ],
        ),
      ),
    );
  }

  // Steuerleiste am unteren Rand
  Widget _buildControls() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _controlButton(Icons.arrow_left, _ctrl.moveLeft),
          _controlButton(Icons.rotate_right, _ctrl.rotate),
          _controlButton(Icons.arrow_downward, _ctrl.drop),
          _controlButton(Icons.arrow_right, _ctrl.moveRight),
          // Pause/Resume Button
          IconButton(
            icon: Icon(
              _ctrl.isPaused ? Icons.play_arrow : Icons.pause,
              color: Colors.white,
              size: 40,
            ),
            onPressed: () => setState(() {
              _ctrl.isPaused ? _ctrl.resume() : _ctrl.pause();
            }),
          ),
        ],
      ),
    );
  }

  Widget _controlButton(IconData icon, VoidCallback onPressed) {
    return IconButton(
      icon: Icon(icon, color: Colors.white, size: 40),
      onPressed: onPressed,
    );
  }

  // Kleine Info-Box für Score, Level, Lines
  Widget _infoBox(String label, String value) {
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
