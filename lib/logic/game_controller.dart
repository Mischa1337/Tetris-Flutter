import 'package:tetris_app/logic/game_controller_base.dart';
import 'package:tetris_app/logic/mixins/game_loop_mixin.dart';
import 'package:tetris_app/logic/mixins/piece_mixin.dart';
import 'package:tetris_app/logic/mixins/scoring_mixin.dart';
import 'package:tetris_app/logic/mixins/input_mixin.dart';
import 'package:tetris_app/logic/score_board.dart';

class GameController extends GameControllerBase
    with GameLoopMixin, PieceMixin, ScoringMixin, InputMixin {
  GameController({required ScoreBoard scoreBoard})
    : super(scoreBoard: scoreBoard);

  // Neustart: setzt alles zurück ohne neues Objekt zu erstellen
  void reset() {
    board.cells.fillRange(0, board.cells.length, 0);
    currentShape = randomShape();
    nextShape = randomShape();
    score = 0;
    level = 1;
    linesCleared = 0;
    isGameOver = false;
    isPaused = false;
    ticker?.cancel();
    ticker = null;
  }
}
