import 'dart:ui';

enum Mood {
  HAPPY,
  SAD,
  ANGRY,
  SURPRISED,
  SCARED,
  NEUTRAL,
  CONFUSED,
  CRYING,
  UNKNOWN
}

class Journal {
  int id;
  String title;
  String description;
  DateTime date;
  Mood mood;
  Color color;

  Journal(
      {required this.id,
      required this.title,
      required this.description,
      required this.mood,
      required this.date,
      required this.color});
}
