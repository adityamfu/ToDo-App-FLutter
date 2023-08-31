import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:to_do/models/daily_db.dart';
import 'package:to_do/services/theme_service.dart';
import 'package:to_do/ui/splash_screen.dart';
import 'package:to_do/services/theme.dart';
import 'models/todo_db.dart';

void main() async {
  await GetStorage.init();
  Get.put(ThemeService());
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelperTodo.instance.initDatabase();
  await DatabaseHelperSche.database;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
      home: SplashScreen(),
    );
  }
}
