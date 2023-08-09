import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/course.dart';

class DailyScreenApp extends StatelessWidget {
  final List<Course> coursesFromFirstCode; // Daftar kursus dari kode pertama

  DailyScreenApp({required this.coursesFromFirstCode});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DailyScreen(courses: coursesFromFirstCode),
    );
  }
}

class DailyScreen extends StatefulWidget {
  final List<Course>
      courses; // Tambahkan parameter untuk menerima daftar kursus

  DailyScreen({required this.courses});
  @override
  _DailyScreenState createState() => _DailyScreenState();
}

class _DailyScreenState extends State<DailyScreen> {
  DateTime _selectedDate = DateTime.now();
  List<DateTime> _dates = [];
  String selectedDay = 'Monday';
  List<Course> selectedCourses = [];
  final List<String> daysToRepeat = ['Monday', 'Wednesday', 'Friday'];
  @override
  void initState() {
    super.initState();
    _generateDateList();
  }

  void _generateDateList() {
    final today = DateTime.now();
    _dates.clear();

    // Add selected date to the list
    _dates.add(_selectedDate);

    // Add future dates after the selected date
    for (int i = 1; i <= 30; i++) {
      final date = _selectedDate.add(Duration(days: i));
      _dates.add(date);
    }
  }

  void _selectDate(DateTime date) {
    setState(() {
      _selectedDate = date;
      _generateDateList();
    });
  }

  void _resetToToday() {
    setState(() {
      _selectedDate = DateTime.now();
      _generateDateList();
    });
  }

  void _showRepeatDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Repeat Course'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<String>(
                value: selectedDay,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedDay = newValue!;
                  });
                },
                items: daysToRepeat.map<DropdownMenuItem<String>>((String day) {
                  return DropdownMenuItem<String>(
                    value: day,
                    child: Text(day),
                  );
                }).toList(),
              ),
              SizedBox(height: 10),
              Text('Courses for $selectedDay:'),
              Column(
                children: selectedCourses.map((course) {
                  return ListTile(
                    title: Text(course.courseName),
                    subtitle: Text('SKS: ${course.sks}'),
                  );
                }).toList(),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Screen'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
// Kembali ke halaman utama
            Navigator.popUntil(context, (route) => route.isFirst);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Selected Date: ${DateFormat('EEEE, dd MMMM yyyy').format(_selectedDate)}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: _resetToToday,
                  child: Text('Reset'),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
              ),
              itemCount: _dates.length,
              itemBuilder: (context, index) {
                final date = _dates[index];

                String dateString =
                    DateFormat('EEEE, dd MMMM yyyy').format(date);

                return GestureDetector(
                  onTap: () => _selectDate(date),
                  child: Container(
                    margin: EdgeInsets.all(8),
                    color: _selectedDate == date ? Colors.blue : Colors.white,
                    child: Center(
                      child: Text(
                        dateString,
                        style: TextStyle(
                          color: _selectedDate == date
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          FloatingActionButton(
            onPressed: _showRepeatDialog,
            tooltip: 'Repeat',
            child: Icon(Icons.repeat),
          ),
        ],
      ),
    );
  }
}

class CourseProvider extends ChangeNotifier {
  List<Course> courses =
      []; // Ini perlu diisi dengan data kursus dari kode pertama

  void updateCourses(List<Course> newCourses) {
    courses = newCourses;
    notifyListeners();
  }
}
