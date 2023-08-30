import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:to_do/widgets/schedule_input.dart';
import 'package:url_launcher/link.dart';
import '../services/theme_service.dart';
import '../ui/daily_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class CSidebar extends StatelessWidget {
  final DateTime selectedDate = DateTime.now();
  // final Uri _url = Uri.parse('https://flutter.dev');

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri(scheme: "https", host: url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch url');
    }
  }
  // Future<void> _launchUrl(String url) async {
  //   final Uri uri = Uri(scheme: "https", host: url);
  //   if (!await canLaunch(uri.toString())) {
  //     throw Exception('Could not launch URL');
  //   }
  //   await launch(uri.toString(), forceSafariVC: false, forceWebView: false);
  // }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Text(
              'ToDo',
              style: TextStyle(
                fontSize: 70,
                fontFamily: 'Monomaniac One',
              ),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ExpansionTile(
            childrenPadding: EdgeInsets.only(left: 30),
            leading: Container(
              margin: EdgeInsets.only(top: 5),
              height: 12,
              width: 24,
              decoration: BoxDecoration(
                color: Color(0XFF262A32),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  bottomLeft: Radius.circular(20),
                  topRight: Radius.circular(7),
                  bottomRight: Radius.circular(7),
                ),
              ),
            ),
            title: Text('FYI !'),
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    ListTile(
                      title: Row(
                        children: [
                          Container(
                            height: 17,
                            width: 33,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(0),
                                bottomLeft: Radius.circular(20),
                                topRight: Radius.circular(7),
                                bottomRight: Radius.circular(7),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Text('High Priority Task'),
                        ],
                      ),
                    ),
                    ListTile(
                      title: Row(
                        children: [
                          Container(
                            height: 17,
                            width: 33,
                            decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(0),
                                bottomLeft: Radius.circular(20),
                                topRight: Radius.circular(7),
                                bottomRight: Radius.circular(7),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Text('Medium Priority Task'),
                        ],
                      ),
                    ),
                    ListTile(
                      title: Row(
                        children: [
                          Container(
                            height: 17,
                            width: 33,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(0),
                                bottomLeft: Radius.circular(20),
                                topRight: Radius.circular(7),
                                bottomRight: Radius.circular(7),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Text('Low Priority Task'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.task_rounded),
            title: Text('Todo   Screen'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ScheduleScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.school_rounded),
            title: Text('Daily Task Screen'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DailyTaskScreen(),
                ),
              );
            },
          ),
          Container(
            child: Center(
              child: Link(
                  target: LinkTarget.blank,
                  uri: Uri.parse('https://flutter.dev'),
                  builder: (context, followLink) => ElevatedButton(
                      onPressed: followLink, child: Text('Open Link'))),
            ),
          ),
          ListTile(
            leading: Icon(Icons.date_range),
            title: Text('Lesson'),
            onTap: () async {
              try {
                await _launchUrl(
                    'www.lipsum.com'); // Replace with your actual URL
              } catch (e) {
                print('Error: $e');
              }
            },
            // onTap: () {
            //   _launchUrl('www.lipsum.com');
            // },
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
          ), // Untuk menggeser teks ke bagian bawah
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(top: 300),
              padding: EdgeInsets.all(16.0),
              child: Text(
                '© 2023 Adityamfu. Indie Develompent.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TestWidgetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Widget'),
      ),
      body: Center(
        child: Text('This is a test widget.'),
      ),
    );
  }
}

class AnotherWidgetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Another Widget'),
      ),
      body: Center(
        child: Text('This is another widget.'),
      ),
    );
  }
}
