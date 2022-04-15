import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';

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

  Journal.fromDocumentSnapshot(DocumentSnapshot doc) {
    id = doc['id'];
    title = doc['title'];
    description = doc['description'];
    date = DateTime.fromMillisecondsSinceEpoch(doc['date']);
    mood = Mood.values[doc['mood']];
    color = Color(doc['color']);
  }
}
