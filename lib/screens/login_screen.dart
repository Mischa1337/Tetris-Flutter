import 'package:flutter/material.dart';
import 'package:tetris_app/logic/score_board.dart';
import 'package:tetris_app/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _fromKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_fromKey.currentState!.validate()) {
      final name = _nameController.text.trim();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) =>
              HomeScreen(playerName: name, scoreBoard: ScoreBoard()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Form(
            key: _fromKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Tetris',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 8,
                  ),
                ),
                const SizedBox(height: 48),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Dein Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Bitte gib einen Namen ein';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _onSubmit,
                    child: const Text('Spielen'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
