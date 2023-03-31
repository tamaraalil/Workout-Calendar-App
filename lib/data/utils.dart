import 'dart:collection';
import 'package:table_calendar/table_calendar.dart';
import 'dart:convert';
 /*
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
  factory 
}*/

/// Example event class.
class Event {
  final String title;

  /*final DateTime date;
  final bool addToPreset;
  final String notes;
  final List<Sets> sets;*/

  //const Event(this.title, this.date, this.addToPreset, this.notes, this.sets);
  const Event(this.title);

  @override
  String toString() => title;
/*
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
    var setsObjsJson = json['sets' as List];
    List<Sets> _sets = setsObjsJson.map((setJson) => Sets.fromJson(setJson)).toList();
  }*/
}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

var exercises = [];



final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
    key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
    value: (item) => List.generate(
        item % 4 + 1, (index) => Event('Event $item | ${index + 1}')))
  ..addAll({
    kToday: [
      Event('Today\'s Push'),
      Event('Today\'s Abs and core'),
    ],
  });

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