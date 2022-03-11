import 'package:get/instance_manager.dart';
import 'package:psychotherapy_chatbot/controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
