import 'package:tetris_app/logic/game_controller_base.dart';

mixin InputMixin on GameControllerBase {
  void moveLeft() {
    if (isPaused || isGameOver) return;
    final moved = currentShape.moveLeft();
    if (board.isValidPosition(moved)) currentShape = moved;
    onUpdate?.call();
  }

  void moveRight() {
    if (isPaused || isGameOver) return;
    final moved = currentShape.moveRight();
    if (board.isValidPosition(moved)) currentShape = moved;
    onUpdate?.call();
  }

  void rotate() {
    if (isPaused || isGameOver) return;
    final rotated = currentShape.rotate();
    if (board.isValidPosition(rotated)) currentShape = rotated;
    onUpdate?.call();
  }

  // Stein sofort bis ganz nach unten fallen lassen
  void drop() {
    if (isPaused || isGameOver) return;
    while (board.isValidPosition(currentShape.moveDown())) {
      currentShape = currentShape.moveDown();
    }
    landPiece();
    onUpdate?.call();
  }
}
