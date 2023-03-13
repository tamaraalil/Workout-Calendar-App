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
          SizedBox(height: 20.0),
          Container(
            child: Text('New Workout for <Date>: ', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
          ),
          SizedBox(height: 20.0),
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
          SizedBox(height: 8.0),
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
          SizedBox(height: 8.0),
          Container(
            child: Text("Sets")
          ),
          SizedBox(height: 8.0),
          ExpansionTile(
            title: Text("Set 1"),
            children: <Widget> [
              TextField(obscureText: false,
                decoration:  InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '# reps',
                ),
              ),
              TextField(obscureText: false,
                decoration:  InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '# weight',
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
                    labelText: '# reps',
                  ),
                ),
                TextField(obscureText: false,
                  decoration:  InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '# weight',
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
                    labelText: '# reps',
                  ),
                ),
                TextField(obscureText: false,
                  decoration:  InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '# weight',
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
          SizedBox(height: 8.0),
          Container(
            child: ElevatedButton(
              onPressed: (){},
              child: const Text("Add set"),
            )
          ),
          SizedBox(height: 8.0),
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
          SizedBox(height: 8.0),
          Container(
            child: TextField(obscureText: false,
              decoration:  InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Additional notes:',
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Container(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            onPressed: () {},
            child: Text("Add workout")
            )
          )
        ],
      )
    );
  }
}