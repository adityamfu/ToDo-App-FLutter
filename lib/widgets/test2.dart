import 'dart:async';
import 'package:flutter/material.dart';

import '../models/course2.dart';

class CourseInputScreen extends StatefulWidget {
  @override
  _CourseInputScreenState createState() => _CourseInputScreenState();
}

class _CourseInputScreenState extends State<CourseInputScreen> {
  final List<Course> courses = [];
  final List<Semester> semesters = [
    Semester(1),
    Semester(2),
    Semester(3),
    // Add more semesters as needed
  ];

  final StreamController<String> _dayStreamController =
      StreamController<String>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController creditsController = TextEditingController();
  final TextEditingController roomController = TextEditingController();
  final TextEditingController lectureController = TextEditingController();

  Semester selectedSemester = Semester(1);
  List<String> selectedDays = [];
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  @override
  void dispose() {
    _dayStreamController.close();
    super.dispose();
  }

  void _addCourse() {
    final String courseName = nameController.text;
    final int courseCredits = int.tryParse(creditsController.text) ?? 0;
    final String courseRoom = roomController.text;
    final String courseLecture = lectureController.text;

    if (courseName.isNotEmpty &&
        courseCredits > 0 &&
        selectedDays.isNotEmpty &&
        courseRoom.isNotEmpty &&
        courseLecture.isNotEmpty &&
        selectedStartDate != null &&
        selectedEndDate != null &&
        selectedStartDate!.isBefore(selectedEndDate!)) {

      final Course newCourse = Course(
        name: courseName,
        credits: courseCredits,
        semester: selectedSemester.number,
        selectedDays: List.from(selectedDays), // Simpan pilihan hari yang dipilih
        room: courseRoom,
        lecture: courseLecture,
        startDate: selectedStartDate!,
        endDate: selectedEndDate!,
      );
      setState(() {
        courses.add(newCourse);
        nameController.clear();
        creditsController.clear();
        selectedDays.clear();
        roomController.clear();
        lectureController.clear();
        selectedStartDate = null;
        selectedEndDate = null;
      });
    }
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );

    if (picked != null && picked.start != null && picked.end != null) {
      setState(() {
        selectedStartDate = picked.start!;
        selectedEndDate = picked.end!;

        // Kirim hari aktual berdasarkan tanggal yang dipilih ke dalam Stream
        _dayStreamController.add(picked.start!.weekday
            .toString()); // Mengirim kode hari dari 1 (Senin) hingga 7 (Minggu)
      });
    }
  }

  @override
  void initState() {
    super.initState();

    // Mendengarkan Stream untuk mengupdate selectedDays berdasarkan hari aktual
    _dayStreamController.stream.listen((dayCode) {
      setState(() {
        selectedDays.clear();
        selectedDays.add(dayCode);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Course Planner')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<Semester>(
              value: selectedSemester,
              onChanged: (Semester? newValue) {
                setState(() {
                  selectedSemester = newValue!;
                });
              },
              items: semesters.map<DropdownMenuItem<Semester>>(
                (Semester semester) {
                  return DropdownMenuItem<Semester>(
                    value: semester,
                    child: Text('Semester ${semester.number}'),
                  );
                },
              ).toList(),
            ),
            TextButton(
              onPressed: () => _selectDateRange(context),
              child: Text('Select Semester Dates'),
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Course Name'),
            ),
            TextField(
              controller: creditsController,
              decoration: InputDecoration(labelText: 'Credits'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: roomController,
              decoration: InputDecoration(labelText: 'Room'),
            ),
            TextField(
              controller: lectureController,
              decoration: InputDecoration(labelText: 'Lecture'),
            ),
            StreamBuilder<String>(
              stream: _dayStreamController.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final selectedDay = snapshot.data!;
                  return Text(
                      'Selected Day: $selectedDay'); // Menampilkan hari aktual yang dipilih
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
            ElevatedButton(
              onPressed: _addCourse,
              child: Text('Add Course'),
            ),
            // ... (kode lainnya)
          ],
        ),
      ),
    );
  }
}