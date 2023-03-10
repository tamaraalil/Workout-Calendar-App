import 'package:flutter/material.dart';
import '../data/workout.dart';

// Add Preset Workout Page

class PresetWorkout extends StatelessWidget {
  const PresetWorkout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Preset Workout'),
      ),
      body: Center(
        child: Text('Add Preset Workout', 
          style: TextStyle (fontSize: 15.0, color: Colors.black),),
      ),
    );
  }
}