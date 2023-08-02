import 'package:flutter/material.dart';
import '../services/enum.dart';


class AddTaskBottomSheet extends StatefulWidget {
  final Function(String taskName, TaskPriority priority) addTaskCallback;

  AddTaskBottomSheet(this.addTaskCallback);

  @override
  _AddTaskBottomSheetState createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  String taskName = '';
  TaskPriority priority = TaskPriority.Low; // Default priority

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
          ElevatedButton(
            onPressed: () {
              if (taskName.isNotEmpty) {
                widget.addTaskCallback(taskName, priority);
              }
            },
            child: Text('Tambah'),
          ),
        ],
      ),
    );
  }
}
