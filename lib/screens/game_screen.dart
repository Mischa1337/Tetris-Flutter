import 'package:flutter/material.dart';
import 'package:tetris_app/logic/game_controller.dart';
import 'package:tetris_app/models/score_board.dart';
import 'package:tetris_app/widgets/board_widget.dart';
import 'package:tetris_app/widgets/next_piece_widget.dart';
import 'package:tetris_app/screens/game_over_screen.dart';
import 'package:tetris_app/models/game_settings.dart';
import 'package:tetris_app/widgets/game_hud_widget.dart';
import 'package:tetris_app/widgets/dpad_widget.dart';

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
  late final GameController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = GameController(scoreBoard: widget.scoreBoard);
    // onUpdate: nach jedem Tick → setState() → Flutter zeichnet neu
    _ctrl.addListener(_onControllerUpdate);
    _ctrl.start();
  }

  void _onControllerUpdate() {
    if (_ctrl.isGameOver && mounted) {
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

  @override
  void dispose() {
    _ctrl.removeListener(_onControllerUpdate);
    _ctrl.ticker?.cancel();
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _ctrl,
      builder: (context, _) => Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            children: [
              GameHudWidget(
                score: _ctrl.score,
                level: _ctrl.level,
                lines: _ctrl.linesCleared,
                nextShape: _ctrl.nextShape,
                isPaused: _ctrl.isPaused,
                onPauseTap: () {
                  _ctrl.isPaused ? _ctrl.resume() : _ctrl.pause();
                },
              ),

              // ── Spielfeld + Seitenleiste ──────────────────────
              Expanded(
                child: GestureDetector(
                  onTap: widget.settings.controlMode != ControlMode.dpad
                      ? () => _ctrl.rotate()
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
                DpadWidget(
                  onLeft: _ctrl.moveLeft,
                  onRight: _ctrl.moveRight,
                  onRotate: _ctrl.rotate,
                  onDrop: _ctrl.drop,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
