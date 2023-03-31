import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../data/workout.dart';
import '../data/utils.dart';
import 'calendar.dart';

// Add Preset Workout Page

class AddExercise extends StatefulWidget {
  final String focusedDay;
  const AddExercise({Key? key, required this.focusedDay}) : super(key: key);

  @override
  State<AddExercise> createState() => _AddExerciseState();
}

class _AddExerciseState extends State<AddExercise> {
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
  final nameController = TextEditingController();
  final notesController = TextEditingController();
  final textController = TextEditingController();
  final detailsContoller = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Exercise'),
      ),
      body: Column(
        children: [
          SizedBox(height: 20.0),
          Container(
            child: Text('New Exercise for ' + widget.focusedDay.replaceAll("00:00:00.000Z", ""), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
          ),
          SizedBox(height: 20.0),
          Container(
            child: Row(
              children: [
                Container(
                  child: Text('Exercise name: ')
                ),
                Expanded(
                  child: Container(
                    child: TextFormField(obscureText: false,
                    controller: nameController,
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
          Container(
            child: Row(
              children: [
                Container(
                  child: Text("Preset Exercises: ")
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
            child: Text("Excercise Sets")
          ),
          
          SizedBox(height: 8.0),
          ExpansionTile(
            title: Text("Set info"),
            children: <Widget> [
              TextFormField(obscureText: false,
                decoration:  InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '# reps',
                ),
              ),
              TextFormField(obscureText: false,
                decoration:  InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '# weight',
                ),
              ),
              TextFormField(obscureText: false,
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
              onPressed: (){
               // SizedBox(height: 8.0),
                child: Container(
              //  width: minSize,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return ExpansionTile(
                      title: Text("Set $index"),
                      children: <Widget> [
                        TextFormField(obscureText: false,
                          controller: textController,
                          decoration:  InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: '# reps',
                          ),
                        ),
                        TextFormField(obscureText: false,
                        controller: textController,
                          decoration:  InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: '# weight',
                          ),
                        ),
                        TextFormField(obscureText: false,
                        controller: textController,
                          decoration:  InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'notes:',
                          ),
                        ),
                      ]
                    );
                  },
                ),
              );
              },
              child: const Text("Add set"),
            )
          ),
          SizedBox(height: 8.0),
          Container(
            child: Row(
              children: [
                Text("Add to exercise presets "),
                Checkbox(
                  onChanged: null,
                  value: isChecked,
                )
              ],
            )
          ),
          SizedBox(height: 8.0),
          Container(
            child: TextFormField(obscureText: false,
              controller: notesController,
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
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    // Retrieve the text that the user has entered by using the
                    // TextEditingController.
                    content: Text(nameController.text),
                  );
                },
              );
            },
            child: Text("Add exercise")
            )
          )
        ],
      )
    );
  }

}

//class _writeExcercise 