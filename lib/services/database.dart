import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
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
}
