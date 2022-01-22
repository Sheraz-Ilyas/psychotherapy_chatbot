import 'package:flutter/cupertino.dart';

class BrainTraining {
  final int? id;
  final String? title;
  final String? description;
  final String? image;
  final IconData? category;
  final List<String>? steps;

  BrainTraining(
      {this.id,
      this.title,
      this.description,
      this.image,
      this.category,
      this.steps});
}
