import 'package:flutter/widgets.dart';

class Article {
  final int? id;
  final String? title;
  final String? author;
  final String? datePosted;
  final RichText? content;
  final String? image;
  final String? category;

  Article(
      {this.id,
      this.title,
      this.author,
      this.datePosted,
      this.content,
      this.image,
      this.category});
}
