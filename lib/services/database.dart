import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:psychotherapy_chatbot/models/community_post.dart';
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
      "date": journal.date as DateTime,
      "mood": journal.mood.toString(),
      "color": '#${journal.color!.value.toRadixString(16)}'
    }).catchError((e) {
      print(e.toString());
    });
  }

  deleteJournal(String uid, String journalId) {
    FirebaseFirestore.instance
        .collection("journals")
        .doc(uid)
        .collection("journalsList")
        .get()
        .then((value) => value.docs.forEach((doc) {
              if (doc.data()["id"] == journalId) {
                doc.reference.delete();
              }
            }))
        .catchError((e) {
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

  createPost(String uid) {
    FirebaseFirestore.instance.collection("posts").doc(uid).set({
      "uid": uid,
    }).catchError((e) {
      print(e.toString());
    });
  }

  uploadPost(CommunityPost post, String uid) {
    FirebaseFirestore.instance
        .collection("posts")
        .doc(uid)
        .collection("postsList")
        .add({
      "id": post.id,
      "title": post.title,
      "description": post.description,
      "date": post.date as DateTime,
      "author": post.author ?? "",
    }).catchError((e) {
      print(e.toString());
    });
  }

  uploadReadPosts(String postId, String uid) {
    FirebaseFirestore.instance
        .collection("posts")
        .doc(uid)
        .collection("readPostsList")
        .add({
      "id": postId,
    }).catchError((e) {
      print(e.toString());
    });
  }

  uploadHelpfulPosts(String postId, String uid) {
    FirebaseFirestore.instance
        .collection("posts")
        .doc(uid)
        .collection("helpfulPostsList")
        .add({
      "id": postId,
    }).catchError((e) {
      print(e.toString());
    });
  }

  Future<List<dynamic>> getHelpfulPostsList(String uid) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("posts")
        .doc(uid)
        .collection("helpfulPostsList")
        .get();

    List<dynamic> temp = querySnapshot.docs.map((doc) => doc.data()).toList();
    for (int i = 0; i < temp.length; i++) {
      temp[i] = temp[i]["id"].toString();
    }
    return temp;
  }

  Future<List<dynamic>> getReadPostsList(String uid) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("posts")
        .doc(uid)
        .collection("readPostsList")
        .get();

    List<dynamic> temp = querySnapshot.docs.map((doc) => doc.data()).toList();
    for (int i = 0; i < temp.length; i++) {
      temp[i] = temp[i]["id"].toString();
    }
    return temp;
  }

  // get all post of current user as list
  Future<List<CommunityPost>> getPostsList(String uid) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("posts")
        .doc(uid)
        .collection("postsList")
        .get();

    return querySnapshot.docs
        .map((doc) => CommunityPost.fromDocumentSnapshot(doc))
        .toList();
  }

  Future<List<CommunityPost>> getAllPosts() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("posts").get();

    List<dynamic> temp = querySnapshot.docs.map((doc) => doc.data()).toList();
    for (int i = 0; i < temp.length; i++) {
      temp[i] = temp[i]["uid"].toString();
    }

    // get all posts from getpostslist function using all uids returned from temp
    List<CommunityPost> posts = [];
    for (int i = 0; i < temp.length; i++) {
      posts.addAll(await getPostsList(temp[i]));
    }
    return posts;
  }

  // remove read post from readPostsList
  removeReadPost(String postId, String uid) {
    FirebaseFirestore.instance
        .collection("posts")
        .doc(uid)
        .collection("readPostsList")
        .get()
        .then((value) => value.docs.forEach((doc) {
              if (doc.data()["id"] == postId) {
                doc.reference.delete();
              }
            }))
        .catchError((e) {
      print(e.toString());
    });
  }

  // remove helpful post from helpfulPostsList
  removeHelpfulPost(String postId, String uid) {
    FirebaseFirestore.instance
        .collection("posts")
        .doc(uid)
        .collection("helpfulPostsList")
        .get()
        .then((value) => value.docs.forEach((doc) {
              if (doc.data()["id"] == postId) {
                doc.reference.delete();
              }
            }))
        .catchError((e) {
      print(e.toString());
    });
  }
}
