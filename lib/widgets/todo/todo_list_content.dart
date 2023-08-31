import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do/widgets/search_bar.dart';
import '../../models/todo_enum.dart';
import '../../util/todo_category.dart';
import 'todo_list_item.dart';

class Content extends StatelessWidget {
  final String selectedCategory;
  final List<TodoTask> tasks;
  final Function(String) onCategoryTap;
  final Function(int) onMarkAsDone;
  final Function(int) onDeleteTask;
  final Function(TodoTask) onTaskTap;

  const Content({Key?key,
    required this.selectedCategory,
    required this.tasks,
    required this.onCategoryTap,
    required this.onMarkAsDone,
    required this.onDeleteTask,
    required this.onTaskTap,
  }) : super(key: key);

  List<TodoTask> _filteredTasks() {
    if (selectedCategory == 'All') {
      return tasks;
    } else if (selectedCategory == 'Work') {
      return tasks.where((task) => task.category == 'Work').toList();
    } else if (selectedCategory == 'Private') {
      return tasks.where((task) => task.category == 'Private').toList();
    } else if (selectedCategory == 'Study') {
      return tasks.where((task) => task.category == 'Study').toList();
    }
    // Tambahkan filter untuk kategori baru di sini
    // else if (selectedCategory == 'KategoriBaru') {
    //   return tasks.where((task) => task.category == 'KategoriBaru').toList();
    // }
    else {
      return tasks;
    }
  }

  List<TodoTask> _sortedTasks() {
    List<TodoTask> incompletedTasks =
        _filteredTasks().where((task) => !task.isDone).toList();
    List<TodoTask> completedTasks =
        _filteredTasks().where((task) => task.isDone).toList();

    return [...incompletedTasks, ...completedTasks];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 300,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiary,
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(0, 94, 92, 92).withOpacity(0.4),
                offset: const Offset(0, 8),
                blurRadius: 14,
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.all(4),
                child: SearchBr(),
              ),
              Container(
                height: 33,
                width: double.infinity,
                margin: const EdgeInsets.only(right: 200),
                decoration: BoxDecoration(
                  color: const Color(0XFFFDE5Cf),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(41, 0, 0, 0).withOpacity(0.2),
                      offset: const Offset(2, 5),
                      blurRadius: 7,
                    )
                  ],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(0),
                    bottomLeft: Radius.circular(0),
                    topRight: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Today is : ',
                        style: TextStyle(
                          color: Color(0XFF262A32),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      StreamBuilder<DateTime>(
                        stream: Stream.periodic(const Duration(seconds: 1),
                            (data) => DateTime.now()),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final formattedDate = DateFormat('EEE, d MMM y')
                                .format(snapshot.data!);
                            return Text(
                              formattedDate,
                              style: const TextStyle(
                                color: Color(0XFF262A32),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            );
                          } else {
                            return const Text('Loading...');
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 35),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CategoryContainer(
                              category: 'All',
                              selectedCategory: selectedCategory,
                              onTap: onCategoryTap,
                            ),
                            CategoryContainer(
                              category: 'Work',
                              selectedCategory: selectedCategory,
                              onTap: onCategoryTap,
                            ),
                            CategoryContainer(
                              category: 'Private',
                              selectedCategory: selectedCategory,
                              onTap: onCategoryTap,
                            ),
                            CategoryContainer(
                              category: 'Study',
                              selectedCategory: selectedCategory,
                              onTap: onCategoryTap,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    top: 0,
                    bottom: 0,
                    left: 10,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          'Category',
                          style: TextStyle(
                            letterSpacing: 5,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _sortedTasks().length,
            itemBuilder: (context, index) {
              TodoTask task = _sortedTasks()[index];

              return TodoTaskListItem(
                todoTask: task,
                markAsDone: () => onMarkAsDone(tasks.indexOf(task)),
                deleteTask: () => onDeleteTask(tasks.indexOf(task)),
                isCompleted: task.isDone,
                onTap: () => onTaskTap(task),
              );
            },
          ),
        ),
      ],
    );
  }
}
