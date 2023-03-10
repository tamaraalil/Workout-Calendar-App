import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'data/utils.dart';
import 'data/workout.dart';
import 'pages/add_preset.dart';
import 'pages/analytics.dart';

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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  bool initialStatus=false;
  // Calendar Variables
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Example data of a workout for now
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
            decoration: BoxDecoration( // Drawer title
              color: Colors.blue,
            ),
            child: Text('\nWorkout\nCalendar', textAlign: TextAlign.center,
              style: TextStyle (fontWeight: FontWeight.w700, fontSize: 30.0, color: Colors.white),),
          ),
          ListTile( // Drawer option to calendar page
            leading: Icon(Icons.calendar_month, color: Colors.black, size: 20.0,),
            title: const Text('Calendar'),
            onTap: () {}, // fix this???? mayhaps?
          ),
          ListTile( // Drawer option to add preset workout page
            leading: Icon(Icons.add_circle_outline, color: Colors.black, size: 20.0,),
            title: const Text('Add Preset Workout'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PresetWorkout()),
              );
            },
          ),
          ListTile( // Drawer option to analytics page
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
      body: TableCalendar(
        firstDay: kFirstDay,
        lastDay: kLastDay,
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) {
          // Use `selectedDayPredicate` to determine which day is currently selected.
          // If this returns true, then `day` will be marked as selected.

          // Using `isSameDay` is recommended to disregard
          // the time-part of compared DateTime objects.
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(_selectedDay, selectedDay)) {
            // Call `setState()` when updating the selected day
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          }
        },
        onFormatChanged: (format) {
          if (_calendarFormat != format) {
            // Call `setState()` when updating calendar format
            setState(() {
              _calendarFormat = format;
            });
          }
        },
        onPageChanged: (focusedDay) {
          // No need to call `setState()` here
          _focusedDay = focusedDay;
        },
      ),  
    );
  }
}

