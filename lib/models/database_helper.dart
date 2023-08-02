// import 'dart:async';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import 'package:to_do/models/task_repo.dart';

// class DatabaseHelper {
//   static final DatabaseHelper _instance = DatabaseHelper._internal();

//   factory DatabaseHelper() => _instance;

//   DatabaseHelper._internal();

//   Database? _database;

//   Future<Database?> get database async {
//     if (_database != null) return _database;
//     _database = await initDatabase();
//     return _database;
//   }

//   Future<Database> initDatabase() async {
//     final databasesPath = await getDatabasesPath();
//     final path = join(databasesPath, 'tasks.db');
//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: (Database db, int version) async {
//         await db.execute('''
//           CREATE TABLE tasks (
//             id INTEGER PRIMARY KEY,
//             name TEXT NOT NULL,
//             priority TEXT NOT NULL,
//             category TEXT NOT NULL,
//             isDone INTEGER NOT NULL,
//             createdAt TEXT NOT NULL,
//             completedAt TEXT NOT NULL,
//             startTime TEXT NOT NULL,
//             endTime TEXT NOT NULL,
//             isReminderOn INTEGER NOT NULL,
//             reminderTime TEXT
//           )
//         ''');
//       },
//     );
//   }

//   Future<void> insertTask(TodoTask task) async {
//     final db = await database;
//     await db!.insert(
//       'tasks',
//       task.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   Future<List<TodoTask>> getTasks() async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db!.query('tasks');
//     return List.generate(maps.length, (index) {
//       return TodoTask.fromMap(maps[index]);
//     });
//   }
// }
