import 'package:flutter/material.dart';

import '../services/schedule.dart';

class AddDialog extends StatefulWidget {
  final Map<String, List<DayScheduleItem>> schedules;
  final Function(String, String, String, String, String) onAddSchedule;

  AddDialog({
    required this.schedules,
    required this.onAddSchedule,
  });

  @override
  _AddDialogState createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  String selectedDay = 'Senin';
  String selectedTime = '07.00';
  String subject = '';
  String lecturer = '';
  String room = '';

  @override
  Widget build(BuildContext context) {
    List<String> usedTimes = widget.schedules[selectedDay] != null
        ? widget.schedules[selectedDay]!.map((schedule) => schedule.time).toList()
        : [];

    return AlertDialog(
      title: Text('Tambah Jadwal'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField(
            value: selectedDay,
            items: widget.schedules.keys
                .map((day) => DropdownMenuItem(
                      value: day,
                      child: Text(day),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedDay = value as String;
                usedTimes = widget.schedules[selectedDay] != null
                    ? widget.schedules[selectedDay]!
                        .map((schedule) => schedule.time)
                        .toList()
                    : [];
              });
            },
          ),
          DropdownButtonFormField(
            value: selectedTime,
            items: [
              '07.00',
              '09.00',
              '11.00',
              '13.00',
              '15.00',
              '17.00',
              '19.00'
            ].map((time) => DropdownMenuItem(
                  value: time,
                  child: Text(time),
                )).toList(),
            onChanged: (value) {
              setState(() {
                selectedTime = value as String;
              });
            },
          ),
          if (usedTimes.contains(selectedTime))
            Text(
              'Waktu sudah digunakan pada hari itu!',
              style: TextStyle(color: Colors.red),
            ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Mata Pelajaran'),
            onChanged: (value) {
              setState(() {
                subject = value;
              });
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Nama Dosen'),
            onChanged: (value) {
              setState(() {
                lecturer = value;
              });
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Ruang Kelas'),
            onChanged: (value) {
              setState(() {
                room = value;
              });
            },
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Batal'),
        ),
        ElevatedButton(
          onPressed: () {
            if (usedTimes.contains(selectedTime)) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Waktu sudah digunakan pada hari itu!'),
                ),
              );
            } else {
              widget.onAddSchedule(selectedDay, selectedTime, subject, lecturer, room);
              Navigator.pop(context);
            }
          },
          child: Text('Tambah'),
        ),
      ],
    );
  }
}
