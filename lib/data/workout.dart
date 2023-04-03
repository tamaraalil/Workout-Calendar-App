// Workout Class
// To store data of a workout

class Sets {
 // Sets.items({this.reps = "", this.weight = "", this.notes = ""});
  final String reps;
  final String weight;
  final String notes;
  Sets({required this.reps, required this.weight, required this.notes});
}

 class Event {
 // Workout.items({this.date, this.title, this.sets = const [], this.addToPreset = false, this.notes = ""});
  final String date;
  final String title;
  final List<Sets> sets;
  final bool addToPreset;
  final String notes;
  Event({
    required this.title,
    required this.date,
    required this.sets, 
    this.addToPreset = false,
    required this.notes
    }
    );
}

class ExWorkouts {
  static List <Sets> set_list = <Sets>  [
        Sets(
          reps:"5",
          weight: "10",
          notes:"hello"
        ),
        Sets(
          reps:"15",
          weight: "5",
          notes:"hello2"
        )
  ];

  static List<Event> workout_list =[
    Event(
        title : "bicep curls",
        date : "2023-03-20 20:18:04Z",
        sets : set_list,
        addToPreset : false,
        notes : "this was really fun! feel the burn bitch YEEEEEEEEEEAH"
    ),
    Event(
        title : "test",
        date : "2023-04-02 20:18:04Z",
        sets : set_list,
        addToPreset : false,
        notes : "this was really fun! feel the burn bitch YEEEEEEEEEEAH"
    ),
    Event(
        title : "test2",
        date : "2023-04-01 20:18:04Z",
        sets : set_list,
        addToPreset : false,
        notes : "this was really fun! feel the burn bitch YEEEEEEEEEEAH"
    ),
    Event(
        title : "test3",
        date : "2023-04-05 20:18:04Z",
        sets : set_list,
        addToPreset : false,
        notes : "this was really fun! feel the burn bitch YEEEEEEEEEEAH"
    ),
    Event(
        title : "samedatetest",
        date : "2023-04-05 20:18:04Z",
        sets : set_list,
        addToPreset : false,
        notes : "this was really fun! feel the burn bitch YEEEEEEEEEEAH"
    ),
  ];
}





 
