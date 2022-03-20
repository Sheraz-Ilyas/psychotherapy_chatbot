import 'package:cloud_firestore/cloud_firestore.dart';

class UserLocal {
  String? id;
  String? name;
  String? email;

  UserLocal({
    this.id,
    this.name,
    this.email,
  });

  UserLocal.fromDocumentSnapshot(DocumentSnapshot doc) {
    id = doc['uid'];
    name = doc['name'];
    email = doc['email'];
  }
}
