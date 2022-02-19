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
  String? id;
  String? title;
  String? description;
  DateTime? date;
  Mood? mood;
  Color? color;

  Journal({
    this.id,
    this.title,
    this.description,
    this.date,
    this.mood,
    this.color,
  });
}
