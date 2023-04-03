import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../data/utils.dart';
import '../data/workout.dart';
import 'add_preset.dart';
import 'add_exercise.dart';
import 'analytics.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'dart:collection';

// Workout Calendar App
// Group 10

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  
  /*Future<String> readJson2() async {
    final String response = await rootBundle.loadString("assets/exercises.json");
    //final data = await json.decode(response);
   
    return response;
  }*/
  
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

/*Future<String> readJson3() async {
  final String response = await rootBundle.loadString("assets/exercises.json");
  print(response);
  return response;
}*/

class _MyHomePageState extends State<MyHomePage> {
  //Map <DateTime, List<Event>> exercises;
  final List<Event> workout_list = ExWorkouts.workout_list;
  String jsonString = "";
  
  
  
  /*Future<String> readJson4() async {
    final String response = await rootBundle.loadString("assets/exercises.json");
    //print(response);
    return response;
  }*/

  /*Future<void> readJson() async {
    final String response = await rootBundle.loadString("assets/exercises.json");
    final data = await json.decode(response);
    setState(() {
      jsonString = response;
    });*/

   /* @override
    Widget build(BuildContext context) {
    return DefaultTextStyle(
      
      child: FutureBuilder<String>(
        future: readJson4, // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
           
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          );
        },
      ),
    );
  }

  }*/

  bool initialStatus=false;
  // Calendar Variables
  //LinkedHashMap<DateTime, List<Event>> exercises = _getEventsForDay(_selectedDay);

  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  // Example data of a workout for now
  /*List<Workout> workoutList = [
    Workout.items(
      title: 'pushups',
      date: 'March 9th, 2023',
      sets:  [],
      reps: 0,
      weight: 0,
      addToPreset: false,
      notes: "gabagool",
    ),
  ];*/

  // Calendar Functions
  @override
  void initState() {
    //exercises = {};
    super.initState();


 //   LinkedHashMap<DateTime, List<Event>> exercises = createEvents(workout_list);

    //jsonString = readJson3() as String;
    /*setState(() {
      jsonString = data;
    });*/
    /*readJson4().then((String result){
    setState(() {
          jsonString = result;
        });
    });
    print(jsonString);*/
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  LinkedHashMap<DateTime, List<Event>> createEvents(List<Event> exercises) {
    LinkedHashMap<DateTime, List<Event>> events = LinkedHashMap<DateTime, List<Event>>();
    for (Event exercise in exercises) {
      //print(exercise.date);
      DateTime currDate = DateTime.parse(exercise.date);
      //print("currr");
      //print(currDate);
      if (events.containsKey(currDate)) {
        //print("in if cur date");
        events[currDate]?.add(exercise);
        //print(events[currDate] );
        //print("existing date");
        //print(events[currDate]?[0].title);
      } else {
       // print("in else");
        List<Event> newList = [exercise];
        events[currDate] = newList;
        //print("new date");
        //print(events[currDate]?[0].title);
      }
    };
    //print(events);
    return events;
  }
  
  List<Event> _getEventsForDay(DateTime day) {
   // LinkedHashMap<DateTime, List<Event>> exercises = createEvents(workout_list);

    // Implementation example
    //return kEvents[day] ?? [];
    //print("click");
   // print(exercises[day]);
    return exercises[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

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
            child: Text('\nFitter\nToday', textAlign: TextAlign.center,
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
        ],
      ),
      ),
      body: Column (
        children: [
          TableCalendar(
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            calendarFormat: _calendarFormat,
            rangeSelectionMode: _rangeSelectionMode,
            eventLoader: _getEventsForDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: CalendarStyle(
              // Use `CalendarStyle` to customize the UI
              outsideDaysVisible: false,
            ),
            onDaySelected: _onDaySelected,
            onRangeSelected: _onRangeSelected,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              focusedDay = focusedDay;
            },
          ), 
          const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        //onTap: () => print('${value[index]}'),
                        title: Text('${value[index]}'),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddExercise(focusedDay: _selectedDay.toString())),
                );
              },
              child: Text("Add exercise")
            )
          ), 
          SizedBox(height: 20.0),
        ], 
      ),
    );
  }
}

/*List<Event> _writeExcercise(String text) {
  print(text);
  if(text.isNotEmpty) {
    var exercises = jsonDecode(text)['exercises'] as List;
    var exerciseObjs = exercises.map((i) => Event.fromJson(i)).toList();
    print(exerciseObjs.toString());
    return exerciseObjs;
  } else {
    print("problemo 2");
    return List.empty();
  }
} */














//////////////////////////////////////////////////////////////////////////////////////////////////////////
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../data/utils.dart';
import '../data/workout.dart';
import 'add_preset.dart';
import 'add_exercise.dart';
import 'analytics.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'dart:collection';

