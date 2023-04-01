import 'dart:collection';
import 'package:table_calendar/table_calendar.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
 
class Sets {
  final String reps;
  final String weight;
  final String notes;
  const Sets(this.weight, this.reps, this.notes);

  Map toJson() => {
    'reps': reps,
    'weight': weight,
    'notes': notes,
  };
  
  factory Sets.fromJson(dynamic json) {
    return Sets(
      json['weight'] as String,
      json['reps'] as String,
      json['notes'] as String
    );
  }
}

/// Example event class.
class Event {
  final String title;

  final String date;
  final bool addToPreset;
  final String notes;
  final List<Sets> sets;

  const Event(this.title, this.date, this.notes, this.sets, this.addToPreset);
  //const Event(this.title);


  @override
  String toString() => title;

  Map toJson() {
    List<Map> sets =
      this.sets.map((i) => i.toJson()).toList();
    return {
      'title': title,
      'date': date.toString(),
      'notes': notes,
      'sets': sets,
      'addToPreset': addToPreset
    };
  }
  factory Event.fromJson(dynamic json) {
    var setsObjsJson = json['sets'] as List;
    List<Sets> _sets = setsObjsJson.map((setJson) => Sets.fromJson(setJson)).toList();

    return Event(
      json['title'] as String,
      json['date'] as String,
      json['notes'] as String,
      _sets,
      json['addToPreset'] as bool,
    );
  }
}
String jsonString = "";

Future<void> readJson() async {
  final String response = await rootBundle.loadString("assets/exercises.json");
  final data = await json.decode(response);
    jsonString = response;
}
/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);


List<Event> exercises = _writeExcercise(jsonString);

//var exercises = jsonDecode(text)['exercises'] as List;
//final _kEventSource = _writeExcercise()

/*final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
    key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
    value: (item) => List.generate(
        item % 4 + 1, (index) => Event('Event $item | ${index + 1}')))
  ..addAll({
    kToday: [
      Event('Today\'s Push'),
      Event('Today\'s Abs and core'),
    ],
  });*/
// List.generate(
     //  item % 4 + 1, (index) => exercises[index]));

final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
    key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
    value: (item) => List.generate(
        item % 4 + 1, (index) => exercises[index]));
  /*..addAll({
    /*kToday: [
      Event('Today\'s Push'),
      Event('Today\'s Abs and core'),
    ],*/
  });*/

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

List<Event> _writeExcercise(String text) {
  print(text);
  if(text.isNotEmpty) {
    var exercises = jsonDecode(text)['exercises'] as List;
    List<Event> exerciseObjs = exercises.map((i) => Event.fromJson(i)).toList();
    print(exerciseObjs.toString());
    return exerciseObjs;
  } else {
    print("problemo");
    return List.empty();
  }
} 