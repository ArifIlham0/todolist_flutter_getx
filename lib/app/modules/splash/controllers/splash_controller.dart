import 'package:get/get.dart';
import 'package:todolist_get_new/app/data/services/auth_service.dart';
import 'package:todolist_get_new/app/modules/bottom_nav/bindings/bottom_nav_binding.dart';
import 'package:todolist_get_new/app/modules/bottom_nav/views/bottom_nav_view.dart';
import 'package:todolist_get_new/app/modules/login/bindings/login_binding.dart';
import 'package:todolist_get_new/app/modules/login/views/login_view.dart';
import 'package:todolist_get_new/app/utils/export.dart';

class SplashController extends GetxController {
  AuthService authService = AuthService();
  UserPreferences userPreferences = UserPreferences();

  @override
  void onInit() {
    super.onInit();
    navigateToNextScreen();
  }

  Future<void> navigateToNextScreen() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    bool isSuccessful = await fetchMe();

    if (isSuccessful) {
      Get.offAll(
        () => const BottomNavView(),
        binding: BottomNavBinding(),
        transition: Transition.rightToLeft,
        duration: const Duration(milliseconds: 100),
      );
    } else {
      await userPreferences.logout();
      Get.offAll(
        () => const LoginView(),
        binding: LoginBinding(),
        transition: Transition.rightToLeft,
        duration: const Duration(milliseconds: 100),
      );
    }
  }

  Future<bool> fetchMe() async {
    print("Masuk ga");
    String? username = await userPreferences.getUsername();
    return await authService.me(username ?? "username");
  }
}
