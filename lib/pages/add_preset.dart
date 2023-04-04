import 'package:flutter/material.dart';
import '../data/workout.dart';
import 'calendar.dart';

// Add Preset Workout Page

class PresetWorkout extends StatelessWidget {
  PresetWorkout({super.key});
  List<Sets> setsToAdd = [];
  List<Event> exercises = [];

  final presetNameController = TextEditingController();
  final exerciseNameController = TextEditingController();
  final notesController = TextEditingController();
  final textController = TextEditingController();
  final repsController = TextEditingController();
  final weightController = TextEditingController();
  final setNoteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Add Preset Workout'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(height: 20.0),
            Container( // Title
              child: Text('New Preset Workout: ', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
            ),
            SizedBox(height: 20.0),
            Container( // Preset workout name text box
              child: Row(
                children: [
                  Container( 
                    child: Text('Preset workout name: ')
                  ),
                  Expanded(
                    child: Container(
                      child: TextFormField(
                        obscureText: false,
                        controller: presetNameController,
                        decoration:  InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Preset Workout',
                        ),
                      )
                    )
                  )
                ],
              )
            ),
            SizedBox(height: 8.0),
            Container( // Exercise name text box
              child: Row(
                children: [
                  Container(
                    child: Text('Exercise name: ')
                  ),
                  Expanded(
                    child: Container(
                      child: TextFormField(
                        obscureText: false,
                        controller: exerciseNameController,
                        decoration:  InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Exercise Name',
                        ),
                      )
                    )
                  )
                ],
              )
            ),
            SizedBox(height: 8.0),
            // Sets dropdown
            Container(child: Text("Excercise Sets")),
            SizedBox(height: 8.0),
            ExpansionTile(title: Text("Set info"), children: <Widget>[
              TextFormField( // Reps textbox
                obscureText: false,
                controller: repsController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '# reps',
                ),
              ),
              TextFormField( // Weight text box
                obscureText: false,
                controller: weightController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '# weight',
                ),
              ),
              TextFormField( // Notes text box
                obscureText: false,
                controller: setNoteController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'notes:',
                ),
              ),
            ]),
            SizedBox(height: 8.0),
            Container( // Add set button
                child: ElevatedButton(
                onPressed: () {
                  // Create new instance of set with user input
                  Sets newset = Sets(
                      reps: repsController.text,
                      weight: weightController.text,
                      notes: setNoteController.text);
                  
                  // Add the set to the list of sets for the exercise
                  setsToAdd.add(newset);
                  
                  // Show a snackbar to notify the user of action
                  final snackBar = SnackBar(
                    content: const Text('Set Added!'),
                    action: SnackBarAction(
                      label: 'Added!',
                      onPressed: () {},
                    ),
                  );
                  
                  // Empty out text fields
                  repsController.clear();
                  weightController.clear();
                  setNoteController.clear();

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: const Text("Add set"),
            )),
            SizedBox(height: 8.0),
            Container( // Additional notes text box
              child: TextFormField(
                obscureText: false,
                controller: notesController,
                decoration:  InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Additional notes:',
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Container( // Add exercise button
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
              onPressed: () {
                // Create new list of sets added
                List<Sets> currSets = [];
                for (Sets set in setsToAdd) {
                  currSets.add(set);
                }

                // Create new instance of event with user input
                Event newEvent = Event(
                    title: exerciseNameController.text,
                    date: "n/a",
                    sets: currSets,
                    addToPreset: false,
                    notes: notesController.text);

                // Add the event to calendar
                exercises.add(newEvent);

                // Show snackbar to notify user of action
                final snackBar = SnackBar(
                  content: const Text('Exercise Added!'),
                  action: SnackBarAction(
                    label: 'Added!',
                    onPressed: () {},
                  ),
                );

                // Empty out text fields
                exerciseNameController.clear();
                notesController.clear();
                setsToAdd.clear();

                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: Text("Add exercise")
              )
            ),
            SizedBox(height: 60.0),
            Container( // Add preset workout button
              child: Align (
                alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                  onPressed: () {
                    // Create a new list of all the exercises added to the preset
                    List<Event> currEx = [];
                    for (Event e in exercises) {
                      currEx.add(e);
                    }

                    // Add the preset to the list of presets
                    createPreset(currEx, presetNameController.text);
                    
                    // Empty out text fields
                    presetNameController.clear();
                    exercises.clear();
                  },
                  child: Text("Save Preset Workout")
                )
              )
            ),
            SizedBox(height: 20.0),
          ],
        )
      )
    );
  }
}