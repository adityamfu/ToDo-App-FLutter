import 'package:flutter/material.dart';
import '../services/schedule.dart';

class DaySchedule extends StatelessWidget {
  final String day;
  final List<DayScheduleItem> daySchedules;

  DaySchedule({
    required this.day,
    required this.daySchedules,
  });

  @override
  Widget build(BuildContext context) {
    daySchedules
        .sort((a, b) => a.time.compareTo(b.time)); // Urutkan berdasarkan waktu

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              day,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            for (var schedule in daySchedules)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Waktu: ${schedule.time}'),
                  Text('Mata Pelajaran: ${schedule.subject}'),
                  Text('Nama Dosen: ${schedule.lecturer}'),
                  Text('Ruang Kelas: ${schedule.room}'),
                  SizedBox(height: 8),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
