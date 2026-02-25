import 'dart:async';
import 'package:tetris_app/logic/game_controller_base.dart';

mixin GameLoopMixin on GameControllerBase {
  // Geschwindigkeit steigt mit Level: Level 1 = 800ms, Level 10 = 100ms
  Duration get _tickInterval =>
      Duration(milliseconds: (800 - (level - 1) * 75).clamp(100, 800));

  // Starte das Spiel -> Timer beginnt zu ticken
  @override
  void start() {
    if (isGameOver || isPaused) return;
    ticker = Timer.periodic(_tickInterval, (_) => _tick());
  }

  // Pausiert das Spiel -> Timer wird gestoppt
  void pause() {
    if (isGameOver || isPaused) return;
    isPaused = true;
    ticker?.cancel();
    ticker = null;
  }

  // Setzt fort -> neuer Timer mit aktueller Geschwindigkeit
  void resume() {
    if (!isPaused || isGameOver) return;
    isPaused = false;
    start();
  }

  // Wird vom Timer aufgerufen - Herzstück der Spielschleife
  void _tick() {
    if (isPaused || isGameOver) return;
    final moved = currentShape.moveDown();
    if (board.isValidPosition(moved)) {
      currentShape = moved;
    } else {
      landPiece();
    }
    onUpdate?.call(); // UI neu zeichnen
  }
}
