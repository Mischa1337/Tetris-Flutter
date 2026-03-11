import 'package:flutter/material.dart';

class DpadWidget extends StatelessWidget {
  const DpadWidget({
    super.key,
    required this.onLeft,
    required this.onRight,
    required this.onRotate,
    required this.onDrop,
  });

  final VoidCallback onLeft;
  final VoidCallback onRight;
  final VoidCallback onRotate;
  final VoidCallback onDrop;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SizedBox(
        height: 120,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: _button(Icons.arrow_left, onLeft)),
            Expanded(
              child: Column(
                children: [
                  Expanded(child: _button(Icons.rotate_right, onRotate)),
                  Expanded(child: _button(Icons.arrow_downward, onDrop)),
                ],
              ),
            ),
            Expanded(child: _button(Icons.arrow_right, onRight)),
          ],
        ),
      ),
    );
  }

  Widget _button(IconData icon, VoidCallback onPressed) {
    return IconButton(
      icon: Icon(icon, color: Colors.white, size: 40),
      onPressed: onPressed,
    );
  }
}
