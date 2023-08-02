// import '../services/enum.dart';

// class TodoTask {
//   final String name;
//   final TaskPriority priority;
//   final String category;
//   bool isDone;
//   DateTime createdAt;
//   DateTime completedAt;
//   final DateTime startTime;
//   final DateTime endTime;
//   bool isReminderOn;
//   DateTime? reminderTime;

//   TodoTask({
//     required this.name,
//     required this.priority,
//     required this.category,
//     this.isDone = false,
//     required this.createdAt,
//     required this.completedAt,
//     required this.startTime,
//     required this.endTime,
//     this.isReminderOn = false,
//     this.reminderTime,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'priority': priority.toString(),
//       'category': category,
//       'isDone': isDone ? 1 : 0,
//       'createdAt': createdAt.toIso8601String(),
//       'completedAt': completedAt.toIso8601String(),
//       'startTime': startTime.toIso8601String(),
//       'endTime': endTime.toIso8601String(),
//       'isReminderOn': isReminderOn ? 1 : 0,
//       'reminderTime': reminderTime?.toIso8601String(),
//     };
//   }

//   factory TodoTask.fromMap(Map<String, dynamic> map) {
//     return TodoTask(
//       name: map['name'],
//       priority: TaskPriority.values
//           .firstWhere((priority) => priority.toString() == map['priority']),
//       category: map['category'],
//       isDone: map['isDone'] == 1,
//       createdAt: DateTime.parse(map['createdAt']),
//       completedAt: DateTime.parse(map['completedAt']),
//       startTime: DateTime.parse(map['startTime']),
//       endTime: DateTime.parse(map['endTime']),
//       isReminderOn: map['isReminderOn'] == 1,
//       reminderTime: map['reminderTime'] != null
//           ? DateTime.parse(map['reminderTime'])
//           : null,
//     );
//   }

//   static TaskPriority _parsePriority(String priority) {
//     if (priority == 'TaskPriority.High') {
//       return TaskPriority.High;
//     } else if (priority == 'TaskPriority.Medium') {
//       return TaskPriority.Medium;
//     } else {
//       return TaskPriority.Low;
//     }
//   }
// }
