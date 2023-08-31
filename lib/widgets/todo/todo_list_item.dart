import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/todo_enum.dart';

class TodoTaskListItem extends StatelessWidget {
  final TodoTask todoTask;
  final bool isCompleted;
  final VoidCallback markAsDone;
  final VoidCallback deleteTask;
  final VoidCallback onTap;

 const TodoTaskListItem({Key?key,
    required this.todoTask,
    required this.isCompleted,
    required this.markAsDone,
    required this.deleteTask,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isCompleted ? null : onTap,
      child: Container(
        height: 130,
        width: double.infinity,
        decoration: BoxDecoration(
          color: isCompleted
              ? Theme.of(context).colorScheme.secondary
              : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(0, 104, 100, 100).withOpacity(1),
              offset: const Offset(1, 5),
              blurRadius: 12,
              spreadRadius: 0.6,
            )
          ],
        ),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        padding: const EdgeInsets.all(14.0),
        child: Row(
          children: [
            Container(
              height: isCompleted ? 80 : 20,
              width: 10,
              margin:const EdgeInsets.only(right: 14.0),
              decoration: BoxDecoration(
                color: isCompleted
                    ? Theme.of(context).colorScheme.background
                    : Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 250,
                        child: Text(
                          todoTask.name,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            decoration: isCompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                      ),
                      Container(
                        height: 17,
                        width: 33,
                        decoration: BoxDecoration(
                          color: _getPriorityColor(todoTask.priority),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(0),
                            bottomLeft: Radius.circular(20),
                            topRight: Radius.circular(7),
                            bottomRight: Radius.circular(7),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Category : ${(todoTask.category)}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  if (isCompleted && todoTask.completedAt != true)
                    Column(
                      children: [
                        Text(
                          'Done at: ${DateFormat('EEEE, dd MMMM yyyy HH:mm').format(todoTask.completedAt)}',
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 0),
                      ],
                    ),
                  SizedBox(height: isCompleted ? 10 : 25),
                  if (todoTask.startTime != true)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat('EEEE, dd MMMM yyyy')
                              .format(todoTask.startTime),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          DateFormat('HH:mm').format(todoTask.startTime),
                        ),
                      ],
                    ),
                  if (todoTask.endTime != true)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat('EEEE, dd MMMM yyyy').format(todoTask.endTime),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          DateFormat('HH:mm').format(todoTask.endTime),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            // SizedBox(width: 16.0),
            // IconButton(
            //   icon: isCompleted
            //       ? Icon(Icons.check_circle, color: Colors.green)
            //       : Icon(Icons.timer_outlined),
            //   onPressed: null,
            // ),
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
      return Colors.yellow;
    } else {
      return Colors.blue;
    }
  }

  // String _getPriorityInitial(TaskPriority priority) {
  //   return priority.toString().substring(0, 1);
  // }
}
