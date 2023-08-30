import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'my_database.db');
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE dropdown_data (
        id INTEGER PRIMARY KEY,
        selected_value INTEGER
      )
    ''');
  }

  Future<void> insertDropdownValue(int selectedValue) async {
    Database db = await instance.database;
    await db.insert('dropdown_data', {'selected_value': selectedValue});
  }

  Future<int> getSavedDropdownValue() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> results =
        await db.query('dropdown_data', orderBy: 'id DESC');
    if (results.isNotEmpty) {
      return results.first['selected_value'];
    }
    return 1; // Default value if no data is found
  }

  Future<List<int>> getAllSavedValues() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> results =
        await db.query('dropdown_data', orderBy: 'id DESC');
    return results.map<int>((result) => result['selected_value']).toList();
  }
}

class DailyTaskScreen extends StatefulWidget {
  @override
  _DailyTaskScreenState createState() => _DailyTaskScreenState();
}

class _DailyTaskScreenState extends State<DailyTaskScreen> {
  int selectedValue = 1; // Initial selected value
  List<int> savedValues = [];

  @override
  void initState() {
    super.initState();
    _loadSavedValue();
  }

  Future<void> _loadSavedValue() async {
    selectedValue = await DatabaseHelper.instance.getSavedDropdownValue();
    savedValues = await DatabaseHelper.instance.getAllSavedValues();
    setState(() {});
  }

  void _onDropdownChanged(int? newValue) {
    setState(() {
      selectedValue = newValue!;
    });
    DatabaseHelper.instance.insertDropdownValue(newValue!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dropdown Example with SQLite'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<int>(
              value: selectedValue,
              onChanged: _onDropdownChanged,
              items: dropdownItems,
            ),
            SizedBox(height: 20),
            Text('Selected Value: $selectedValue'),
            SizedBox(height: 20),
            Text('Saved Values:'),
            Column(
              children:
                  savedValues.map((value) => Text(value.toString())).toList(),
            ),
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<int>> get dropdownItems {
    return [
      DropdownMenuItem(
        value: 1,
        child: Text('Option 1'),
      ),
      DropdownMenuItem(
        value: 2,
        child: Text('Option 2'),
      ),
      DropdownMenuItem(
        value: 3,
        child: Text('Option 3'),
      ),
    ];
  }
}
