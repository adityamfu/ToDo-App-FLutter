// import 'package:flutter/material.dart';

// import '../models/database_helper.dart';
// import '../models/test2_db.dart';
// import 'home.dart';

// class SplashScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: FutureBuilder(
//         future: _initializeAppData(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           } else {
//             return Home();
//           }
//         },
//       ),
//     );
//   }

//   Future<void> _initializeAppData() async {
//     WidgetsFlutterBinding.ensureInitialized();
//     await DatabaseHelperTodo.instance.initDatabase();
//     await DatabaseHelperSche.database;
//   }
// }

import 'package:flutter/material.dart';
import 'home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool showImage = false;
  @override
  void initState() {
    super.initState();
    // Simulate data loading process
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        showImage =
            true; // Set showImage menjadi true setelah progres mencapai 50%
      });
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE67E22),
      body: Center(
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 800),
          child: showImage
              ? Image.asset(
                  'assets/images/td.png', // Ganti dengan path gambar PNG Anda
                  key: Key('image'), // Penting untuk AnimatedSwitcher
                  fit: BoxFit.contain, // Atur metode scaling
                  height: 150,
                )
              : CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
        ),
      ),
    );
  }
}
