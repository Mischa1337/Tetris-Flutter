import 'package:flutter_test/flutter_test.dart';
import 'package:tetris_app/logic/board.dart';
import 'package:tetris_app/logic/shape.dart';
import 'package:tetris_app/logic/tetromino_type.dart';
import 'package:tetris_app/logic/game_controller.dart';

void main() {
  // ──────────────────────────────────────────────
  // Board Tests
  // ──────────────────────────────────────────────
  group('Board', () {
    test('startet leer', () {
      final board = Board();
      expect(board.cells.every((c) => c == 0), true);
    });

    test('isValidPosition: Stein in der Mitte ist gültig', () {
      final board = Board();
      final shape = Shape(TetrominoType.O); // O-Stein startet bei col=4
      expect(board.isValidPosition(shape), true);
    });

    test('isValidPosition: Stein außerhalb rechts ist ungültig', () {
      final board = Board();
      // O-Stein weit nach rechts schieben (col=9 + offset=1 → außerhalb)
      final shape = Shape(TetrominoType.O, anchorCol: 9);
      expect(board.isValidPosition(shape), false);
    });

    test('isValidPosition: Stein außerhalb unten ist ungültig', () {
      final board = Board();
      final shape = Shape(TetrominoType.O, anchorRow: boardHeight - 1);
      expect(board.isValidPosition(shape), false);
    });

    test('freeze: schreibt Stein ins Board', () {
      final board = Board();
      final shape = Shape(TetrominoType.O, anchorRow: 0, anchorCol: 0);
      board.freeze(shape);
      // O-Stein belegt (0,0), (1,0), (0,1), (1,1) → Wert != 0
      expect(board.isEmpty(0, 0), false);
      expect(board.isEmpty(0, 1), false);
    });

    test('clearLines: volle Zeile wird gelöscht', () {
      final board = Board();
      // Zeile 9 (unterste) komplett füllen
      for (int col = 0; col < boardWidth; col++) {
        board.cells[9 * boardWidth + col] = 1;
      }
      final cleared = board.clearLines();
      expect(cleared, 1);
      // Zeile 9 muss jetzt wieder leer sein
      expect(board.isEmpty(9, 0), true);
    });

    test('clearLines: gibt 0 zurück wenn keine Zeile voll', () {
      final board = Board();
      expect(board.clearLines(), 0);
    });
  });

  // ──────────────────────────────────────────────
  // Shape Tests
  // ──────────────────────────────────────────────
  group('Shape', () {
    test('moveDown erhöht anchorRow um 1', () {
      final shape = Shape(TetrominoType.T);
      expect(shape.moveDown().anchorRow, shape.anchorRow + 1);
    });

    test('moveLeft verringert anchorCol um 1', () {
      final shape = Shape(TetrominoType.T);
      expect(shape.moveLeft().anchorCol, shape.anchorCol - 1);
    });

    test('moveRight erhöht anchorCol um 1', () {
      final shape = Shape(TetrominoType.T);
      expect(shape.moveRight().anchorCol, shape.anchorCol + 1);
    });

    test('rotate erhöht rotation um 1', () {
      final shape = Shape(TetrominoType.T);
      expect(shape.rotate().rotation, 1);
    });

    test('rotate springt nach 4 wieder auf 0', () {
      var shape = Shape(TetrominoType.T);
      for (int i = 0; i < 4; i++) { shape = shape.rotate(); }
      expect(shape.rotation, 0);
    });

    test('Shape ist unveränderlich: original bleibt gleich', () {
      final shape = Shape(TetrominoType.T, anchorRow: 3, anchorCol: 4);
      shape.moveDown(); // gibt neue Shape zurück, original bleibt
      expect(shape.anchorRow, 3);
    });
  });

  // ──────────────────────────────────────────────
  // GameController Tests
  // ──────────────────────────────────────────────
  group('GameController', () {
    test('startet mit Score 0, Level 1', () {
      final ctrl = GameController();
      expect(ctrl.score, 0);
      expect(ctrl.level, 1);
      expect(ctrl.linesCleared, 0);
      expect(ctrl.isGameOver, false);
    });

    test('reset setzt alles zurück', () {
      final ctrl = GameController();
      ctrl.score = 500;
      ctrl.level = 3;
      ctrl.reset();
      expect(ctrl.score, 0);
      expect(ctrl.level, 1);
      expect(ctrl.isGameOver, false);
    });

    test('moveLeft bewegt Stein nach links', () {
      final ctrl = GameController();
      final startCol = ctrl.currentShape.anchorCol;
      ctrl.moveLeft();
      expect(ctrl.currentShape.anchorCol, startCol - 1);
    });

    test('moveRight bewegt Stein nach rechts', () {
      final ctrl = GameController();
      final startCol = ctrl.currentShape.anchorCol;
      ctrl.moveRight();
      expect(ctrl.currentShape.anchorCol, startCol + 1);
    });

    test('pause stoppt Ticker', () {
      final ctrl = GameController();
      ctrl.start();
      ctrl.pause();
      expect(ctrl.isPaused, true);
      expect(ctrl.ticker, null);
    });

    test('resume setzt Spiel fort', () {
      final ctrl = GameController();
      ctrl.start();
      ctrl.pause();
      ctrl.resume();
      expect(ctrl.isPaused, false);
    });
  });
}
