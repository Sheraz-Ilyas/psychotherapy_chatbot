import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psychotherapy_chatbot/controllers/auth_controller.dart';
import 'package:psychotherapy_chatbot/views/authentication/body.dart';
import 'package:psychotherapy_chatbot/views/bottom_navigation/body.dart';
import 'package:psychotherapy_chatbot/views/landing_view.dart';

class Root extends GetWidget<AuthController> {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return (Get.find<AuthController>().firebaseUser != null)
          ? const NavBody()
          : const LandingView();
    });
  }
}