// Workout Calendar App
// Group 10

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {
  //Map <DateTime, List<Event>> exercises;
  final List<Event> workout_list = ExWorkouts.workout_list;
  String jsonString = "";

  bool initialStatus=false;
  // Calendar Variables
  //LinkedHashMap<DateTime, List<Event>> exercises = _getEventsForDay(_selectedDay);

  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  late Map<DateTime, List<Event>> _events;

  // Calendar Functions
  @override
  void initState() {
    //exercises = {};
    super.initState();
    _events = LinkedHashMap(
      equals: isSameDay,
      hashCode: getHashCode,
    );

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    _loadEvents(workout_list);
  }

  _loadEvents(List<Event> exercises) async {
    //LinkedHashMap<DateTime, List<Event>> events = LinkedHashMap<DateTime, List<Event>>();
    _events = {};
   /*for (Event exercise in exercises) {
      //print(exercise.date);
      DateTime currDate = DateTime.parse(exercise.date);
      if (_events.containsKey(currDate)) {
        //print("in if cur date");
        _events[currDate]?.add(exercise);
        
      } else {
       // print("in else");
        List<Event> newList = [exercise];
        _events[currDate] = newList;
        
      }
    };*/
    for (Event exercise in exercises) {
      //final event = doc.data();
      final day = DateTime.parse(exercise.date);
      if (_events[day] == null) {
        _events[day] = [];
      }
      _events[day]!.add(exercise);
    }
    setState(() {});
    //print(events);
    //return _events;
  }

  LinkedHashMap<DateTime, List<Event>> createEvents(List<Event> exercises) {
    LinkedHashMap<DateTime, List<Event>> events = LinkedHashMap<DateTime, List<Event>>();
    for (Event exercise in exercises) {
      //print(exercise.date);
      DateTime currDate = DateTime.parse(exercise.date);
      if (events.containsKey(currDate)) {
        //print("in if cur date");
        events[currDate]?.add(exercise);
        
      } else {
       // print("in else");
        List<Event> newList = [exercise];
        events[currDate] = newList;
        
      }
    };
    //print(events);
    return events;
  }
  

  List<Event> _getEventsForDay(DateTime day) {
    //LinkedHashMap<DateTime, List<Event>> exercises = createEvents(workout_list);
    //return exercises[day] ?? [];
    return _events[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

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
            child: Text('\nFitter\nToday', textAlign: TextAlign.center,
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
        ],
      ),
      ),
      body: Column (
        children: [
          TableCalendar(
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            calendarFormat: _calendarFormat,
            rangeSelectionMode: _rangeSelectionMode,
            eventLoader: _getEventsForDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: CalendarStyle(
              // Use `CalendarStyle` to customize the UI
              outsideDaysVisible: false,
            ),
            onDaySelected: _onDaySelected,
            onRangeSelected: _onRangeSelected,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              focusedDay = focusedDay;
            },
          ), 
          const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        //onTap: () => print('${value[index]}'),
                        title: Text('${value[index]}'),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddExercise(focusedDay: _selectedDay.toString())),
                );
              },
              child: Text("Add exercise")
            )
          ), 
          SizedBox(height: 20.0),
        ], 
      ),
    );
  }
}

/*List<Event> _writeExcercise(String text) {
  print(text);
  if(text.isNotEmpty) {
    var exercises = jsonDecode(text)['exercises'] as List;
    var exerciseObjs = exercises.map((i) => Event.fromJson(i)).toList();
    print(exerciseObjs.toString());
    return exerciseObjs;
  } else {
    print("problemo 2");
    return List.empty();
  }
} */
/////////////////////////////////////////////////////////////////////////////4
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../data/utils.dart';
import '../data/workout.dart';
import 'add_preset.dart';
import 'add_exercise.dart';
import 'analytics.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'dart:collection';

