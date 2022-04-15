import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:psychotherapy_chatbot/models/journal.dart';
import 'package:psychotherapy_chatbot/models/user.dart';

class DatabaseMethods extends GetxController {
  Future<UserLocal> getUser(String uid) async {
    try {
      DocumentSnapshot doc =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();
      return UserLocal.fromDocumentSnapshot(doc);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  uploadUserInfo(UserLocal user) {
    FirebaseFirestore.instance.collection("users").doc(user.id).set({
      "uid": user.id,
      "name": user.name,
      "email": user.email,
    }).catchError((e) {
      print(e.toString());
    });
  }

  createChat(String conversationId, conversationMap) {
    FirebaseFirestore.instance
        .collection("chats")
        .doc(conversationId)
        .set(conversationMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  addConversationMessages(String converstaionId, messageMap) {
    FirebaseFirestore.instance
        .collection("chats")
        .doc(converstaionId)
        .collection("messages")
        .add(messageMap)
        .catchError((e) => print(e.toString()));
  }

  getConversationMessages(String converstaionId) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("chats")
        .doc(converstaionId)
        .collection("messages")
        .get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  createJournal(String uid) {
    FirebaseFirestore.instance.collection("journals").doc(uid).set({
      "uid": uid,
    }).catchError((e) {
      print(e.toString());
    });
  }

  uploadJournal(Journal journal, String uid) {
    FirebaseFirestore.instance
        .collection("journals")
        .doc(uid)
        .collection("journalsList")
        .add({
      "id": journal.id,
      "title": journal.title,
      "description": journal.description,
      "date": journal.date.toString(),
      "mood": journal.mood.toString(),
      "color": journal.color.toString(),
    }).catchError((e) {
      print(e.toString());
    });
  }

  updateJournal(Journal journal, String uid) {
    FirebaseFirestore.instance
        .collection("journals")
        .doc(uid)
        .collection("journalsList")
        .doc(journal.id)
        .update({
      "title": journal.title,
      "description": journal.description,
      "date": journal.date,
      "mood": journal.mood,
      "color": journal.color,
    }).catchError((e) {
      print(e.toString());
    });
  }

  // get all journal as list
  Future<List<Journal>> getJournalList(String uid) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("journals")
        .doc(uid)
        .collection("journalsList")
        .get();

    return querySnapshot.docs
        .map((doc) => Journal.fromDocumentSnapshot(doc))
        .toList();
  }
}
