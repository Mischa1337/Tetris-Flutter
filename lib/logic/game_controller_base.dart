import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';

import 'package:tetris_app/logic/board.dart';
import 'package:tetris_app/models/score_board.dart';
import 'package:tetris_app/models/shape.dart';
import 'package:tetris_app/models/tetromino_type.dart';

abstract class GameControllerBase extends ChangeNotifier {
  final Board board;
  Shape currentShape;
  Shape nextShape;
  final ScoreBoard scoreBoard;

  int score;
  int level;
  int linesCleared;
  bool isGameOver;
  bool isPaused;

  // Kein Unterstrich: muss von Mixins in anderen Dateien zugreifbar sein
  Timer? ticker;

  Shape randomShape() => Shape(
    TetrominoType.values[Random().nextInt(TetrominoType.values.length)],
  );

  // Abstrakte Schnittstellen für mixin-übergreifende Aufrufe
  void start(); // implementiert von GameLoopMixin
  void landPiece(); // implementiert von PieceMixin
  void addScore(int clearedLines); // implementiert von ScoringMixin

  GameControllerBase({required ScoreBoard scoreBoard})
    : board = Board(),
      scoreBoard = scoreBoard,
      currentShape = Shape(TetrominoType.values[Random().nextInt(7)]),
      nextShape = Shape(TetrominoType.values[Random().nextInt(7)]),
      score = 0,
      level = 1,
      linesCleared = 0,
      isGameOver = false,
      isPaused = false;
}
