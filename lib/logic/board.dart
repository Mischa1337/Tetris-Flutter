import 'tetromino_type.dart';
import 'shape.dart';

const int boardWidth = 10;
const int boardHeight = 10;

class Board {
  // 0 = leer, 1-7 = Farbe des platzierten Steins
  final List<int> cells;

  // Konstruktor: erstellt leeres Board (200 Nullen)
  Board() : cells = List.filled(boardWidth * boardHeight, 0);

  // Hilfsmethode: (zeile, spalte) -> 1D-Index
  int _index(int row, int col) => row * boardWidth + col;

  // Ist diese Zelle leer?
  bool isEmpty(int row, int col) => cells[_index(row, col)] == 0;

  // Gibt alle 4 Board-Indizes des aktuellen Steins zurück
  List<int> indicesOf(Shape shape) {
    final offsets = tetrominoOffsets[shape.type]![shape.rotation];
    return offsets.map((offset) {
      final col = shape.anchorCol + offset.$1;
      final row = shape.anchorRow + offset.$2;
      return _index(row, col);
    }).toList();
  }

  // Prüft ob eine Shape-Position gültig ist (kein Rand, keine belegte Zelle)
  bool isValidPosition(Shape shape) =>
      tetrominoOffsets[shape.type]![shape.rotation].every((offset) {
        final col = shape.anchorCol + offset.$1;
        final row = shape.anchorRow + offset.$2;
        return col >= 0 &&
            col < boardWidth &&
            row < boardHeight &&
            (row < 0 || isEmpty(row, col));
      });

  // Friert den aktuellen Stein ein (schreibt ihn dauerhaft ins Board)
  void freeze(Shape shape) {
    final colorIndex = shape.type.index + 1;
    for (var offset in tetrominoOffsets[shape.type]![shape.rotation]) {
      cells[_index(shape.anchorRow + offset.$2, shape.anchorCol + offset.$1)] =
          colorIndex;
    }
  }

  // Löscht alle vollen Zeilen, schiebt den Rest nach unten
  // Gibt die Anzahl gelöschter Zeilen zurück (für Score)
  int clearLines() {
    int cleared = 0;
    for (int row = boardHeight - 1; row >= 0; row--) {
      if (_isRowFull(row)) {
        _removeRow(row);
        row++;
        cleared++;
      }
    }
    return cleared;
  }

  //Hilfsmethode: Ist eine Zeile komplett gefüllt?
  bool _isRowFull(int row) =>
      Iterable.generate(boardWidth).every((col) => !isEmpty(row, col));

  // Hilfsmethode: Entfernt eine Zeile, schiebt alles darüber nach unten
  void _removeRow(int targetRow) {
    for (int row = targetRow; row > 0; row--) {
      for (int col = 0; col < boardWidth; col++) {
        cells[_index(row, col)] = cells[_index(row - 1, col)];
      }
    }
    // Oberste Zeile leeren
    for (int col = 0; col < boardWidth; col++) {
      cells[_index(0, col)] = 0;
    }
  }
}
