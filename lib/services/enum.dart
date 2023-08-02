
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
  final String category;
  bool isDone;
  DateTime createdAt;
  DateTime completedAt;
  final DateTime startTime;
  final DateTime endTime;  bool isReminderOn;
  DateTime? reminderTime;

  TodoTask({
    required this.name,
    required this.priority,
    required this.category,
    this.isDone = false,
    required this.createdAt,
    required this.completedAt,
    required this.startTime,
    required this.endTime,
    this.isReminderOn = false,
    this.reminderTime,
  });
}