import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist_get_new/app/data/models/request/auth_req.dart';
import 'package:todolist_get_new/app/data/services/auth_service.dart';
import 'package:todolist_get_new/app/modules/login/views/login_view.dart';
import 'package:todolist_get_new/theme.dart';

class RegisterController extends GetxController {
  final AuthService _authService = AuthService();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  var isLoading = false.obs;
  var obscureText = true.obs;

  void toggleObscureText() {
    obscureText.value = !obscureText.value;
  }

  bool validateForm() {
    return formKey.currentState!.validate();
  }

  Future<void> register(AuthRequest model) async {
    try {
      isLoading(true);
      bool success = await _authService.register(model);
      if (success) {
        Get.offAll(
          () => const LoginView(),
          transition: Transition.leftToRight,
          duration: const Duration(milliseconds: 100),
        );
      }
    } catch (e) {
      Get.snackbar(
        "Register Failed",
        "Username is not available",
        colorText: kWhite,
        backgroundColor: kRed,
        icon: const Icon(Icons.add_alert, color: kWhite),
        duration: const Duration(milliseconds: 2000),
      );
      print("Register error: $e");
    } finally {
      isLoading(false);
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
