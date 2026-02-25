// Tetromino Bezeichnungen
enum TetrominoType { I, O, T, L, J, S, Z }

// Offset-Tabelle
const Map<TetrominoType, List<List<(int, int)>>> tetrominoOffsets = {
  TetrominoType.I: [
    [(0, 0), (1, 0), (2, 0), (3, 0)], // Rotation 0: 0   Grad
    [(0, 0), (0, 1), (0, 2), (0, 3)], // Rotation 1: 90  Grad
    [(0, 0), (1, 0), (2, 0), (3, 0)], // Rotation 2: 180 Grad
    [(0, 0), (0, 1), (0, 2), (0, 3)], // Rotation 3: 270 Grad
  ],

  TetrominoType.O: [
    [(0, 0), (1, 0), (0, 1), (1, 1)], // Rotation 0: 0   Grad
    [(0, 0), (1, 0), (0, 1), (1, 1)], // Rotation 1: 90  Grad
    [(0, 0), (1, 0), (0, 1), (1, 1)], // Rotation 2: 180 Grad
    [(0, 0), (1, 0), (0, 1), (1, 1)], // Rotation 3: 270 Grad
  ],

  TetrominoType.T: [
    [(0, 0), (1, 0), (2, 0), (1, 1)], // Rotation 0: 0   Grad
    [(0, 0), (0, 1), (0, 2), (1, 1)], // Rotation 1: 90  Grad
    [(1, 0), (0, 1), (1, 1), (2, 1)], // Rotation 2: 180 Grad
    [(1, 0), (0, 1), (1, 1), (1, 2)], // Rotation 3: 270 Grad
  ],

  TetrominoType.L: [
    [(0, 0), (1, 0), (2, 0), (2, 1)], // Rotation 0: 0   Grad
    [(0, 0), (0, 1), (0, 2), (1, 2)], // Rotation 1: 90  Grad
    [(0, 0), (0, 1), (1, 1), (2, 1)], // Rotation 2: 180 Grad
    [(0, 0), (1, 0), (1, 1), (1, 2)], // Rotation 3: 270 Grad
  ],

  TetrominoType.J: [
    [(0, 0), (1, 0), (2, 0), (0, 1)], // Rotation 0: 0   Grad
    [(0, 0), (1, 0), (1, 1), (1, 2)], // Rotation 1: 90  Grad
    [(2, 0), (0, 1), (1, 1), (2, 1)], // Rotation 2: 180 Grad
    [(0, 0), (0, 1), (0, 2), (1, 2)], // Rotation 3: 270 Grad
  ],

  TetrominoType.S: [
    [(1, 0), (2, 0), (0, 1), (1, 1)], // Rotation 0: 0   Grad
    [(0, 0), (0, 1), (1, 1), (1, 2)], // Rotation 1: 90  Grad
    [(1, 0), (2, 0), (0, 1), (1, 1)], // Rotation 2: 180 Grad
    [(0, 0), (0, 1), (1, 1), (1, 2)], // Rotation 3: 270 Grad
  ],

  TetrominoType.Z: [
    [(0, 0), (1, 0), (1, 1), (2, 1)], // Rotation 0: 0   Grad
    [(1, 0), (0, 1), (1, 1), (0, 2)], // Rotation 1: 90  Grad
    [(0, 0), (1, 0), (1, 1), (2, 1)], // Rotation 2: 180 Grad
    [(1, 0), (0, 1), (1, 1), (0, 2)], // Rotation 3: 270 Grad
  ],
};
