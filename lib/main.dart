import 'package:flutter/material.dart';
import 'pages/calendar.dart';

// Workout Calendar App
// Group 10

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workout Calendar',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'Workout Calendar'),
    );
  }
}
