import 'package:tetris_app/logic/game_controller_base.dart';

mixin ScoringMixin on GameControllerBase {
  // Punktetabelle: klassisches Tetris-Scoring
  static const _scoreTable = [0, 100, 300, 500, 800];

  // Punkte addieren + Level prüfen
  @override
  void addScore(int clearedLines) {
    if (clearedLines == 0) return;
    score += _scoreTable[clearedLines] * level;
    linesCleared += clearedLines;
    _updateLevel();
  }

  // Alle 10 Zeilen -> Level steigt
  void _updateLevel() {
    final newLevel = (linesCleared ~/ 10) + 1;
    if (newLevel > level) {
      level = newLevel;
      _restartTicker();
    }
  }

  // Timer neu starten mit neuer Geschwindigkeit
  void _restartTicker() {
    ticker?.cancel();
    ticker = null;
    start();
  }
}
