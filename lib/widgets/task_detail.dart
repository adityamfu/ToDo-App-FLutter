import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/enum.dart';

class TaskDetailDialog extends StatelessWidget {
  final TodoTask todoTask;

  TaskDetailDialog({required this.todoTask});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(todoTask.name),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Priority: ${todoTask.priority}'),
          SizedBox(height: 12.0),
          Text('Category: ${todoTask.category}'),
          SizedBox(height: 8.0),
          Text(
              'Created At: ${DateFormat('EEEE, dd MMMM yyyy, HH:mm:ss').format(todoTask.createdAt)}'),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, 'Done');
          },
          child: Text('Done'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, 'Delete');
          },
          child: Text('Delete'),
        ),
      ],
    );
  }
}


// class TaskDetailModal extends StatelessWidget {
//   final TodoTask todoTask;

//   TaskDetailModal({required this.todoTask});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16.0),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             todoTask.name,
//             style: TextStyle(
//               fontSize: 20.0,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 8.0),
//           Text('Category: ${todoTask.category}'),
//           SizedBox(height: 8.0),
//           Text('Priority: ${todoTask.priority}'),
//           SizedBox(height: 8.0),
//           Text('Created At: ${DateFormat('EEEE, d MMMM yyyy, HH:mm').format(todoTask.createdAt)}'),
//           SizedBox(height: 8.0),
//           Text('Start Time: ${DateFormat('EEEE, d MMMM yyyy, HH:mm').format(todoTask.startTime)}'),
//           SizedBox(height: 8.0),
//           Text('End Time: ${DateFormat('EEEE, d MMMM yyyy, HH:mm').format(todoTask.endTime)}'),
//           SizedBox(height: 16.0),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   // Mark task as done
//                   Navigator.pop(context, 'Done');
//                 },
//                 child: Text('Done'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   // Delete task
//                   Navigator.pop(context, 'Delete');
//                 },
//                 child: Text('Delete'),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
