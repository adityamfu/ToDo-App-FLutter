import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'course.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Future<List<Map<String, dynamic>>> getAllCoursesBySemester(
  //     int semesterNumber) async {
  //   Database db = await instance.database;
  //   return await db
  //       .query('courses', where: 'semester = ?', whereArgs: [semesterNumber]);
  // }
  Future<List<Course>> getAllCoursesBySemester(int semesterNumber) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> courseMaps = await db.query(
      'courses',
      where: 'semester = ?',
      whereArgs: [semesterNumber],
    );
    List<Course> courses =
        courseMaps.map((courseMap) => Course.fromMap(courseMap)).toList();
    return courses;
  }

  // Future<List<Map<String, dynamic>>> getAllCoursesBySemester(
  //     int semesterNumber) async {
  //   Database db = await instance.database;
  //   return await db
  //       .query('courses', where: 'semester = ?', whereArgs: [semesterNumber]);
  // }

  Future<int> deleteCourse(int courseId) async {
    Database db = await instance.database;
    return await db.delete('courses', where: 'id = ?', whereArgs: [courseId]);
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'courses.db');
    Database database = await openDatabase(path,
        version: 3, // Update the version number
        onCreate: _onCreate,
        onUpgrade: _onUpgrade);
    return database;
  }
Future<void> updateCourse(Course course) async {
    Database db = await instance.database;
    
    await db.update(
      'courses',
      course.map(), // Mengubah objek Course menjadi Map<String, dynamic>
      where: 'id = ?',
      whereArgs: [course.id],
    );
  }
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      if (oldVersion == 2) {
        // Migrate from version 2 to version 3
        await db.execute('ALTER TABLE courses ADD COLUMN semester INTEGER');
      }
    }
  }

  // Future<Database> _initDatabase() async {
  //   String path = join(await getDatabasesPath(), 'courses.db');
  //   return await openDatabase(path, version: 1, onCreate: _onCreate);
  // }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE courses(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        courseName TEXT,
        sks TEXT,
        room TEXT,
        lecturer TEXT,
        weekday TEXT,
        semester INTEGER 
      )
    ''');
  }

  Future<int> insertCourse(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert('courses', row);
  }

  Future<List<Map<String, dynamic>>> getAllCourses() async {
    Database db = await instance.database;
    return await db.query('courses');
  }
}
