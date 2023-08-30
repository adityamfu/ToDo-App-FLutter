// import '../models/test2_db.dart';
// import 'test2_enum.dart';

// class LessonManager {
//   // final dbHelper = DatabaseHelper.instance;

//   // Future<List<Lesson>> getLessonsForDay(DateTime date) async {
//   //   final lessonsMapList = await dbHelper.queryLessonsForDay(date);
//   //   return lessonsMapList.map<Lesson>((lessonMap) => Lesson.fromMap(lessonMap)).toList();
//   // }
//   final DatabaseHelperSche _databaseHelper = DatabaseHelperSche();

//   Future<List<Lesson>> getLessonsForDay(DateTime date) async {
//     final lessonsMapList = await _databaseHelper.queryLessonsForDay(date);
//     return lessonsMapList
//         .map((lessonMap) => Lesson.fromMap(lessonMap))
//         .toList();
//   }

//   Future<void> insertLesson(Lesson lesson) async {
//     await DatabaseHelperSche.insertLesson(lesson);
//   }
// }
