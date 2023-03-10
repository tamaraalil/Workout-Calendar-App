import 'package:flutter/material.dart';

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
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Workout Calendar'),
    );
  }
}

class Workout {
  Workout.items({this.date = "", this.title = "", this.sets = const[], this.reps = 0, 
  this.weight = 0, this.addToPreset = false, this.notes = ""});
  final String date;
  final String title;
  final List sets;
  final int reps;
  final int weight;
  final bool addToPreset;
  final String notes;
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool initialStatus=false;
  List<Workout> workoutList = [
    Workout.items(
      title: 'pushups',
      date: 'March 9th, 2023',
      sets:  [],
      reps: 0,
      weight: 0,
      addToPreset: false,
      notes: "gabagool",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('\nWorkout\nCalendar', textAlign: TextAlign.center,
              style: TextStyle (fontWeight: FontWeight.w700, fontSize: 30.0, color: Colors.white),),
          ),
          ListTile(
            leading: Icon(Icons.calendar_month, color: Colors.black, size: 20.0,),
            title: const Text('Calendar'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.add_circle_outline, color: Colors.black, size: 20.0,),
            title: const Text('Add Preset Workout'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PresetWorkout()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.assessment_outlined, color: Colors.black, size: 20.0,),
            title: const Text('Analytics'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Analytics()),
              );
            },
          ),
        ],
      ),
      ),
      body: ListView.builder(
          //gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), 
          itemCount: workoutList.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PresetWorkout()),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Stack(
                  alignment: FractionalOffset.bottomCenter,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xff1b1b1c), //#0xff7c94b6
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    Container( // workout name
                      height: 90.0,
                      width: 20.0,
                      //padding: const EdgeInsets.all(10.0),
                      alignment: Alignment.center,
                      child: Row (
                        children: <Widget> [
                          Text(workoutList[index].title, 
                            style: TextStyle (fontWeight: FontWeight.w700, fontSize: 20.0, color: Colors.black),),
                        ],
                      ),
                    ),
                 ],
                ),
              ),
            );
          },),      
    );
  }
}


// -------------------- ADD PRESET WORKOUT PAGE ---------------------

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

// -------------------- ANALYTICS PAGE ---------------------

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
