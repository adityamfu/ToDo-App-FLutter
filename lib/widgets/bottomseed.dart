import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/enum.dart';

class AddTaskBottomSheet extends StatefulWidget {
  final Function(String taskName, TaskPriority priority, DateTime createdAt,
      DateTime startTime, DateTime endTime) addTaskCallback;

  AddTaskBottomSheet(this.addTaskCallback);

  @override
  _AddTaskBottomSheetState createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  String taskName = '';
  TaskPriority priority = TaskPriority.Low; // Default priority
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now()
      .add(Duration(hours: 1)); // Set default end time 1 hour from now

  Future<void> _selectStartTime() async {
    final DateTime? selectedStartTime = await showDatePicker(
      context: context,
      initialDate: startTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedStartTime != null) {
      final TimeOfDay? selectedStartTimeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(startTime),
      );

      if (selectedStartTimeOfDay != null) {
        setState(() {
          startTime = DateTime(
            selectedStartTime.year,
            selectedStartTime.month,
            selectedStartTime.day,
            selectedStartTimeOfDay.hour,
            selectedStartTimeOfDay.minute,
            // selectedStartTimeOfDay.second,
          );
        });
      }
    }
  }

  Future<void> _selectEndTime() async {
    final DateTime? selectedEndTime = await showDatePicker(
      context: context,
      initialDate: endTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedEndTime != null) {
      final TimeOfDay? selectedEndTimeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(endTime),
      );

      if (selectedEndTimeOfDay != null) {
        setState(() {
          endTime = DateTime(
            selectedEndTime.year,
            selectedEndTime.month,
            selectedEndTime.day,
            selectedEndTimeOfDay.hour,
            selectedEndTimeOfDay.minute,
            // selectedEndTimeOfDay.second,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            onChanged: (value) {
              setState(() {
                taskName = value;
              });
            },
            decoration: InputDecoration(labelText: 'Tambah tugas'),
          ),
          SizedBox(height: 16.0),
          DropdownButtonFormField<TaskPriority>(
            value: priority,
            onChanged: (TaskPriority? value) {
              setState(() {
                priority = value!;
              });
            },
            items: TaskPriority.values.map((priority) {
              return DropdownMenuItem<TaskPriority>(
                value: priority,
                child: Text(priority.toString()),
              );
            }).toList(),
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  'Waktu Mulai: ${DateFormat('EEEE, dd MMMM yyyy HH:mm:ss').format(startTime)}'),
              ElevatedButton(
                onPressed: _selectStartTime,
                child: Text('Pilih Waktu Mulai'),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  'Waktu Selesai: ${DateFormat('EEEE, dd MMMM yyyy HH:mm:ss').format(endTime)}'),
              ElevatedButton(
                onPressed: _selectEndTime,
                child: Text('Pilih Waktu Selesai'),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              if (taskName.isNotEmpty) {
                widget.addTaskCallback(
                    taskName, priority, DateTime.now(), startTime, endTime);
              }
            },
            child: Text('Tambah'),
          ),
        ],
      ),
    );
  }
}

