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
  String date;
  final String title;
  final List<Sets> sets;
  final bool addToPreset;
  final String notes;
  Event(
      {required this.title,
      required this.date,
      required this.sets,
      this.addToPreset = false,
      required this.notes});
}

class ExWorkouts {
  static List<Sets> set_list = <Sets>[
    Sets(reps: "5", weight: "10", notes: "hello"),
    Sets(reps: "15", weight: "5", notes: "hello2")
  ];

  // Example exercises inputted by user
  static List<Event> workout_list = [
    Event(
        title: "Seated leg press",
        date: "2023-03-20 20:18:04Z",
        sets: set_list,
        addToPreset: false,
        notes: "10 reps x 3 sets was perfect for progressive overload"),
    Event(
        title: "Bodyweight Lunges",
        date: "2023-04-02 20:18:04Z",
        sets: set_list,
        addToPreset: false,
        notes: ""),
    Event(
        title: "Bench Press",
        date: "2023-04-01 20:18:04Z",
        sets: set_list,
        addToPreset: false,
        notes: "new personal record!"),
    Event(
        title: "Box jumps",
        date: "2023-04-05 20:18:04Z",
        sets: set_list,
        addToPreset: false,
        notes: "john said this was good for leg day"),
    Event(
        title: "Plate thrusters",
        date: "2023-04-05 20:18:04Z",
        sets: set_list,
        addToPreset: false,
        notes: "add this to circut training"),
  ];

  // Example preset workouts
  static List<Event> preset_workouts = [
    Event(
        title: "preset1",
        date: "2023-04-05 20:18:04Z",
        sets: set_list,
        addToPreset: true,
        notes: "notes1"),
    Event(
        title: "preset2",
        date: "2023-04-02 20:18:04Z",
        sets: set_list,
        addToPreset: true,
        notes: "notes2"),
    Event(
        title: "preset3",
        date: "2023-04-01 20:18:04Z",
        sets: set_list,
        addToPreset: true,
        notes: "notes3"),
  ];
}
