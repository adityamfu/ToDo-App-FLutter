enum TaskPriority {
  Low,
  Medium,
  High,
}

enum TaskDay {
  Senin,
  Selasa,
  Rabu,
  Kamis,
  Jumat,
  Sabtu,
  Minggu,
}

class TodoTask {
  final String name;
  final TaskPriority priority;
  final String description;
  final String category;
  bool isDone;
  DateTime createdAt;
  DateTime completedAt;
  final DateTime startTime;
  final DateTime endTime;
  bool isReminderOn;
  DateTime? reminderTime;

  TodoTask({
    required this.name,
    required this.priority,
    required this.description,
    required this.category,
    this.isDone = false,
    required this.createdAt,
    required this.completedAt,
    required this.startTime,
    required this.endTime,
    this.isReminderOn = false,
    this.reminderTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'priority': priority.toString(),
      'category': category,
      'isDone': isDone ? 1 : 0,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'completedAt': completedAt.millisecondsSinceEpoch,
      'startTime': startTime.millisecondsSinceEpoch,
      'endTime': endTime.millisecondsSinceEpoch,
      'description': description,
    };
  }

  factory TodoTask.fromMap(Map<String, dynamic> map) {
    return TodoTask(
      name: map['name'],
      priority: TaskPriority.values
          .firstWhere((priority) => priority.toString() == map['priority']),
      category: map['category'],
      isDone: map['isDone'] == 1,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      completedAt: DateTime.fromMillisecondsSinceEpoch(map['completedAt']),
      startTime: DateTime.fromMillisecondsSinceEpoch(map['startTime']),
      endTime: DateTime.fromMillisecondsSinceEpoch(map['endTime']),
      description: map['description'],
    );
  }
}
