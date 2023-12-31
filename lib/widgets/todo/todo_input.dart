import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/todo_enum.dart';

class AddTaskBottomSheet extends StatefulWidget {
  
  final Function(
    String taskName,
    TaskPriority priority,
    DateTime createdAt,
    DateTime startTime,
    DateTime endTime,
    String taskDescription,
  ) addTaskCallback;

 const AddTaskBottomSheet({Key?key, required this.addTaskCallback}) : super(key: key);

  @override
  _AddTaskBottomSheetState createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  String taskName = '';
  String taskDescription = '';
  TaskPriority priority = TaskPriority.Low; // Default priority
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now().add(const Duration(hours: 1));

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
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('Create Your Task',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(
                width: 70,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    if (taskName.isNotEmpty) {
                      widget.addTaskCallback(taskName, priority, DateTime.now(),
                          startTime, endTime, taskDescription);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Add',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 43, 43, 43).withOpacity(0.3),
                  offset: const Offset(0, 5),
                  spreadRadius: 2,
                  blurRadius: 11,
                ),
              ],
            ),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  taskName = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Task Name...',
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 77, 75, 75).withOpacity(0.3),
                  offset: const Offset(0, 5),
                  spreadRadius: 2,
                  blurRadius: 11,
                ),
              ],
            ),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  taskDescription = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Description...',
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 56, 54, 54).withOpacity(0.3),
                  offset: const Offset(0, 5),
                  spreadRadius: 2,
                  blurRadius: 11,
                ),
              ],
            ),
            child: DropdownButtonFormField<TaskPriority>(
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
          ),
          const SizedBox(height: 16.0),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 49, 48, 48).withOpacity(0.3),
                  offset: const Offset(0, 5),
                  spreadRadius: 2,
                  blurRadius: 11,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    DateFormat('EEEE, dd MMMM yyyy \nHH:mm').format(startTime)),
                SizedBox(
                  width: 70,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: _selectStartTime,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Start',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 59, 56, 56).withOpacity(0.3),
                  offset: const Offset(0, 5),
                  spreadRadius: 2,
                  blurRadius: 11,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(DateFormat('EEEE, dd MMMM yyyy \nHH:mm').format(endTime)),
                SizedBox(
                  width: 70,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: _selectEndTime,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('End',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
