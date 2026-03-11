import 'package:flutter/material.dart';
import 'package:tetris_app/screens/login_screen.dart';
import 'package:tetris_app/models/score_board.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final scoreBoard = ScoreBoard();
  await scoreBoard.load();

  runApp(TetrisApp(scoreBoard: scoreBoard));
}

class TetrisApp extends StatelessWidget {
  const TetrisApp({super.key, required this.scoreBoard});
  final ScoreBoard scoreBoard;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tetris',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(), // dunkles Theme passt zu Tetris
      home: LoginScreen(scoreBoard: scoreBoard),
    );
  }
}
