import 'package:flutter/material.dart';
import '../data/workout.dart';
import 'calendar.dart';
import 'add_preset.dart';

// View Presets

class ViewPresets extends StatefulWidget {
  Map<String, List<Event>> presetWorkouts;
  ViewPresets({required this.presetWorkouts});
  
  @override
  State<ViewPresets> createState() => _ViewPresetsState();
}

class _ViewPresetsState extends State<ViewPresets> {
  int i = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Text("Preset Workouts"),
        elevation: 0,
      ),
      drawer: Drawer( 
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                  // Drawer title
                  color: Colors.deepPurple,
                  image: DecorationImage(
                      image: const AssetImage("assets/gym.png"),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.7), BlendMode.colorBurn))),
              child: const Text(
                '\nFitter\nToday',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 30.0,
                    color: Colors.white),
              ),
            ),
            ListTile(
              // Drawer option to calendar page
              leading: Icon(
                Icons.calendar_month,
                color: Colors.black,
                size: 20.0,
              ),
              title: const Text('Calendar'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyHomePage(title: "Workout Calendar")),
                );
              },
            ),
            ListTile(
              // Drawer option to add preset workout page
              leading: Icon(
                Icons.add_circle_outline,
                color: Colors.black,
                size: 20.0,
              ),
              title: const Text('Add Preset Workout'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PresetWorkout()
                  ),
                );
              },
            ),
            ListTile(
              // Drawer option to add preset workout page
              leading: Icon(
                Icons.class_outlined,
                color: Colors.black,
                size: 20.0,
              ),
              title: const Text('View Preset Workouts'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: showPresets(widget.presetWorkouts)
    );
  }

  showPresets(presetWorkouts) {
    // If there are preset workouts, display them
    if (presetWorkouts.isNotEmpty) {
      return Column(
        children: [
          // Loop through preset workouts & display them
          for (var key in presetWorkouts.keys) 
            ExpansionTile(
              title: Text(key),
              children: _createExercises(presetWorkouts[key], context, key, presetWorkouts),
            ),
        ]
      );
    } else { // Display for no preset workouts saved
      return Center(
          child: Text('No Preset Workouts yet.', style: TextStyle(fontSize: 25.0),),
      );
    }
  }
}

// Create new expansion tiles for each set in the given exercise 
List<ExpansionTile> _createSets(Event value) {
  List<ExpansionTile> list = [];
  for (int i = 0; i < value.sets.length; i++) {
    list.add(ExpansionTile(title: Text("Set ${i + 1}"), children: <Widget>[
      ListTile(
          title: Text(
              "Reps: ${value.sets[i].reps} Weight: ${value.sets[i].weight}"),
          subtitle: Text("Notes: ${value.sets[i].notes}"))
    ]));
  }
  return list;
}

// Create new expansion tiles for each exercise passed in
List<ExpansionTile> _createExercises(List<Event> exercises, BuildContext context, String key, Map<String, List<Event>> presetWorkouts) {
  // Exercises
  List<ExpansionTile> list = [];
  for (Event exercise in exercises) {
    list.add(ExpansionTile(
      title: Text(exercise.title),
      subtitle: Text(exercise.notes),
      children: _createSets(exercise),
    )
    );
  }
  // Delete button
  list.add(ExpansionTile(
      title: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red, fixedSize: Size(1,1)),
        // Show warning dialog
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            content: const Text('Are you sure you want to delete this preset workout?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'No'),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  // Delete preset workout when user clicks "Yes"
                  presetWorkouts.remove(key);
                  deletePreset(key);
                  ViewPresets(presetWorkouts: presetWorkouts);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context2) => ViewPresets(presetWorkouts: presetWorkouts)),
                    );
                },
                child: const Text('Yes'),
              ),
            ],
          ),
        ),
        child: Text("Delete")
      ),
      leading: const SizedBox(width: 70),
      trailing: const SizedBox(width: 70),
    )
  );
  return list;
}