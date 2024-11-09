import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:todolist_get_new/app/modules/export_controller.dart';

void main() {
  setUpAll(() {
    Get.testMode = true;
  });

  group("login controller", () {
    late LoginController loginController;
    setUp(() {
      loginController = Get.put(LoginController());
    });
    test("isloading first value should be false", () {
      expect(loginController.isLoading.value, false);
    });
    test("obscuretext first value should be true", () {
      expect(loginController.obscureText.value, true);
    });
    test("toggleobscuretext should change obscuretext value", () {
      loginController.toggleObscureText();
      expect(loginController.obscureText.value, false);
      loginController.toggleObscureText();
      expect(loginController.obscureText.value, true);
    });
  });
}
