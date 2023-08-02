import 'package:flutter/material.dart';
import 'package:to_do/ui/todo_screen.dart';
import 'package:to_do/ui/daily_screen.dart';
import '../widgets/sidebar.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedScreenIndex = 0;
  List<String> _screenTitles = ["Todo List", "Daily Tasks"];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openSideMenu() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_screenTitles[_selectedScreenIndex]),
        leading: Icon(Icons.account_tree_rounded),
      ),
      body: GestureDetector(
        onHorizontalDragUpdate: (details) {
          if (details.delta.dx > 0) {
            // Detect swipe from left to right (from the left edge to the right edge)
            _openSideMenu();
          }
        },
        child: Stack(
          children: [
            _selectedScreenIndex == 0 ? TodoListScreen() : DailyTaskScreen(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      drawer: CSidebar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _selectedScreenIndex,
      onTap: (index) {
        setState(() {
          _selectedScreenIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'Todo List',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Daily Tasks',
        ),
      ],
    );
  }
}


// class _HomeState extends State<Home> {
//   int _selectedScreenIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _appBar(),
//       body: _selectedScreenIndex == 0 ? TodoListScreen() : DailyTaskScreen(),
//       bottomNavigationBar: _buildBottomNavigationBar(),
//       drawer: Sidebar(),
//     );
//   }

//   _appBar() {
//     return AppBar(
//       leading: GestureDetector(
//         onTap: () {
//           ThemeService().switchTheme();
//         },
//         child: Icon(
//           Icons.nightlight_round,
//           size: 20,
//         ),
//       ),
//       actions: [
//         IconButton(
//           icon: Icon(
//             Icons.menu,
//             size: 20,
//           ),
//           onPressed: () {
//             CSidebar();
//           },
//         ),
//         SizedBox(
//           width: 20,
//         )
//       ],
//     );
//   }

//   Widget _buildBottomNavigationBar() {
//     return BottomNavigationBar(
//       currentIndex: _selectedScreenIndex,
//       onTap: (index) {
//         setState(() {
//           _selectedScreenIndex = index;
//         });
//       },
//       items: [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.checklist),
//           label: 'To-Do',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.calendar_today),
//           label: 'Daily Task',
//         ),
//       ],
//     );
//   }
// }
