class Lesson {
  int? id;
  final String day;
  final String time;
  final String course;
  String room;
  final int sks;

  Lesson({
    this.id,
    required this.day,
    required this.time,
    required this.course,
    required this.room,
    required this.sks,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'day': day,
      'time': time,
      'course': course,
      'room': room,
      'sks': sks,
    };
  }

  factory Lesson.fromMap(Map<String, dynamic> map) {
    return Lesson(
      id: map['id'],
      day: map['day'],
      time: map['time'],
      course: map['course'],
      room: map['room'],
      sks: map['sks'],
    );
  }
}
