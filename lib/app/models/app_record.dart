class AppRecord {
  final int? id;
  final String date;
  final int streak;
  final int momentum;
  final bool success;

  const AppRecord({
    this.id,
    required this.date,
    required this.streak,
    required this.momentum,
    required this.success,
  });

  Map<String, dynamic> toMap() => {
        if (id != null) 'id': id,
        'date': date,
        'streak': streak,
        'momentum': momentum,
        'success': success ? 1 : 0,
      };

  factory AppRecord.fromMap(Map<String, dynamic> m) => AppRecord(
        id: m['id'],
        date: m['date'],
        streak: m['streak'],
        momentum: m['momentum'],
        success: m['success'] == 1,
      );
}

