import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../services/theme_service.dart';
import '../ui/todo_screen.dart';
import '../ui/daily_screen.dart';

class CSidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Text('My App'),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('Todo List Screen'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => TodoListScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Daily Task Screen'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => DailyTaskScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.texture_sharp),
            title: Text('Test Widget'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => DailyTaskScreen(),
                ),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.dark_mode_outlined),
            title: Text('Dark Mode'),
            trailing: CupertinoSwitch(
              value: ThemeService().isDarkMode,
              onChanged: (value) {
                ThemeService().switchTheme();
              },
            ),
            onTap: () {
              ThemeService().switchTheme();
            },
          ),
        ],
      ),
    );
  }
}
