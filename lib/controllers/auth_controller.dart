import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Rxn<User> _firebaseUser = Rxn<User>();

  User? get firebaseUser => _firebaseUser.value;

  @override
  void onInit() {
    _firebaseUser.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  void signUp(String email, String password) async {
    try {
      _auth.createUserWithEmailAndPassword(email: email, password: password);
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
      _auth.signInWithEmailAndPassword(email: email, password: password);
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
