import 'package:flutter/material.dart';
import 'package:milestone2/pages/view_presets.dart';
import 'package:table_calendar/table_calendar.dart';
import '../data/utils.dart';
import '../data/workout.dart';
import 'add_preset.dart';
import 'add_exercise.dart';
import 'view_presets.dart';
import 'dart:collection';

// Workout Calendar App
// Group 10

final List<Event> workout_list = ExWorkouts.workout_list;
Map<String, List<Event>> _preset_workouts = <String, List<Event>>{};
List<String> saved_presets = <String>[];
late Map<DateTime, List<Event>> _events;

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    this.event,
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  final Event? event;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  final List<Event> workout_list = ExWorkouts.workout_list;
  final List<Event> presetdummy = ExWorkouts.preset_workouts;
  String jsonString = "";
  bool initialStatus = false;
  Event? selectedValue;
  String? selectedPreset;

  // Calendar Variables
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff; // Can
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  late Map<DateTime, List<Event>> _events;

  // Calendar Functions
  @override
  void initState() {
    super.initState();
    var eventList = createEvents(workout_list);
    _events = LinkedHashMap(
      equals: isSameDay,
      hashCode: getHashCode,
    );
    _events.addAll(eventList);
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  LinkedHashMap<DateTime, List<Event>> createEvents(List<Event> exercises) {
    LinkedHashMap<DateTime, List<Event>> events =
        LinkedHashMap<DateTime, List<Event>>();
    for (Event exercise in exercises) {
      DateTime currDate = DateTime.parse(exercise.date);
      if (events.containsKey(currDate)) {
        events[currDate]?.add(exercise);
      } else {
        List<Event> newList = [exercise];
        events[currDate] = newList;
      }
    };
    return events;
  }

  List<Event> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
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
        _rangeStart = null;
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
        backgroundColor: Colors.deepPurple,
        title: Text(widget.title),
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
              onTap: () {},
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
                      builder: (context) => PresetWorkout()),
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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ViewPresets(presetWorkouts: _preset_workouts)),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
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
                        child: ExpansionTile(
                            title: Text('${value[index].title}'),
                            subtitle: Text('${value[index].notes}'),
                            children: _createSets(value[index])));
                  },
                );
              },
            ),
          ),

          // ADD EXERCISE / ADD PRESET WORKOUT BUTTONS

          Row (
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            Container(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AddExercise(focusedDay: _selectedDay.toString(), presets: saved_presets)
                      ),
                    );
                    setState(() {});
                  },
                  child: Text("Add Exercise"))
                ),
              Container(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                  onPressed: () async { 
                    await openDialog().then((_) => this.setState(() {}));
                  },
                  child: Text("Add Preset Workout"))
              ),
          ],),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }

Future openDialog() => showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Which preset workout would you like to add?'),
      content: Container(
        child: DropdownButtonFormField<String>(
            value: selectedPreset,
            hint: Text('Choose'),
            onChanged: (String? newValue){
              setState(() {
                selectedPreset = newValue;
              });
            },
            onSaved: (String? newValue){
              setState(() {
                selectedPreset = newValue;
              });
            },
            items: saved_presets.map<DropdownMenuItem<String>>(
                (newValue) => DropdownMenuItem(
                  value: newValue,
                  child: Text(newValue),
                ),
              ).toList(),
            )
          ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            var toAdd = [];
            var list = _preset_workouts[selectedPreset];
            for (var e in list!) {
              e.date = _selectedDay.toString();
              toAdd.add(e);
            }
            for (Event ex in toAdd) {
              addEvent(ex);
            }
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyHomePage(
                      title: "Workout Calendar")),
            );
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );

  
}

addEvent(Event event){
  workout_list.add(event);
}

addPreset(Event event, String name){
  _preset_workouts[name]?.add(event);
}

deletePreset(String name) {
  _preset_workouts[name]?.remove(name);
}

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

createPreset(List<Event> exercises, String name) {
    if (_preset_workouts.containsKey(name)) {
      // TODO could add a warning here for if the preset already exists
      _preset_workouts[name]?.addAll(exercises);
    } else {
      _preset_workouts[name] = exercises;
    }
    saved_presets.add(name);
  }

  _changeDates(List<Event> exercises, DateTime day) {
    for (Event value in exercises) {
      value.date = day.toString();
    }
  }
