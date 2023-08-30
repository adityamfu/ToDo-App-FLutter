import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../services/test2_enum.dart';

class DatabaseHelperSche {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<List<Map<String, dynamic>>> queryLessonsForDay(DateTime date) async {
    final db = await database;
    return await db.query(
      'lessons',
      where: 'day = ?',
      whereArgs: [DateFormat('EEEE').format(date)],
    );
  }

  static Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'lessons.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE lessons(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            day TEXT,
            time TEXT,
            course TEXT,
            room TEXT,
            sks INTEGER
          )
        ''');
      },
    );
  }

  static Future<void> insertLesson(Lesson lesson) async {
    final db = await database;
    await db.insert(
      'lessons',
      lesson.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> deleteLesson(int id) async {
    final db = await database;
    await db.delete(
      'lessons',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // ... add other methods as needed
}
