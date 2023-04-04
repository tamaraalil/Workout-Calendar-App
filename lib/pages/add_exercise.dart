import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../data/workout.dart';
import '../data/utils.dart';
import 'calendar.dart';

// Add Preset Workout Page

class AddExercise extends StatefulWidget {
  final String focusedDay;
  final List<String> presets;
  const AddExercise({Key? key, required this.focusedDay, required this.presets}) : super(key: key);

  @override
  State<AddExercise> createState() => _AddExerciseState();
}

class _AddExerciseState extends State<AddExercise> {
  List<Sets> sets = [];
  String? selectedValue;
  bool isChecked = false;

  final nameController = TextEditingController();
  final notesController = TextEditingController();
  final textController = TextEditingController();
  final repsController = TextEditingController();
  final weightController = TextEditingController();
  final setNoteController = TextEditingController();
  final detailsContoller = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Exercise'),
        ),
        body: SingleChildScrollView(
          //reverse: true,
          padding: EdgeInsets.all(10),
          child: Column (
            children: [
              SizedBox(height: 20.0),
              Container(
                  child: Text(
                      'New Exercise for ' +
                          widget.focusedDay.replaceAll("00:00:00.000Z", ""),
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold))),
              SizedBox(height: 20.0),
              Container(
                  child: Row(
                children: [
                  Container(child: Text('Exercise name: ')),
                  Expanded(
                      child: Container(
                          child: TextFormField(
                          obscureText: false,
                          controller: nameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Exercise Name',
                          ),
                  )))
                ],
              )),
              SizedBox(height: 16.0),
              Container(child: Text("Excercise Sets")),
              SizedBox(height: 8.0),
              ExpansionTile(title: Text("Set info"), children: <Widget>[
                TextFormField(
                  obscureText: false,
                  controller: repsController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '# reps',
                  ),
                ),
                TextFormField(
                  obscureText: false,
                  controller: weightController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '# weight',
                  ),
                ),
                TextFormField(
                  obscureText: false,
                  controller: setNoteController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'notes:',
                  ),
                ),
              ]),
              SizedBox(height: 8.0),
              Container(
                  child: ElevatedButton(
                onPressed: () {
                  Sets newset = Sets(
                      reps: repsController.text,
                      weight: weightController.text,
                      notes: setNoteController.text);
                  sets.add(newset);
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
              Container(
                  child: Row(
                    children: [
                      Text("Add to exercise presets "),
                      Checkbox(
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                    ],
                  )
              ),
              SizedBox(height: 8.0),
              if (isChecked) 
                Container(
                  child: Row(
                    children: [
                      Container(child: Text("Preset Exercises: ")),
                      Container(
                        child: DropdownButton<String>(
                          value: selectedValue,
                          hint: Text("Choose"),
                          onChanged: (String? newValue){
                            setState(() {
                              selectedValue = newValue!;
                            });
                          },
                          items: widget.presets.map<DropdownMenuItem<String>>(
                            (newValue) => DropdownMenuItem(
                              value: newValue,
                              child: Text(newValue),
                            ),
                          ).toList(),
                        )
                      ),
                    ],
                  )
                ),
              
              SizedBox(height: 8.0),
              Container(
                child: TextFormField(
                  obscureText: false,
                  controller: notesController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Additional notes:',
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                  child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                      onPressed: () {
                        Event newExercise = Event(
                            title: nameController.text,
                            date: widget.focusedDay,
                            sets: sets,
                            addToPreset: isChecked,
                            notes: notesController.text);

                        final snackBar = SnackBar(
                          content: const Text('Exercise Added!'),
                          action: SnackBarAction(
                            label: 'Added!',
                            onPressed: () {
                              // Some code to undo the change.
                            },
                          ),
                        );
                        addEvent(newExercise);
                        
                        // If the "add to presets" is checked, add it to the preset map
                        if (isChecked) {
                          addPreset(newExercise, selectedValue!);
                        }

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage(
                                  event: newExercise, title: "Workout Calendar")),
                        );
                        setState(() {});
                      },
                      child: Text("Add exercise")))
            ],
          )
        )
      );
  }
}
