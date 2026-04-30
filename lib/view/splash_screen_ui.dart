import 'package:flutter/material.dart';
import 'package:flutter_run_tracker_app/view/show_all_run_ui.dart';

class SplashScreenUi extends StatefulWidget {
  const SplashScreenUi({super.key});

  @override
  State<SplashScreenUi> createState() => _SplashScreenUiState();
}

class _SplashScreenUiState extends State<SplashScreenUi> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ShowAllRunUi(),
        ),
      );
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 37, 53, 97),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 180,
              height: 180,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 50),
            Text(
              'Run Tracker',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 50),
            CircularProgressIndicator(
              color: const Color.fromARGB(255, 72, 91, 141),
            ),
            SizedBox(height: 300),
            Text(
              '© 2026 Run Tracker',
              style: TextStyle(
                fontSize: 15,
                color: const Color.fromARGB(255, 199, 199, 199),
              ),
            ),
            Text(
              'Created by Seksan SAU TEAM',
              style: TextStyle(
                fontSize: 15,
                color: const Color.fromARGB(255, 199, 199, 199),
              ),
            ),
          ],
        ),
      ),
    );
  }
}