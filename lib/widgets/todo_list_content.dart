import 'package:flutter/material.dart';
import 'package:to_do/widgets/search_bar.dart';
import '../services/enum.dart';
import '../util/category.dart';
import 'todo_list_item.dart';

class Content extends StatelessWidget {
  final String selectedCategory;
  final List<TodoTask> tasks;
  final Function(String) onCategoryTap;
  final Function(int) onMarkAsDone;
  final Function(int) onDeleteTask;
  final Function(TodoTask) onTaskTap;

  Content({
    required this.selectedCategory,
    required this.tasks,
    required this.onCategoryTap,
    required this.onMarkAsDone,
    required this.onDeleteTask,
    required this.onTaskTap,
  });

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
          height: 340,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiary,
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(0, 94, 92, 92).withOpacity(0.4),
                offset: Offset(0, 8),
                blurRadius: 14,
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.all(6),
                child: SearchBr(),
              ),
              Container(
                height: 33,
                width: double.infinity,
                margin: EdgeInsets.only(right: 200),
                decoration: BoxDecoration(
                  color: Color(0XFFFDE5Cf),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(41, 0, 0, 0).withOpacity(0.2),
                      offset: Offset(2, 5),
                      blurRadius: 7,
                    )
                  ],
                  borderRadius: BorderRadius.only(
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
                      Text(
                        'Today is :',
                        style: TextStyle(
                          color: Color(0XFF262A32),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        ' Mon, 7 Aug 2023',
                        style: TextStyle(
                          color: Color(0XFF262A32),
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 35),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CategoryContainer(
                                'All', selectedCategory, onCategoryTap),
                            CategoryContainer(
                                'Work', selectedCategory, onCategoryTap),
                            CategoryContainer(
                                'Private', selectedCategory, onCategoryTap),
                            CategoryContainer(
                                'Study', selectedCategory, onCategoryTap),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: 10,
                    child: Container(
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
                  ),
                ],
              ),
              Container(
                // color: Colors.grey[300],
                padding: EdgeInsets.symmetric(horizontal: 6),
                child: Text(
                  'Daftar Task',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
