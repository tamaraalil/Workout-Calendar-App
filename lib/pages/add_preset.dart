import 'package:flutter/material.dart';
import '../data/workout.dart';

// Add Preset Workout Page

class PresetWorkout extends StatelessWidget {
  const PresetWorkout({super.key});
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Push"), value: ("Push")),
      DropdownMenuItem(child: Text("Pull"), value: ("Pull")),
      DropdownMenuItem(child: Text("Legs"), value: ("Legs")),
    ];
    return menuItems;
  }
  final String selectedValue = "Legs";
  final bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Preset Workout'),
      ),
      body: Column(
        children: [
          Container(
            child: Row(
              children: [
                Container(
                  child: Text('Workout name: ')
                ),
                Expanded(
                  child: Container(
                    child: TextField(obscureText: false,
                    decoration:  InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Workout Name',
                    ),
                    )
                  )
                )
              ],
            )
          ),
          Container(
            child: Row(
              children: [
                Container(
                  child: Text("Preset workouts: ")
                ),
                Container(
                    child: DropdownButton<String>(
                        value: selectedValue,
                        onChanged: null,
                        items: dropdownItems
                    )
                ),
              ],
            )
          ),
          Container(
            child: Text("Sets")
          ),
          ExpansionTile(
            title: Text("Set 1"),
            children: <Widget> [
              TextField(obscureText: false,
                decoration:  InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '# sets',
                ),
              ),
              TextField(obscureText: false,
                decoration:  InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '# reps',
                ),
              ),
              TextField(obscureText: false,
                decoration:  InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'notes:',
                ),
              ),
            ]
          ),
          ExpansionTile(
              title: Text("Set 2"),
              children: <Widget> [
                TextField(obscureText: false,
                  decoration:  InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '# sets',
                  ),
                ),
                TextField(obscureText: false,
                  decoration:  InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '# reps',
                  ),
                ),
                TextField(obscureText: false,
                  decoration:  InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'notes:',
                  ),
                ),
              ]
          ),
          ExpansionTile(
              title: Text("Set 3"),
              children: <Widget> [
                TextField(obscureText: false,
                  decoration:  InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '# sets',
                  ),
                ),
                TextField(obscureText: false,
                  decoration:  InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '# reps',
                  ),
                ),
                TextField(obscureText: false,
                  decoration:  InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'notes:',
                  ),
                ),
              ]
          ),
          Container(
            child: ElevatedButton(
              onPressed: null,
              child: const Text("Add set"),
            )
          ),
          Container(
            child: Row(
              children: [
                Text("Add to workout presets "),
                Checkbox(
                  onChanged: null,
                  value: isChecked,
                )
              ],
            )
          ),
          Container(
            child: TextField(obscureText: false,
              decoration:  InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Additional notes:',
              ),
            ),
          ),
          Container(
          child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
          onPressed: null,
          child: Text("Add workout")
          )
          )
        ],
      )
    );
  }
}