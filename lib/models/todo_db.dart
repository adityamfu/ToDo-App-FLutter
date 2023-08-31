import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelperTodo {
  // Singleton pattern to ensure only one instance of DatabaseHelperTodo is created.
  DatabaseHelperTodo._privateConstructor();
  static final DatabaseHelperTodo instance = DatabaseHelperTodo._privateConstructor();

  // A reference to the database.
  Database? _database;

  // Get a reference to the database (open it if it doesn't exist).
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    // If _database is null, initialize it.
    _database = await initDatabase();
    return _database!;
  }

  // Initialize the database.
  Future<Database> initDatabase() async {
    final path = join(await getDatabasesPath(), 'todo.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE tasks(
            id INTEGER PRIMARY KEY,
            name TEXT,
            priority TEXT,
            category TEXT,
            isDone INTEGER,
            createdAt INTEGER,
            completedAt INTEGER,
            startTime INTEGER,
            endTime INTEGER,
            description TEXT
          )
        ''');
      },
    );
    return _database!;
  }

  // Insert a task into the database.
  Future<void> insertTask(Map<String, dynamic> row) async {
    final db = await instance.database;
    await db.insert('tasks', row);
  }

  // Query all rows in the tasks table.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    final db = await instance.database;
    return await db.query('tasks');
  }
Future<void> deleteTask(String taskName) async {
  final db = await instance.database;
  await db.delete('tasks', where: 'name = ?', whereArgs: [taskName]);
}

  // Future<void> deleteTask(int id) async {
  //   final db = await instance.database;
  //   await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  // }

  // Other methods to manipulate the database can be added here.

  // ...
}
