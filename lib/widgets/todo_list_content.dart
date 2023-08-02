import 'package:flutter/material.dart';
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
    } else if (selectedCategory == 'Personal') {
      return tasks.where((task) => task.category == 'Personal').toList();
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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CategoryContainer('All', selectedCategory, onCategoryTap),
                CategoryContainer('Work', selectedCategory, onCategoryTap),
                CategoryContainer('Personal', selectedCategory, onCategoryTap),
                CategoryContainer('Study', selectedCategory, onCategoryTap),
              ],
            ),
          ),
        ),
        Container(
          color: Colors.grey[300],
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Daftar Task',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
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
