import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/test2_db.dart';
import '../services/test2_enum.dart';
import '../util/test2_input.dart';
import 'dart:async';

class DateScreen extends StatefulWidget {
  @override
  _DateScreenState createState() => _DateScreenState();
}

class _DateScreenState extends State<DateScreen> {
  final int numberOfDaysToShow = 10;
  late DateTime currentDate;
  late DateTime selectedDate;
  late List<DateTime> upcomingDates;
  late List<Lesson> lessons = []; // List of Lesson objects
  // late LessonManager lessonManager;
  Completer<void>? _refreshCompleter;
  @override
  void initState() {
    super.initState();
    currentDate = DateTime.now();
    selectedDate = currentDate;
    upcomingDates = generateUpcomingDates(selectedDate, numberOfDaysToShow);
    // lessonManager = LessonManager();
    _refreshCompleter = Completer<void>();
    _loadLessons(selectedDate);
  }

  Future<void> _loadLessons(DateTime selectedDate) async {
    List<Map<String, dynamic>> lessonMaps =
        await DatabaseHelperSche().queryLessonsForDay(selectedDate);

    List<Lesson> fetchedLessons =
        lessonMaps.map((map) => Lesson.fromMap(map)).toList();

    setState(() {
      lessons = fetchedLessons;
    });
  }

  List<DateTime> generateUpcomingDates(DateTime startDate, int numberOfDays) {
    List<DateTime> dates = [];
    for (int i = 0; i < numberOfDays; i++) {
      dates.add(startDate.add(Duration(days: i)));
    }
    return dates;
  }

  Future<List<Lesson>> _getLessonsForDate(DateTime date) async {
    String selectedDay = DateFormat('EEEE').format(date);
    return await _getLessonListFromDatabase(selectedDay);
  }

  Future<List<Lesson>> _getLessonListFromDatabase(String selectedDay) async {
    final db = await DatabaseHelperSche.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'lessons',
      where: 'day = ?',
      whereArgs: [selectedDay],
    );

