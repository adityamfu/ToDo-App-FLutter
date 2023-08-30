import 'package:flutter/material.dart';
import 'package:to_do/services/enum.dart';
import 'package:to_do/widgets/todo_list_content.dart';
import '../models/database_helper.dart';
import '../widgets/bottomseed.dart';
import '../widgets/task_detail.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  late final DatabaseHelperTodo _dbHelper;
  List<TodoTask> tasks = [];
  String selectedCategory = 'All'; // Default selected category is 'All.'

  @override
  void initState() {
    super.initState();
    _dbHelper = DatabaseHelperTodo.instance;

    _loadTasks();
  }

  void _loadTasks() async {
    List<Map<String, dynamic>> rows = await _dbHelper.queryAllRows();
    tasks = rows.map((row) => TodoTask.fromMap(row)).toList();

    setState(() {});
  }

  void addTask(String taskName, TaskPriority priority, DateTime createdAt,
      DateTime startTime, DateTime endTime, String taskDescription) async {
    TodoTask newTask = TodoTask(
      name: taskName,
      priority: priority,
      category: selectedCategory,
      createdAt: createdAt,
      completedAt: createdAt,
      startTime: startTime,
      endTime: endTime,
      description: taskDescription,
    );

    await _dbHelper.insertTask(newTask.toMap());
    _loadTasks();
    tasks.add(newTask);
    tasks.sort((a, b) => b.priority.index.compareTo(a.priority.index));

    Navigator.pop(context);
  }

  void deleteTask(int index) async {
    if (index >= 0 && index < tasks.length) {
      String taskName = tasks[index]
          .name; // Assuming 'name' is the property for the task name
      await _dbHelper.deleteTask(taskName);
      setState(() {
        tasks.removeAt(index);
      });
    }
  }

  // void deleteTask(int index) async {
  //   // int taskId = tasks[index].hashCode; // Assume tasks have an 'id' property
  //   // await _dbHelper.deleteTask(taskId);
  //   setState(() {
  //     tasks.removeAt(index);
  //   });
  // }

  // void addTask(String taskName, TaskPriority priority, DateTime createdAt,
  //     DateTime startTime, DateTime endTime, String taskDescription) {
  //   setState(() {
  //     TodoTask newTask = TodoTask(
  //       name: taskName,
  //       priority: priority,
  //       category: selectedCategory,
  //       createdAt: createdAt,
  //       completedAt: createdAt,
  //       startTime: startTime,
  //       endTime: endTime,
  //       description: taskDescription,
  //     );
  //     tasks.add(newTask);
  //     tasks.sort((a, b) => b.priority.index.compareTo(a.priority.index));
  //   });
  //   Navigator.pop(context);
  // }

  void showAddTaskBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(40.0),
        ),
      ),
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
      backgroundColor: Theme.of(context).colorScheme.background,
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(17),
        ),
        backgroundColor: Color(0XFFE67E22),
        onPressed: () {
          showAddTaskBottomSheet(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
