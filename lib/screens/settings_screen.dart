import 'package:flutter/material.dart';
import 'package:tetris_app/models/game_settings.dart';

class SettingsScreen extends StatefulWidget {
  final GameSettings settings;
  const SettingsScreen({super.key, required this.settings});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Einstellungen')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Steuerung',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SegmentedButton<ControlMode>(
              segments: const [
                ButtonSegment(
                  value: ControlMode.both,
                  label: Text('D-Pad + Gesten'),
                ),
                ButtonSegment(
                  value: ControlMode.dpad,
                  label: Text('Nur D-Pad'),
                ),
                ButtonSegment(
                  value: ControlMode.gesture,
                  label: Text('Nur Gesten'),
                ),
              ],
              selected: {widget.settings.controlMode},
              onSelectionChanged: (Set<ControlMode> newSelection) {
                setState(() {
                  widget.settings.controlMode = newSelection.first;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
