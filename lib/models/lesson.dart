class Lesson {
  final int id;
  final String title;
  final String description;
  final DateTime date;
  final bool repeated;

  Lesson({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    this.repeated = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.millisecondsSinceEpoch,
      'repeated': repeated ? 1 : 0,
    };
  }

  factory Lesson.fromMap(Map<String, dynamic> map) {
    return Lesson(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      repeated: map['repeated'] == 1,
    );
  }
}
