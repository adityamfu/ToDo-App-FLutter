import 'package:flutter/material.dart';
import '../models/course2.dart';

class ScheduleView extends StatelessWidget {
  final List<Course> courses;
  final List<String> daysOfWeek;

  ScheduleView({required this.courses, required this.daysOfWeek});

  List<String> getDistinctSelectedDays() {
    final Set<String> selectedDaysSet = {};
    for (var course in courses) {
      selectedDaysSet.addAll(course.selectedDays);
    }
    return selectedDaysSet.toList()
      ..sort((a, b) => daysOfWeek.indexOf(a) - daysOfWeek.indexOf(b));
  }

  List<Course> getCoursesForDay(DateTime currentDate, String day) {
    return courses.where((course) {
      return course.selectedDays.contains(day) &&
          currentDate.isAfter(course.startDate.subtract(Duration(days: 1))) &&
          currentDate.isBefore(course.endDate.add(Duration(days: 1)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final DateTime currentDate = DateTime.now();
    final List<String> distinctSelectedDays = getDistinctSelectedDays();

    return Scaffold(
      appBar: AppBar(title: Text('Schedule View')),
      body: ListView(
        children: [
          for (var day in distinctSelectedDays)
            Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.blue,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Courses on $day',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Column(
                    children: getCoursesForDay(currentDate, day)
                        .map((course) => ListTile(
                              title: Text(course.name),
                              subtitle:
                                  Text('${course.room} | ${course.lecture}'),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
