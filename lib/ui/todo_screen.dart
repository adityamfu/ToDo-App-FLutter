import 'package:flutter/material.dart';
import 'package:to_do/services/enum.dart';
import 'package:to_do/widgets/todo_list_content.dart';
import '../widgets/bottomseed.dart';
import '../widgets/task_detail.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<TodoTask> tasks = [];
  String selectedCategory = 'All'; // Default selected category is 'All.'

  void addTask(String taskName, TaskPriority priority, DateTime createdAt,
      DateTime startTime, DateTime endTime) {
    setState(() {
      TodoTask newTask = TodoTask(
        name: taskName,
        priority: priority,
        category: selectedCategory,
        createdAt: createdAt,
        completedAt: createdAt,
        startTime: startTime,
        endTime: endTime,
      );
      tasks.add(newTask);
      tasks.sort((a, b) => b.priority.index.compareTo(a.priority.index));
    });
    Navigator.pop(context);
  }

  void showAddTaskBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return AddTaskBottomSheet(addTask);
      },
    );
  }

  void _showTaskDetails(BuildContext context, TodoTask task) async {
    String? result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return TaskDetailDialog(todoTask: task);
      },
    );

    if (result == 'Done') {
      markAsDone(tasks.indexOf(task));
    } else if (result == 'Delete') {
      deleteTask(tasks.indexOf(task));
    }
  }

  void markAsDone(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Task Selesai'),
          content: Text('Apakah task ini telah benar-benar selesai?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  tasks[index].isDone = true;
                });
                Navigator.pop(context);
              },
              child: Text('Done'),
            ),
          ],
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  List<TodoTask> _filteredTasks() {
    if (selectedCategory == 'All') {
      return tasks;
    } else {
      return tasks.where((task) => task.category == selectedCategory).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Content(
        selectedCategory: selectedCategory,
        tasks: tasks,
        onCategoryTap: (category) {
          setState(() {
            selectedCategory = category;
          });
        },
        onMarkAsDone: markAsDone,
        onDeleteTask: deleteTask,
        onTaskTap: (task) {
          _showTaskDetails(context, task);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddTaskBottomSheet(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
