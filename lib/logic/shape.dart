import 'tetromino_type.dart';

class Shape {
  // Variuablen
  final TetrominoType type;
  final int anchorRow;
  final int anchorCol;
  final int rotation;

  // Haupt-Konstruktor (erstellen neuen Steins)
  Shape(this.type, {this.anchorRow = 0, this.anchorCol = 4, this.rotation = 0});

  // Named Constructor (kopiert alles, ändert nur was nötig)
  Shape._copy(Shape other, {int? anchorRow, int? anchorCol, int? roation})
    : type = other.type,
      anchorRow = anchorRow ?? other.anchorRow,
      anchorCol = anchorCol ?? other.anchorCol,
      rotation = roation ?? other.rotation;

  // Funktionen / Methoden
  Shape moveDown() => Shape._copy(this, anchorRow: anchorRow + 1);
  Shape moveLeft() => Shape._copy(this, anchorCol: anchorCol - 1);
  Shape moveRight() => Shape._copy(this, anchorCol: anchorCol + 1);
  Shape rotate() => Shape._copy(this, roation: (rotation + 1) % 4);
}
