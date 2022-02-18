import 'package:flutter/material.dart';
import 'package:psychotherapy_chatbot/models/journal.dart';

List<Journal> journalData = [
  Journal(
      id: 1,
      title: 'Journal 1',
      description: 'Description 1',
      date: DateTime.now(),
      mood: Mood.HAPPY,
      color: Colors.red),
  Journal(
      id: 2,
      title: 'Journal 2',
      description: 'Description 2',
      date: DateTime.now(),
      mood: Mood.SAD,
      color: Colors.indigo),
  Journal(
      id: 3,
      title: 'Journal 3',
      description: 'Description 3',
      date: DateTime.now(),
      mood: Mood.NEUTRAL,
      color: Colors.green),
  Journal(
      id: 4,
      title: 'Journal 4',
      description: 'Description 4',
      date: DateTime.now(),
      mood: Mood.ANGRY,
      color: Colors.orange),
  Journal(
      id: 5,
      title: 'Journal 5',
      description: 'Description 5',
      date: DateTime.now(),
      mood: Mood.SCARED,
      color: Colors.blue),
];
