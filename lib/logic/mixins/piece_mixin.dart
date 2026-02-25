import 'package:tetris_app/logic/game_controller_base.dart';

mixin PieceMixin on GameControllerBase {
  // Stein landet: einfrieren -> Zeilen löschen -> Score -> nächster Stein
  @override
  void landPiece() {
    board.freeze(currentShape);
    final cleared = board.clearLines();
    addScore(cleared);
    _spawnNext();
  }

  // nextShape wird currentShape, neues nextShape wird generiert
  void _spawnNext() {
    currentShape = nextShape;
    nextShape = randomShape();
    _checkGameOver();
  }

  // Game Over wenn neuer Stein sofort an belegter Stelle spawnt
  void _checkGameOver() {
    if (!board.isValidPosition(currentShape)) {
      isGameOver = true;
      ticker?.cancel();
      scoreBoard.add(score, linesCleared);
    }
  }
}
