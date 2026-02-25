class ScoreEntry {
  final int score;
  final int lines;
  final DateTime date;

  ScoreEntry({required this.score, required this.lines, required this.date});
}

class ScoreBoard {
  static const int maxEntries = 3;
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
}
