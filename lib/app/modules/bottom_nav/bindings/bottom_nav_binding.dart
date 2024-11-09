import 'package:get/get.dart';
import 'package:todolist_get_new/app/modules/completed/bindings/completed_binding.dart';
import 'package:todolist_get_new/app/modules/profile/bindings/profile_binding.dart';
import 'package:todolist_get_new/app/modules/todo_list/bindings/todo_list_binding.dart';
import '../controllers/bottom_nav_controller.dart';

class BottomNavBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomNavController>(
      () => BottomNavController(),
    );
    TodoListBinding().dependencies();
    CompletedBinding().dependencies();
    ProfileBinding().dependencies();
  }
}
