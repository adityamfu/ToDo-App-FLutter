import 'package:flutter/material.dart';
import '../models/test2_db.dart';
import '../services/test2_enum.dart';

class LessonInputScreen extends StatefulWidget {
  @override
  _LessonInputScreenState createState() => _LessonInputScreenState();
}

class _LessonInputScreenState extends State<LessonInputScreen> {
  late TimeOfDay selectedTime = TimeOfDay.now();
  String selectedDay = 'Monday';
  String course = '';
  String room = '';
  int sks = 1;
  List<Lesson> lessonList = [];

  final TextEditingController courseController = TextEditingController();
  final TextEditingController roomController = TextEditingController();
  final TextEditingController sksController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _loadLessons(); // Load lessons when screen starts
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Input Data Mata Kuliah')),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            Wrap(
              alignment: WrapAlignment.start,
              spacing: 8.0,
              children: <Widget>[
                _buildDayButton('Monday'),
                _buildDayButton('Tuesday'),
                _buildDayButton('Wednesday'),
                _buildDayButton('Thursday'),
                _buildDayButton('Friday'),
                _buildDayButton('Saturday'),
                _buildDayButton('Sunday'),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: selectedTime,
                );

                if (pickedTime != null) {
                  setState(() {
                    selectedTime = pickedTime;
                  });
                }
              },
              child: Text('Pilih Waktu: ${selectedTime.format(context)}'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: courseController,
              decoration: InputDecoration(labelText: 'Mata Kuliah'),
              onChanged: (value) {
                setState(() {
                  course = value;
                });
              },
            ),
            TextField(
              controller: roomController,
              decoration: InputDecoration(labelText: 'Ruangan'),
              onChanged: (value) {
                setState(() {
                  room = value;
                });
              },
            ),
            TextField(
              controller: sksController,
              decoration: InputDecoration(labelText: 'SKS'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  sks = int.tryParse(value) ?? 1;
                });
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final Lesson newLesson = Lesson(
                  day: selectedDay,
                  time: selectedTime.format(context),
                  course: courseController.text,
                  room: roomController.text,
                  sks: int.tryParse(sksController.text) ?? 1,
                );
                _addLessonToDatabase(newLesson);
                // await _loadLessons();
              },
              child: Text('Simpan'),
            ),
            SizedBox(height: 16),
            Text('Lesson Data :'),
            // FutureBuilder<List<Lesson>>(
            //   future: _getLessonListFromDatabase(),
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return CircularProgressIndicator();
            //     } else if (snapshot.hasError) {
            //       return Text('Error: ${snapshot.error}');
            //     } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            //       return Text('Belum ada data.');
            //     } else {
            //       return ListView.builder(
            //         shrinkWrap: true,
            //         itemCount: snapshot.data!.length,
            //         itemBuilder: (context, index) {
            //           return ListTile(
            //             // title: Text(
            //             //   '${snapshot.data![index].day}, ${snapshot.data![index].time} - ${snapshot.data![index].course}',
            //             // ),
            //             title: Text(
            //               snapshot.data![index].course,
            //             ),
            //             subtitle: Text(
            //               '${snapshot.data![index].day}, ${snapshot.data![index].time}',
            //             ),

            //             trailing: IconButton(
            //               icon: Icon(Icons.delete),
            //               onPressed: () {
            //                 _deleteLesson(index, context);
            //               },
            //             ),
            //           );
            //         },
            //       );
            //     }
            //   },
            // ),
            FutureBuilder<List<Lesson>>(
              future: _getLessonListFromDatabase(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData ||
                    snapshot.data == null ||
                    snapshot.data!.isEmpty) {
                  return Text('Belum ada data.');
                } else {
                  lessonList = snapshot.data!; // Assign to lessonList
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: lessonList.length,
                    itemBuilder: (context, index) {
                      final Lesson lesson = lessonList[index];
                      return ListTile(
                        title: Text(lesson.course),
                        subtitle: Text('${lesson.day}, ${lesson.time}'),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _deleteLesson(index, context);
                          },
                        ),
                      );
                    },
                  );
                }
              },
            ),

            SizedBox(height: 16),
            Text('Daftar Data dalam Tabel:'),
            FutureBuilder<List<Lesson>>(
              future: _getLessonListFromDatabase(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Text('Belum ada data.');
                } else {
                  return DataTable(
                    columns: [
                      DataColumn(label: Text('Hari')),
                      DataColumn(label: Text('Waktu')),
                      DataColumn(label: Text('Sub')),
                      DataColumn(label: Text('Ruangan')),
                      DataColumn(label: Text('SKS')),
                    ],
                    rows: snapshot.data!.map((lesson) {
                      return DataRow(
                        cells: [
                          DataCell(Text(lesson.day)),
                          DataCell(Text(lesson.time)),
                          DataCell(Text(lesson.course)),
                          DataCell(Text(lesson.room)),
                          DataCell(Text(lesson.sks.toString())),
                        ],
                      );
                    }).toList(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _loadLessons() async {
    final lessons = await _getLessonListFromDatabase();
    setState(() {
      lessonList = lessons;
    });
  }

  Future<List<Lesson>> _getLessonListFromDatabase() async {
    final db = await DatabaseHelperSche.database;
    final List<Map<String, dynamic>> maps = await db.query('lessons');

    return List.generate(maps.length, (index) {
      return Lesson(
        id: maps[index]['id'],
        day: maps[index]['day'],
        time: maps[index]['time'],
        course: maps[index]['course'],
        room: maps[index]['room'],
        sks: maps[index]['sks'],
      );
    });
  }

  // void _addLessonToDatabase(Lesson lesson, BuildContext context) async {
  //   await DatabaseHelperSche.insertLesson(lesson);
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text('Lesson deleted successfully'),
  //       duration: Duration(seconds: 2),
  //     ),
  //   );
  // }
  Future<void> _addLessonToDatabase(Lesson lesson) async {
    await DatabaseHelperSche.insertLesson(lesson);
    // int id = await DatabaseHelperSche.insertLesson(lesson);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Lesson added successfully'),
        duration: Duration(seconds: 2),
      ),
    );

    // Reset input fields and controllers
    setState(() {
      selectedDay = 'Monday';
      selectedTime = TimeOfDay.now();
      courseController.clear();
      roomController.clear();
      sksController.clear();
    });
  }

  void _deleteLesson(int index, BuildContext context) async {
    List<Lesson> lessonList = await _getLessonListFromDatabase();
    Lesson lessonToDelete = lessonList[index];

    final db = await DatabaseHelperSche.database;
    await db.delete(
      'lessons',
      where: 'id = ?',
      whereArgs: [lessonToDelete.id],
    );

    setState(() {
      lessonList.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Lesson deleted successfully'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Widget _buildDayButton(String day) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedDay = day;
        });
      },
      style: ElevatedButton.styleFrom(
        primary: selectedDay == day ? Colors.blue : null,
      ),
      child: Text(day),
    );
  }
}
