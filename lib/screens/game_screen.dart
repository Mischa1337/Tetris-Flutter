import 'package:flutter/material.dart';
import 'package:tetris_app/logic/game_controller.dart';
import 'package:tetris_app/logic/score_board.dart';
import 'package:tetris_app/widgets/board_widget.dart';
import 'package:tetris_app/widgets/next_piece_widget.dart';
import 'package:tetris_app/screens/game_over_screen.dart';
import 'package:tetris_app/logic/game_settings.dart';

// StatefulWidget: hat einen veränderbaren State (den GameController)
class GameScreen extends StatefulWidget {
  const GameScreen({
    super.key,
    required this.playerName,
    required this.scoreBoard,
    required this.settings,
  });
  final String playerName;
  final ScoreBoard scoreBoard;
  final GameSettings settings;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  // Der Controller lebt hier — genau so lang wie der Screen
  final GameController _ctrl = GameController();
  bool _scoreSaved = false;

  @override
  void initState() {
    super.initState();
    // onUpdate: nach jedem Tick → setState() → Flutter zeichnet neu
    _ctrl.onUpdate = () {
      if (_ctrl.isGameOver && !_scoreSaved) {
        _scoreSaved = true;
        widget.scoreBoard.add(_ctrl.score, _ctrl.linesCleared);
        if (mounted) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => GameOverScreen(
                score: _ctrl.score,
                playerName: widget.playerName,
                scoreBoard: widget.scoreBoard,
                settings: widget.settings,
              ),
            ),
          );
        }
      }
      setState(() {});
    };
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
                  // Next Piece
                  Column(
                    children: [
                      const Text(
                        'NEXT',
                        style: TextStyle(color: Colors.white54, fontSize: 12),
                      ),
                      const SizedBox(height: 4),
                      NextPieceWidget(nextShape: _ctrl.nextShape),
                    ],
                  ),
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
            ),

            // ── Spielfeld + Seitenleiste ──────────────────────
            Expanded(
              child: GestureDetector(
                onTap: widget.settings.controlMode != ControlMode.dpad
                    ? () => setState(() => _ctrl.rotate())
                    : null,
                onHorizontalDragEnd:
                    widget.settings.controlMode != ControlMode.dpad
                    ? (details) {
                        if ((details.primaryVelocity ?? 0) < 0) {
                          _ctrl.moveLeft();
                        } else {
                          _ctrl.moveRight();
                        }
                      }
                    : null,
                onVerticalDragEnd:
                    widget.settings.controlMode != ControlMode.dpad
                    ? (details) {
                        if ((details.primaryVelocity ?? 0) > 0) _ctrl.drop();
                      }
                    : null,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: BoardWidget(
                      board: _ctrl.board,
                      currentShape: _ctrl.currentShape,
                    ),
                  ),
                ),
              ),
            ),

            // ── Steuerbuttons (Mobile) ────────────────────────
            if (!_ctrl.isGameOver &&
                widget.settings.controlMode != ControlMode.gesture)
              _buildControls(),
          ],
        ),
      ),
    );
  }

  // Steuerleiste am unteren Rand
  Widget _buildControls() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SizedBox(
        height: 120,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Linke Spalte - Links
            Expanded(child: _controlButton(Icons.arrow_left, _ctrl.moveLeft)),
            // Mittlere Spalte - oben Rotieren, unten Drop
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: _controlButton(Icons.rotate_right, _ctrl.rotate),
                  ),
                  Expanded(
                    child: _controlButton(Icons.arrow_downward, _ctrl.drop),
                  ),
                ],
              ),
            ),
            // Rechte Spalte - Rechts
            Expanded(child: _controlButton(Icons.arrow_right, _ctrl.moveRight)),
          ],
        ),
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
