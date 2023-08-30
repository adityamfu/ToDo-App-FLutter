import 'package:flutter/material.dart';
import '../models/course.dart';

class EditCourseDialog extends StatefulWidget {
  final Course course;

  EditCourseDialog({required this.course});

  @override
  _EditCourseDialogState createState() => _EditCourseDialogState();
}

class _EditCourseDialogState extends State<EditCourseDialog> {
  // Declare TextEditingController for each field
  TextEditingController courseNameController = TextEditingController();
  TextEditingController sksController = TextEditingController();
  TextEditingController roomController = TextEditingController();
  TextEditingController lecturerController = TextEditingController();
  // Weekday selectedWeekday = Weekday.Monday;
  List<Course> courses = [];
  int selectedSemester = 1;
  int selectedWeekday = 1;
  // List<Weekday> selectedWeekdays = [];

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing course data
    courseNameController.text = widget.course.courseName;
    sksController.text = widget.course.sks;
    roomController.text = widget.course.room;
    lecturerController.text = widget.course.lecturer;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: courseNameController,
          decoration: InputDecoration(labelText: 'Mata Kuliah'),
        ),
        TextField(
          controller: sksController,
          decoration: InputDecoration(labelText: 'SKS'),
          keyboardType: TextInputType.number,
        ),
        TextField(
          controller: roomController,
          decoration: InputDecoration(labelText: 'Ruangan'),
        ),
        TextField(
          controller: lecturerController,
          decoration: InputDecoration(labelText: 'Dosen'),
        ),
        ElevatedButton(
          onPressed: () {
            // Handle save changes
            Course editedCourse = Course(
              id: widget.course.id,
              courseName: courseNameController.text,
              sks: sksController.text,
              room: roomController.text,
              lecturer: lecturerController.text,
              weekday: selectedWeekday,
              semester: selectedSemester,
              // weekdays: selectedWeekdays,
            );

            // Update UI and close dialog
            setState(() {
              int editedIndex =
                  courses.indexWhere((course) => course.id == editedCourse.id);
              if (editedIndex != -1) {
                courses[editedIndex] = editedCourse;
              }
            });
            Navigator.of(context).pop();
          },
          child: Text('Simpan Perubahan'),
        ),
      ],
    );
  }
}
