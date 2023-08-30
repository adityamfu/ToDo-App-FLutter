import 'package:sqflite/sqflite.dart';

import 'lesson.dart';
import 'lesson_db.dart';

class LessonRepository {
  final dbHelper = DatabaseHelper.instance;

  Future<void> insertLesson(Lesson lesson) async {
    final db = await dbHelper.database;
    await db.insert('lessons', lesson.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Lesson>> getAllLessons() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('lessons');
    return List.generate(maps.length, (i) {
      return Lesson(
        title: maps[i]['title'],
        description: maps[i]['description'],
        date: DateTime.fromMillisecondsSinceEpoch(maps[i]['date']),
        repeated: maps[i]['repeated'] == 1, id: 1,
      );
    });
  }
}
