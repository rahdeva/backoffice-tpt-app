import 'package:get/get.dart';
import '/feature/auth/auth_controller.dart';
import '/model/user.dart';

class ProfileController extends GetxController {
  final AuthController authController = AuthController.find;

  User? get user => authController.user;

  Future<void> signOut() async {
    await authController.signOut();
  }
}
