import 'package:flutter/material.dart';
import 'package:flutter_run_tracker_app/view/splash_screen_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://lngawgtrwjvuokovdoaw.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxuZ2F3Z3Ryd2p2dW9rb3Zkb2F3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzM3ODc2NDEsImV4cCI6MjA4OTM2MzY0MX0.1epJTc0SspYzFYJLII1P5cG7neu6p_2_77naNT-hizQ',
  );

  runApp(
    FlutterRunTrackerApp(),
  );
}

class FlutterRunTrackerApp extends StatefulWidget {
  const FlutterRunTrackerApp({super.key});

  @override
  State<FlutterRunTrackerApp> createState() => _FlutterRunTrackerAppState();
}

class _FlutterRunTrackerAppState extends State<FlutterRunTrackerApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreenUi(),
      theme: ThemeData(
        textTheme: GoogleFonts.promptTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
    );
  }
}