    return List.generate(maps.length, (index) {
      return Lesson(
        id: maps[index]['id'],
        day: maps[index]['day'],
        time: maps[index]['time'],
        course: maps[index]['course'],
        room: maps[index]['room'],
        sks: maps[index]['sks'],
      );
    });
  }

  void _onDateSelected(DateTime selectedDate) {
    setState(() {
      this.selectedDate = selectedDate;
      upcomingDates = generateUpcomingDates(selectedDate, numberOfDaysToShow);
    });
  }

  Future<void> _resetToDateToday() async {
    setState(() {
      selectedDate = currentDate;
      upcomingDates = generateUpcomingDates(selectedDate, numberOfDaysToShow);
    });

    // Simulate async operation
    // await Future.delayed(Duration(seconds: 1));

    // Complete the refresh
    if (!_refreshCompleter!.isCompleted) {
      _refreshCompleter!.complete();
    }
  }

  void _openLessonInputScreen() async {
    final DateTime? pickedDate = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LessonInputScreen(),
      ),
    );

    if (pickedDate != null) {
      _onDateSelected(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: RefreshIndicator(
        onRefresh: _resetToDateToday,
        child: Column(
          children: [
            Container(
              height: 300,
              color: Theme.of(context).colorScheme.surface,
              child: Row(
                children: [
                  Container(
                    height: 140,
                    padding: EdgeInsets.all(11),
                    color: Theme.of(context).colorScheme.scrim,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          selectedDate == null
                              ? 'Pilih tanggal'
                              : DateFormat('MMMM').format(selectedDate),
                          style: TextStyle(
                            letterSpacing: 4,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          margin: EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: selectedDate == null
                                    ? Text(
                                        'Pilih tanggal',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : Text.rich(
                                        TextSpan(
                                          text: DateFormat('EEE')
                                              .format(selectedDate)
                                              .toUpperCase(),
                                          style: TextStyle(
                                            fontSize: 60,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          children: [
                                            TextSpan(
                                              text:
                                                  ' ${DateFormat('dd').format(selectedDate)}',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 12),
                          child: FutureBuilder<List<Lesson>>(
                            future: _getLessonListFromDatabase(
                              DateFormat('EEEE').format(selectedDate),
                            ),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.isEmpty) {
                                return Text('Tidak ada jadwal hari ini.');
                              } else {
                                List<Lesson> lessonList = snapshot.data!;

                                // Urutkan daftar berdasarkan waktu
                                lessonList
                                    .sort((a, b) => a.time.compareTo(b.time));

                                return Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 7),
                                      height: 10,
                                      color: Colors.black,
                                    ),
                                    Container(
                                      height:
                                          200, // Adjust the height as needed
                                      child: ListView.builder(
                                        itemCount: snapshot.data!.length,
                                        itemBuilder: (context, index) {
                                          Lesson lesson = snapshot.data![index];

                                          Color timeColor = lesson.room == ''
                                              ? Color(0xffFAFF00)
                                              : const Color(0xff262A32);

                                          Color fontTimeColor =
                                              lesson.room == ''
                                                  ? const Color(0xff262A32)
                                                  : Color(0xffFFFFFF);

                                          return Column(
                                            children: [
                                              if (index != 0)
                                                Divider(), // Add a divider if not the first item
                                              Row(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.all(4),
                                                    decoration: BoxDecoration(
                                                      color: timeColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Color(0x716565)
                                                              .withOpacity(0.6),
                                                          offset: Offset(0, 4),
                                                          blurRadius: 7,
                                                          spreadRadius: -2,
                                                        )
                                                      ],
                                                    ),
                                                    child: Text(
                                                      lesson.time,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        color: fontTimeColor,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          lesson.course,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                        Text.rich(
                                                          TextSpan(
                                                            text:
                                                                '(${lesson.room.isNotEmpty ? lesson.room : 'Online'})',
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text(
                                                        lesson.sks.toString()),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.0,
                ),
                itemCount: upcomingDates.length,
                itemBuilder: (context, index) {
                  DateTime date = upcomingDates[index];
                  return GestureDetector(
                    onTap: () => _onDateSelected(date),
                    child: Container(
                      margin: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(35),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(0, 126, 123, 123)
                                .withOpacity(0.5),
                            offset: Offset(1, 5),
                            blurRadius: 12,
                            spreadRadius: 0.6,
                          )
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    DateFormat('EEE')
                                        .format(upcomingDates[index])
                                        .toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    DateFormat('dd')
                                        .format(upcomingDates[index]),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Color(0xffFAFF00),
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              Color(0x716565).withOpacity(0.6),
                                          offset: Offset(0, 4),
                                          blurRadius: 7,
                                          spreadRadius: -2,
                                        )
                                      ],
                                    ),
                                    child: Text(
                                      'Online',
                                      style:
                                          TextStyle(color: Color(0xff262A32)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Color(0xff262A32),
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              Color(0x716565).withOpacity(0.6),
                                          offset: Offset(0, 4),
                                          blurRadius: 7,
                                          spreadRadius: -2,
                                        )
                                      ],
                                    ),
                                    child: Text(
                                      'Offline',
                                      style:
                                          TextStyle(color: Color(0xffFFFFFF)),
                                    ),
                                  ),
                                  Text('Sks:')
                                ],
                              ),
                            ],
                          ),
                          FutureBuilder<List<Lesson>>(
                            future: _getLessonsForDate(date),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.isEmpty) {
                                return Text('Kosong');
                              } else {
                                List<Lesson> lessonList = snapshot.data!;
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: lessonList.map((lesson) {
                                    Color timeColor = lesson.room == ''
                                        ? Color(0xffFAFF00)
                                        : const Color(0xff262A32);

                                    Color fontTimeColor = lesson.room == ''
                                        ? const Color(0xff262A32)
                                        : Color(0xffFFFFFF);

                                    return Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            color: timeColor,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0x716565)
                                                    .withOpacity(0.6),
                                                offset: Offset(0, 4),
                                                blurRadius: 7,
                                                spreadRadius: -2,
                                              )
                                            ],
                                          ),
                                          child: Text(
                                            lesson.time,
                                            maxLines: 1,
                                            style: TextStyle(
                                              color: fontTimeColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                      ],
                                    );
                                  }).toList(),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(17),
        ),
        backgroundColor: Color(0XFFE67E22),
        onPressed: _openLessonInputScreen,
        child: Icon(Icons.add),
      ),
    );
  }
}
