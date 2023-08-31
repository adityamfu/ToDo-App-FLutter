import 'package:flutter/material.dart';
import '../home.dart';

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
                  'assets/images/td.png',
                  key: Key('image'),
                  fit: BoxFit.contain,
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
