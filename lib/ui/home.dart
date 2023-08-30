import 'package:flutter/material.dart';
import 'package:to_do/ui/todo_screen.dart';
import '../widgets/sidebar.dart';
import '../widgets/test2.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentPageIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  void _onPageChanged(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  void _openSideMenu() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      key: _scaffoldKey,
      appBar: AppBar(
        // centerTitle: true,
        toolbarHeight: 70,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          _currentPageIndex == 0 ? 'DaiLy' : 'ToDo',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontFamily: 'Monomaniac One',
            fontSize: 40,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.account_tree_rounded,
            color: Theme.of(context).colorScheme.primary,
            size: 30,
          ),
          onPressed: () {
            _openSideMenu();
          },
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: [
          DateScreen(),
          TodoListScreen(),
        ],
      ),
      drawer: CSidebar(),
    );
  }
}
