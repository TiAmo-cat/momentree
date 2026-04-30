import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/app_record.dart';

class StorageService {
  static Database? _db;

  static Future<Database> get db async {
    _db ??= await _init();
    return _db!;
  }

  static Future<Database> _init() async {
    final path = join(await getDatabasesPath(), 'momentum.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) => db.execute('''
        CREATE TABLE records (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          date TEXT NOT NULL,
          streak INTEGER NOT NULL,
          momentum INTEGER NOT NULL,
          success INTEGER NOT NULL
        )
      '''),
    );
  }

  static Future<void> insertRecord(AppRecord record) async {
    final d = await db;
    await d.insert('records', record.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<AppRecord>> getRecords() async {
    final d = await db;
    final maps = await d.query('records', orderBy: 'date DESC', limit: 100);
    return maps.map(AppRecord.fromMap).toList();
  }
}

