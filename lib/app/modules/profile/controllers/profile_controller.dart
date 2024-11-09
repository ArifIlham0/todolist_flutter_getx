import 'package:get/get.dart';
import 'package:todolist_get_new/app/utils/export.dart';

class ProfileController extends GetxController {
  var username = ''.obs;
  var isAuthenticated = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadPreferences();
  }

  void loadPreferences() async {
    var fetchedUsername = await UserPreferences().getUsername() ?? '';
    username.value = fetchedUsername;
  }

  void logout() async {
    isAuthenticated(false);
    await UserPreferences().logout();
  }
}
