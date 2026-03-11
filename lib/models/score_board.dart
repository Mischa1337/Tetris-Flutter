import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ScoreEntry {
  final int score;
  final int lines;
  final DateTime date;

  ScoreEntry({required this.score, required this.lines, required this.date});

  // ScoreEntry -> Map (zum Speichern)
  Map<String, dynamic> toJson() => {
    'score': score,
    'lines': lines,
    'date': date.toIso8601String(),
  };

  // Map -> ScoreEntry (beim Laden)
  factory ScoreEntry.fromJson(Map<String, dynamic> json) => ScoreEntry(
    score: json['score'] as int,
    lines: json['lines'] as int,
    date: DateTime.parse(json['date'] as String),
  );
}

class ScoreBoard {
  static const int maxEntries = 3;
  static const String _key = 'highscores';
  final List<ScoreEntry> entries;

  ScoreBoard() : entries = [];

  // Neuen Score hinzufügen und sortieren
  void add(int score, int lines) {
    entries.add(ScoreEntry(score: score, lines: lines, date: DateTime.now()));
    entries.sort((a, b) => b.score.compareTo(a.score));
    if (entries.length > maxEntries) entries.removeLast();
  }

  bool isHighScore(int score) =>
      entries.length < maxEntries || score > entries.last.score;

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    final json = entries.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList(_key, json);
  }

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getStringList(_key) ?? [];
    entries.clear();
    entries.addAll(json.map((s) => ScoreEntry.fromJson(jsonDecode(s))));
  }
}
