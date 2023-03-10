// Workout Class
// To store data of a workout

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