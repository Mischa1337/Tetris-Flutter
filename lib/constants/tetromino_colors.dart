import 'package:flutter/material.dart';
import 'package:tetris_app/logic/tetromino_type.dart';

// Klassische Tetris-Farben für jeden Steintyp
const Map<TetrominoType, Color> tetrominoColors = {
  TetrominoType.I: Colors.cyan,
  TetrominoType.O: Colors.yellow,
  TetrominoType.T: Colors.purple,
  TetrominoType.L: Colors.orange,
  TetrominoType.J: Colors.blue,
  TetrominoType.S: Colors.green,
  TetrominoType.Z: Colors.red,
};
