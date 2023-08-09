class Course {
  final String name;
  final int credits;
  int semester;
  List<String> selectedDays;
  String room;
  String lecture;
  DateTime startDate;
  DateTime endDate;

  Course({
    required this.name,
    required this.credits,
    required this.semester,
    required this.selectedDays,
    required this.room,
    required this.lecture,
    required this.startDate,
    required this.endDate,
  });
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
