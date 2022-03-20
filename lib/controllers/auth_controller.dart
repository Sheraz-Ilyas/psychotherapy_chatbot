import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psychotherapy_chatbot/models/user.dart';
import 'package:psychotherapy_chatbot/services/database.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var localUser = UserLocal().obs;

  final Rxn<User> _firebaseUser = Rxn<User>();
  User? get firebaseUser => _firebaseUser.value;

  DatabaseMethods databaseMethods = DatabaseMethods();

  @override
  void onInit() {
    _firebaseUser.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  void signUp(String email, String password, String name) async {
    try {
      UserCredential _authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      UserLocal _user = UserLocal(
        id: _authResult.user!.uid,
        name: name,
        email: email,
      );
      localUser.value = _user;
      databaseMethods.uploadUserInfo(_user);
      Get.back();
    } catch (e) {
      Get.snackbar(
        '',
        '',
        titleText: const Text(
          'Error Creating Account',
        ),
        messageText: Text(
          e.toString(),
        ),
        backgroundColor: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
  }

  void signIn(String email, String password) async {
    try {
      UserCredential _authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      localUser.value = await databaseMethods.getUser(_authResult.user!.uid);
      Get.back();
    } catch (e) {
      Get.snackbar(
        '',
        '',
        titleText: const Text(
          'Error Signing In',
        ),
        messageText: Text(
          e.toString(),
        ),
        backgroundColor: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
  }

  void signOut() async {
    try {
      _auth.signOut();
    } catch (e) {
      Get.snackbar(
        '',
        '',
        titleText: const Text(
          'Error Signing Out',
        ),
        messageText: Text(
          e.toString(),
        ),
        backgroundColor: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
  }
}
