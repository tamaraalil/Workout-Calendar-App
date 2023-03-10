import 'package:flutter/material.dart';
import '../data/workout.dart';

// Analytics Page

class Analytics extends StatelessWidget {
  const Analytics({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
      ),
      body: Center(
        child: Text('Analytics', 
          style: TextStyle (fontSize: 15.0, color: Colors.black),),
      ),
    );
  }
}