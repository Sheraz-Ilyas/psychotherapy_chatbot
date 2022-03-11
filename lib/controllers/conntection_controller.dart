import 'package:get/state_manager.dart';

class ConnectionController extends GetxController {
  final RxBool _isConnected = RxBool(false);
  RxBool get isConnected => _isConnected;

  void setConnected(bool value) {
    _isConnected.value = value;
  }
}
