import 'package:flutter/material.dart';
import '../models/todo_enum.dart';

class AddTaskBottomSheet extends StatefulWidget {
 final Function(String taskName, TaskPriority priority) addTaskCallback;

  const AddTaskBottomSheet({
    Key? key,
    required this.addTaskCallback,
  }) : super(key: key);

  @override
  _AddTaskBottomSheetState createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  String taskName = '';
  TaskPriority priority = TaskPriority.Low;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            onChanged: (value) {
              setState(() {
                taskName = value;
              });
            },
            decoration:const InputDecoration(labelText: 'Tambah tugas'),
          ),
         const SizedBox(height: 16.0),
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
         const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              if (taskName.isNotEmpty) {
                widget.addTaskCallback(taskName, priority);
              }
            },
            child:const Text('Tambah'),
          ),
        ],
      ),
    );
  }
}
