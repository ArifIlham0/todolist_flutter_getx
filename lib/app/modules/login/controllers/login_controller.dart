import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist_get_new/app/data/models/request/auth_req.dart';
import 'package:todolist_get_new/app/data/models/response/login_res.dart';
import 'package:todolist_get_new/app/data/services/auth_service.dart';
import 'package:todolist_get_new/app/modules/bottom_nav/bindings/bottom_nav_binding.dart';
import 'package:todolist_get_new/app/modules/bottom_nav/views/bottom_nav_view.dart';
import 'package:todolist_get_new/theme.dart';

class LoginController extends GetxController {
  final AuthService _authService = AuthService();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  var isLoading = false.obs;
  var authResponse = Rxn<LoginResponse>();
  var isAuthenticated = false.obs;
  var obscureText = true.obs;

  void toggleObscureText() {
    obscureText.value = !obscureText.value;
  }

  bool validateForm() {
    return formKey.currentState!.validate();
  }

  Future<void> login(AuthRequest model) async {
    try {
      isLoading(true);
      bool success = await _authService.login(model);
      if (success) {
        isAuthenticated(true);
        Get.offAll(
          () => const BottomNavView(),
          binding: BottomNavBinding(),
          transition: Transition.rightToLeft,
          duration: const Duration(milliseconds: 100),
        );
      }
    } catch (e) {
      isAuthenticated(false);
      Get.snackbar(
        "Login Failed",
        "Please check your username and password",
        colorText: kWhite,
        backgroundColor: kRed,
        icon: const Icon(Icons.add_alert, color: kWhite),
        duration: const Duration(milliseconds: 2000),
      );
      print("Login error: $e");
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
