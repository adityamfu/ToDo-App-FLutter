import 'package:flutter/material.dart';

import '../services/schedule.dart';
import '../util/add_schedule.dart';
import '../widgets/daily_schedule.dart';

class DailyTaskScreen extends StatefulWidget {
  @override
  _DailyTaskScreenState createState() => _DailyTaskScreenState();
}

class _DailyTaskScreenState extends State<DailyTaskScreen> {
  Map<String, List<DayScheduleItem>> schedules = {
    'Senin': [],
    'Selasa': [],
    'Rabu': [],
    'Kamis': [],
    'Jumat': [],
    'Sabtu': [],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            'Jadwal Pelajaran',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: [
                DaySchedule(
                    day: 'Senin', daySchedules: schedules['Senin'] ?? []),
                DaySchedule(
                    day: 'Selasa', daySchedules: schedules['Selasa'] ?? []),
                DaySchedule(day: 'Rabu', daySchedules: schedules['Rabu'] ?? []),
                DaySchedule(
                    day: 'Kamis', daySchedules: schedules['Kamis'] ?? []),
                DaySchedule(
                    day: 'Jumat', daySchedules: schedules['Jumat'] ?? []),
                DaySchedule(
                    day: 'Sabtu', daySchedules: schedules['Sabtu'] ?? []),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AddDialog(
          schedules: schedules,
          onAddSchedule: (selectedDay, selectedTime, subject, lecturer, room) {
            DayScheduleItem schedule = DayScheduleItem(
              time: selectedTime,
              subject: subject,
              lecturer: lecturer, // Tambahkan nama dosen
              room: room, // Tambahkan ruang kelas
            );
            setState(() {
              schedules[selectedDay]?.add(schedule);
            });
          },
        );
      },
    );
  }
}
