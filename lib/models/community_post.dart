import 'package:cloud_firestore/cloud_firestore.dart';

class CommunityPost {
  late final String? id;
  late final String? title;
  late final String? description;
  late final DateTime? date;
  late final String? author;

  CommunityPost(
      {this.id, this.title, this.description, this.date, this.author});

  CommunityPost.fromDocumentSnapshot(DocumentSnapshot doc) {
    id = doc['id'];
    title = doc['title'];
    description = doc['description'];
    date = (doc['date'] as Timestamp).toDate();
    author = doc['author'];
  }
}