// Workout Calendar App
// Group 10

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {
  //Map <DateTime, List<Event>> exercises;
  final List<Event> workout_list = ExWorkouts.workout_list;
  String jsonString = "";

  bool initialStatus=false;
  // Calendar Variables
  //LinkedHashMap<DateTime, List<Event>> exercises = _getEventsForDay(_selectedDay);

  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  late Map<DateTime, List<Event>> _events;

  // Calendar Functions
  @override
  void initState() {
    //exercises = {};
    super.initState();
    _events = LinkedHashMap(
      equals: isSameDay,
      hashCode: getHashCode,
    );

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }


  LinkedHashMap<DateTime, List<Event>> createEvents(List<Event> exercises) {
    LinkedHashMap<DateTime, List<Event>> events = LinkedHashMap<DateTime, List<Event>>();
    for (Event exercise in exercises) {
      //print(exercise.date);
      DateTime currDate = DateTime.parse(exercise.date);
      if (events.containsKey(currDate)) {
        //print("in if cur date");
        events[currDate]?.add(exercise);
        
      } else {
       // print("in else");
        List<Event> newList = [exercise];
        events[currDate] = newList;
        
      }
    };
    //print(events);
    return events;
  }
  

  List<Event> _getEventsForDay(DateTime day) {
    LinkedHashMap<DateTime, List<Event>> exercises = createEvents(workout_list);
    return exercises[day] ?? [];
    //return _events[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

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
            child: Text('\nFitter\nToday', textAlign: TextAlign.center,
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
        ],
      ),
      ),
      body: Column (
        children: [
          TableCalendar(
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            calendarFormat: _calendarFormat,
            rangeSelectionMode: _rangeSelectionMode,
            eventLoader: _getEventsForDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: CalendarStyle(
              // Use `CalendarStyle` to customize the UI
              outsideDaysVisible: false,
            ),
            onDaySelected: _onDaySelected,
            onRangeSelected: _onRangeSelected,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              focusedDay = focusedDay;
            },
          ), 
          const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        //onTap: () => print('${value[index]}'),
                        title: Text('${value[index]}'),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddExercise(focusedDay: _selectedDay.toString())),
                );
              },
              child: Text("Add exercise")
            )
          ), 
          SizedBox(height: 20.0),
        ], 
      ),
    );
  }
}

/*List<Event> _writeExcercise(String text) {
  print(text);
  if(text.isNotEmpty) {
    var exercises = jsonDecode(text)['exercises'] as List;
    var exerciseObjs = exercises.map((i) => Event.fromJson(i)).toList();
    print(exerciseObjs.toString());
    return exerciseObjs;
  } else {
    print("problemo 2");
    return List.empty();
  }
} */


////////////////////////////////////////////////////////////////////////////////
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../data/utils.dart';
import '../data/workout.dart';
import 'add_preset.dart';
import 'add_exercise.dart';
import 'analytics.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'dart:collection';

// Workout Calendar App
// Group 10

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {
  //Map <DateTime, List<Event>> exercises;
  final List<Event> workout_list = ExWorkouts.workout_list;
  String jsonString = "";

  bool initialStatus=false;
  // Calendar Variables
  //LinkedHashMap<DateTime, List<Event>> exercises = _getEventsForDay(_selectedDay);

  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  late Map<DateTime, List<Event>> _events;

  // Calendar Functions
  @override
  void initState() {
    //exercises = {};
    super.initState();
    _events = LinkedHashMap(
      equals: isSameDay,
      hashCode: getHashCode,
    );

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }


  LinkedHashMap<DateTime, List<Event>> createEvents(List<Event> exercises) {
    LinkedHashMap<DateTime, List<Event>> events = LinkedHashMap<DateTime, List<Event>>();
    for (Event exercise in exercises) {
      //print(exercise.date);
      DateTime currDate = DateTime.parse(exercise.date);
      if (events.containsKey(currDate)) {
        //print("in if cur date");
        events[currDate]?.add(exercise);
        
      } else {
       // print("in else");                                                                                                                            
        List<Event> newList = [exercise];
        events[currDate] = newList;
        
      }
    };
    //print(events);
    return events;
  }
  

  List<Event> _getEventsForDay(DateTime day) {
   // LinkedHashMap<DateTime, List<Event>> exercises = createEvents(workout_list);
    return _events[day] ?? [];
    //return _events[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

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
            child: Text('\nFitter\nToday', textAlign: TextAlign.center,
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
        ],
      ),
      ),
      body: Column (
        children: [
          TableCalendar(
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            calendarFormat: _calendarFormat,
            rangeSelectionMode: _rangeSelectionMode,
            eventLoader: _getEventsForDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: CalendarStyle(
              // Use `CalendarStyle` to customize the UI
              outsideDaysVisible: false,
            ),
            onDaySelected: _onDaySelected,
            onRangeSelected: _onRangeSelected,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              focusedDay = focusedDay;
            },
          ), 
          const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        //onTap: () => print('${value[index]}'),
                        title: Text('${value[index]}'),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddExercise(focusedDay: _selectedDay.toString())),
                );
              },
              child: Text("Add exercise")
            )
          ), 
          SizedBox(height: 20.0),
        ], 
      ),
    );
  }
}

/*List<Event> _writeExcercise(String text) {
  print(text);
  if(text.isNotEmpty) {
    var exercises = jsonDecode(text)['exercises'] as List;
    var exerciseObjs = exercises.map((i) => Event.fromJson(i)).toList();
    print(exerciseObjs.toString());
    return exerciseObjs;
  } else {
    print("problemo 2");
    return List.empty();
  }
} */
