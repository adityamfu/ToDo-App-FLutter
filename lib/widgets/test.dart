import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/course.dart';
import '../models/schedule.dart';
import 'edit.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // String selectedSemester = "Semester 1";
  int selectedSemester = 1;

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(Duration(days: 90));
  Weekday selectedWeekdays = Weekday.Monday;
  String courseName = '';
  String sks = '';
  String room = '';
  String lecturer = '';

  List<Course> courses = [];

  @override
  void initState() {
    super.initState();
    _loadSavedCourses();
  }

  // Future<void> _loadSavedCourses() async {
  //   List<Course> courses =
  //       await DatabaseHelper.instance.getAllCoursesBySemester(selectedSemester);

  //   setState(() {
  //     this.courses = courses;
  //   });
  //   courses.sort((a, b) => a.semester.compareTo(b.semester));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Jadwal Kuliah'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
// Kembali ke halaman utama
            Navigator.popUntil(context, (route) => route.isFirst);
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton<int>(
                value: selectedSemester,
                onChanged: (int? newValue) {
                  setState(() {
                    selectedSemester = newValue!;
                    _loadSavedCourses(); // Load courses based on the selected semester
                  });
                },
                items: [1, 2, 3, 4] // Use integer values for semesters
                    .map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text('Semester $value'),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Text('Tanggal Awal: ${startDate.toLocal()}'),
              ElevatedButton(
                onPressed: () {
                  _selectStartDate(context);
                },
                child: Text('Pilih Tanggal Awal'),
              ),
              SizedBox(height: 20),
              Text('Tanggal Akhir: ${endDate.toLocal()}'),
              ElevatedButton(
                onPressed: () {
                  _selectEndDate(context);
                },
                child: Text('Pilih Tanggal Akhir'),
              ),
              SizedBox(height: 20),
              TextField(
                onChanged: (value) {
                  courseName = value;
                },
                decoration: InputDecoration(
                  labelText: 'Mata Kuliah',
                ),
              ),
              TextField(
                onChanged: (value) {
                  sks = value;
                },
                decoration: InputDecoration(
                  labelText: 'SKS',
                ),
                keyboardType: TextInputType.number,
              ),
              TextField(
                onChanged: (value) {
                  room = value;
                },
                decoration: InputDecoration(
                  labelText: 'Ruangan',
                ),
              ),
              TextField(
                onChanged: (value) {
                  lecturer = value;
                },
                decoration: InputDecoration(
                  labelText: 'Dosen',
                ),
              ),
              DropdownButtonFormField<Weekday>(
                value: selectedWeekdays,
                onChanged: (Weekday? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedWeekdays = newValue;
                    });
                  }
                },
                items: Weekday.values.map((Weekday value) {
                  return DropdownMenuItem<Weekday>(
                    value: value,
                    child: Text(value.toString().split('.').last),
                  );
                }).toList(),
              ),
              ElevatedButton(
                onPressed: () {
                  _saveCourse();
                },
                child: Text('Simpan'),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    Course course = courses[index];
                    int daysDiff = endDate.difference(startDate).inDays;

                    int totalWeeks = (daysDiff / 7).ceil();
                    int weekNumber = (index / 7).floor() + 1;

                    DateTime courseDate = startDate.add(
                        Duration(days: (weekNumber - 1) * 7 + (index % 7)));

                    String dayName = DateFormat('EEEE').format(courseDate);

                    return ListTile(
                      title: Text(course.courseName),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('SKS: ${course.sks}'),
                          Text('Room: ${course.room}'),
                          Text('Lecturer: ${course.lecturer}'),
                          Text(
                              'Weekday: ${course.weekday.toString().split('.').last}'),
                          // Text('Semester: ${course.semester}'),
                          Text('Minggu ke-$weekNumber'),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              _showEditDialog(course);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _deleteCourse(course);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectStartDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (pickedDate != null) {
      setState(() {
        startDate = pickedDate;
      });
    }
  }

  void _selectEndDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: endDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (pickedDate != null) {
      setState(() {
        endDate = pickedDate;
      });
    }
  }

  void _saveCourse() async {
    Course newCourse = Course(
      courseName: courseName,
      sks: sks,
      room: room,
      lecturer: lecturer,
      weekday: selectedWeekdays,
      semester: selectedSemester,
    );

    Map<String, dynamic> courseMap = {
      'courseName': newCourse.courseName,
      'sks': newCourse.sks,
      'room': newCourse.room,
      'lecturer': newCourse.lecturer,
      'weekday': newCourse.weekday.toString(),
      // 'semester': selectedSemester,
      'semester': newCourse.semester,
    };

    int insertedId = await DatabaseHelper.instance.insertCourse(courseMap);
    newCourse.id = insertedId;

    setState(() {
      courses.add(newCourse);
      courseName = '';
      sks = '';
      room = '';
      lecturer = '';
    });
    _formKey.currentState!.reset();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Data berhasil ditambahkan'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  // void _loadSavedCourses() async {
  //   List<Course> loadedCourses =
  //       await DatabaseHelper.instance.getAllCoursesBySemester(selectedSemester);
  //   setState(() {
  //     courses = loadedCourses;
  //   });
  // }

  Future<void> _loadSavedCourses() async {
    List<Map<String, dynamic>> courseMaps =
        await DatabaseHelper.instance.getAllCourses();

    List<Course> loadedCourses = courseMaps.map((courseMap) {
      return Course(
        id: courseMap['id'],
        courseName: courseMap['courseName'],
        sks: courseMap['sks'],
        room: courseMap['room'],
        lecturer: courseMap['lecturer'],
        semester: selectedSemester,
        weekday: Weekday.values.firstWhere(
          (weekday) => weekday.toString() == courseMap['weekday'],
          orElse: () => Weekday.Monday,
        ),
      );
    }).toList();

    setState(() {
      courses = loadedCourses;
    });
  }

  // void _showEditDialog(Course course) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Edit Course'),
  //         content: EditCourseDialog(course: course),
  //       );
  //     },
  //   );
  // }
  void _showEditDialog(Course course) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Edit Course'),
        content: EditCourseDialog(course: course),
      );
    },
  );
}

void _editCourse(Course course) async {
  Course editedCourse = await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Edit Course'),
        content: EditCourseDialog(course: course),
      );
    },
  );

  if (editedCourse != null) {
    // Memanggil method updateCourse pada DatabaseHelper
    await DatabaseHelper.instance.updateCourse(editedCourse);

    // Update daftar courses di dalam state dengan data yang sudah diperbarui
    setState(() {
      // Mencari index kursus yang akan diperbarui di dalam courses
      int index = courses.indexWhere((c) => c.id == editedCourse.id);

      if (index != -1) {
        courses[index] = editedCourse;
      }
    });
  }
}


  void _deleteCourse(Course course) async {
    await DatabaseHelper.instance.deleteCourse(course.id!);
    setState(() {
      courses.remove(course);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Data berhasil dihapus'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
