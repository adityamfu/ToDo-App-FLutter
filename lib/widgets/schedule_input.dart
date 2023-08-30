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
  int selectedWeekday = DateTime.monday;
  // int selectedWeekday = 1;
  // String weekdayToString(int weekday) {
  //   switch (weekday) {
  //     case 0:
  //       return 'Minggu';
  //     case 1:
  //       return 'Senin';
  //     case 2:
  //       return 'Selasa';
  //     case 3:
  //       return 'Rabu';
  //     case 4:
  //       return 'Kamis';
  //     case 5:
  //       return 'Jumat';
  //     case 6:
  //       return 'Sabtu';
  //     default:
  //       return 'Hari tidak valid';
  //   }
  // }
  String weekdayToString(int? weekday) {
    if (weekday != null) {
      switch (weekday) {
        case 0:
          return 'Minggu';
        case 1:
          return 'Senin';
        case 2:
          return 'Selasa';
        case 3:
          return 'Rabu';
        case 4:
          return 'Kamis';
        case 5:
          return 'Jumat';
        case 6:
          return 'Sabtu';
        default:
          return 'Hari tidak valid';
      }
    }
    return 'Hari tidak tersedia';
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Jadwal Kuliah'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
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
                  });
                },
                items: [1, 2, 3, 4] // Use integer values for semesters
                    .map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text('Semester $selectedSemester'),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Start : ${DateFormat('dd MMM yyyy').format(startDate.toLocal())}'),
                        ElevatedButton(
                          onPressed: () {
                            _selectStartDate(context);
                          },
                          child: Text('Set'),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                            'End : ${DateFormat('dd MMM yyyy').format(endDate.toLocal())}'),
                        ElevatedButton(
                          onPressed: () {
                            _selectEndDate(context);
                          },
                          child: Text('Set'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200], // Warna latar belakang
                        borderRadius:
                            BorderRadius.circular(10.0), // Border radius
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), // Warna shadow
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3), // Offset shadow
                          ),
                        ],
                      ),
                      child: TextField(
                        onChanged: (value) {
                          courseName = value;
                        },
                        decoration: InputDecoration(
                          border:
                              InputBorder.none, // Menghilangkan border bawaan
                          hintText: 'Mata Kuliah',
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12.0), // Padding
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10), // Jarak antara dua TextField
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200], // Warna latar belakang
                        borderRadius:
                            BorderRadius.circular(10.0), // Border radius
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), // Warna shadow
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3), // Offset shadow
                          ),
                        ],
                      ),
                      child: TextField(
                        onChanged: (value) {
                          sks = value;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border:
                              InputBorder.none, // Menghilangkan border bawaan
                          hintText: 'SKS',
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12.0), // Padding
                        ),
                      ),
                    ),
                  ),
                ],
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
              buildWeekdayDropdown(selectedWeekday, (int? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedWeekday = newValue;
                  });
                }
              }),
              // DropdownButtonFormField<int>(
              //   value: selectedWeekday,
              //   onChanged: (int? newValue) {
              //     if (newValue != null) {
              //       setState(() {
              //         selectedWeekday = newValue;
              //       });
              //     }
              //   },
              //   items: List.generate(7, (index) {
              //     final weekday = (index + 1) % 7;
              //     return DropdownMenuItem<int>(
              //       value: weekday,
              //       child: Text(weekdayToString(weekday)),
              //     );
              //   }),
              // ),
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

                    int weekNumber = (index / 7).floor() + 1;

                    return ListTile(
                      title: Text(course.courseName),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('SKS: ${course.sks}'),
                          Text('Room: ${course.room}'),
                          Text('Lecturer: ${course.lecturer}'),
                          // Text('Hari: $selectedWeekday'),
                          Text('Hari: ${weekdayToString(course.weekday)}'),
                          Text('Semester: ${course.semester}'),
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

  DropdownButtonFormField<int> buildWeekdayDropdown(
      int selectedValue, ValueChanged<int> onChanged) {
    return DropdownButtonFormField<int>(
      value: selectedWeekday,
      onChanged: (int? newValue) {
        if (newValue != null) {
          setState(() {
            selectedWeekday = newValue;
          });
        }
      },
      items: List.generate(7, (index) {
        final weekday = (index + 1) % 7;
        return DropdownMenuItem<int>(
          value: weekday,
          child: Text(weekdayToString(weekday)),
        );
      }),
    );
  }

  void _saveCourse() async {
    Course newCourse = Course(
      courseName: courseName,
      sks: sks,
      room: room,
      lecturer: lecturer,
      weekday: selectedWeekday,
      semester: selectedSemester,
    );

    Map<String, dynamic> courseMap = {
      'courseName': newCourse.courseName,
      'sks': newCourse.sks,
      'room': newCourse.room,
      'lecturer': newCourse.lecturer,
      'weekday': newCourse.weekday,
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
        weekday: selectedWeekday,
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
