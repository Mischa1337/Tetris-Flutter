import 'package:flutter/material.dart';
import 'package:tetris_app/screens/login_screen.dart';

void main() {
  runApp(const TetrisApp());
}

class TetrisApp extends StatelessWidget {
  const TetrisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tetris',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(), // dunkles Theme passt zu Tetris
      home: const LoginScreen(),
    );
  }
}
