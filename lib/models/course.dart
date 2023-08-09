class Course {
  int? id;
  String courseName;
  String sks;
  String room;
  String lecturer;
  Weekday weekday;
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
    // required this.weekdays,
  });
  factory Course.fromMap(Map<String, dynamic> map) {
     Weekday weekday = _weekdayFromString(map['weekday']);
    return Course(
      id: map['id'],
      courseName: map['courseName'],
      sks: map['sks'],
      room: map['room'],
      lecturer: map['lecturer'],
      weekday: weekday,
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
  static Weekday _weekdayFromString(String dayString) {
    return Weekday.values.firstWhere(
      (weekday) => weekday.toString() == 'Weekday.$dayString',
    );
  }
}

enum Weekday {
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
  Sunday,
}

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
