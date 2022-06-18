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
  EXCITED
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
    date = (doc['date'] as Timestamp).toDate();
    mood = Mood.values.firstWhere((e) => e.toString() == doc['mood']);
    color = getColorFromHex(doc['color']);
  }

  Color? getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }

    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }

    return null;
  }
}
