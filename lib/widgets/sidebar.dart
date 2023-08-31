import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/link.dart';
import '../services/theme_service.dart';
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
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child:const Text(
              'ToDo',
              style: TextStyle(
                fontSize: 70,
                fontFamily: 'Monomaniac One',
              ),
            ),
          ),
          ExpansionTile(
            childrenPadding:const EdgeInsets.only(left: 30),
            leading: Container(
              margin:const EdgeInsets.only(top: 5),
              height: 12,
              width: 24,
              decoration: const BoxDecoration(
                color: Color(0XFF262A32),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  bottomLeft: Radius.circular(20),
                  topRight: Radius.circular(7),
                  bottomRight: Radius.circular(7),
                ),
              ),
            ),
            title:const Text('FYI !'),
            children: [
              Container(
                margin:const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    ListTile(
                      title: Row(
                        children: [
                          Container(
                            height: 17,
                            width: 33,
                            decoration:const BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(0),
                                bottomLeft: Radius.circular(20),
                                topRight: Radius.circular(7),
                                bottomRight: Radius.circular(7),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text('High Priority Task'),
                        ],
                      ),
                    ),
                    ListTile(
                      title: Row(
                        children: [
                          Container(
                            height: 17,
                            width: 33,
                            decoration:const BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(0),
                                bottomLeft: Radius.circular(20),
                                topRight: Radius.circular(7),
                                bottomRight: Radius.circular(7),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text('Medium Priority Task'),
                        ],
                      ),
                    ),
                    ListTile(
                      title: Row(
                        children: [
                          Container(
                            height: 17,
                            width: 33,
                            decoration:const BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(0),
                                bottomLeft: Radius.circular(20),
                                topRight: Radius.circular(7),
                                bottomRight: Radius.circular(7),
                              ),
                            ),
                          ),
                         const SizedBox(width: 10),
                          const Text('Low Priority Task'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
            Center(
              child: Link(
                  target: LinkTarget.blank,
                  uri: Uri.parse('https://flutter.dev'),
                  builder: (context, followLink) => ElevatedButton(
                      onPressed: followLink, child:const Text('Open Link'))),
            ),
          
          ListTile(
            leading:const Icon(Icons.date_range),
            title:const Text('Lesson'),
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
          const Divider(),
          ListTile(
            leading:const Icon(Icons.dark_mode_outlined),
            title: const Text('Dark Mode'),
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
              margin:const EdgeInsets.only(top: 300),
              padding:const EdgeInsets.all(16.0),
              child:const Text(
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