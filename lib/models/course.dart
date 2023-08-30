class Course {
  int? id;
  String courseName;
  String sks;
  String room;
  String lecturer;
  // Weekday weekday;
  int weekday;
  int semester;
  // List<Weekday> weekdays;

  Course({
    this.id,
    required this.courseName,
    required this.sks,
    required this.room,
    required this.lecturer,
    required this.weekday,
    required this.semester,
  });
  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      id: map['id'],
      courseName: map['courseName'],
      sks: map['sks'],
      room: map['room'],
      lecturer: map['lecturer'],
      weekday: map['weekday'],
      semester: map['semester'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'courseName': courseName,
      'sks': sks,
      'room': room,
      'lecturer': lecturer,
      'weekday': weekday.toString(), // Convert Weekday enum to string
      'semester': semester,
    };
  }
}

// enum Weekday {
//   Monday,
//   Tuesday,
//   Wednesday,
//   Thursday,
//   Friday,
//   Saturday,
//   Sunday,
// }

class Semester {
  final int number;
  Semester(this.number);

  @override
  bool operator ==(other) {
    return (other is Semester) && other.number == number;
  }

  @override
  int get hashCode => number.hashCode;
}
