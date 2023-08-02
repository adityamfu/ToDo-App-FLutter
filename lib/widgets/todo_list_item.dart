import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/enum.dart';

class TodoTaskListItem extends StatelessWidget {
  final TodoTask todoTask;
  final bool isCompleted;
  final VoidCallback markAsDone;
  final VoidCallback deleteTask;
  final VoidCallback onTap;

  TodoTaskListItem({
    required this.todoTask,
    required this.isCompleted,
    required this.markAsDone,
    required this.deleteTask,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isCompleted ? null : onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isCompleted ? Colors.grey : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(0, 104, 100, 100).withOpacity(1),
              offset: Offset(1, 5),
              blurRadius: 12,
              spreadRadius: 0.6,
            )
          ],
        ),
        margin: EdgeInsets.all(12),
        padding: EdgeInsets.all(14.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: _getPriorityColor(todoTask.priority),
              child: Text(
                _getPriorityInitial(todoTask.priority),
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todoTask.name,
                    style: TextStyle(
                      decoration: isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  Text(todoTask.category),
                  if (todoTask.startTime != true)
                    Text(
                      'Start time: ${DateFormat('dd/MM/yyyy HH:mm').format(todoTask.startTime)}',
                    ),
                  if (todoTask.endTime != true)
                    Text(
                      'End time: ${DateFormat('dd/MM/yyyy HH:mm').format(todoTask.endTime)}',
                    ),
                  if (isCompleted && todoTask.completedAt != true)
                    Text(
                      'Completed at: ${DateFormat('dd/MM/yyyy HH:mm').format(todoTask.completedAt)}',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(width: 16.0),
            IconButton(
              icon: isCompleted
                  ? Icon(Icons.check_circle, color: Colors.green)
                  : Icon(Icons.timer_outlined),
              onPressed: null,
            ),
          ],
        ),
      ),
    );
    // Card(
    //   color: isCompleted ? Colors.grey : Colors.white,
    //   child: ListTile(
    //     onTap: isCompleted ? null : onTap,
    //     title: Text(
    //       todoTask.name,
    //       style: TextStyle(
    //         decoration:
    //             isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
    //       ),
    //     ),
    //     subtitle: Text(todoTask.category),
    //     leading: CircleAvatar(
    //       backgroundColor: _getPriorityColor(todoTask.priority),
    //       // child: Text(
    //       //   _getPriorityInitial(todoTask.priority),
    //       //   style: TextStyle(color: Colors.blue),
    //       // ),
    //     ),
    //     trailing: isCompleted
    //         ? Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               Text(
    //                   'Done at: ${DateFormat('dd/MM/yyyy HH:mm').format(todoTask.completedAt)}'),
    //               Icon(Icons.check_circle, color: Colors.green),
    //             ],
    //           )
    //         : Icon(Icons.timer_outlined),

    //   ),
    // );
  }

  // Helper methods for getting priority color and initial
  Color _getPriorityColor(TaskPriority priority) {
    if (priority == TaskPriority.High) {
      return Colors.red;
    } else if (priority == TaskPriority.Medium) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }

  String _getPriorityInitial(TaskPriority priority) {
    return priority.toString().substring(0, 1);
  }
}


