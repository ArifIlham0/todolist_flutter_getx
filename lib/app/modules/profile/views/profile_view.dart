import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist_get_new/app/modules/export_controller.dart';
import 'package:todolist_get_new/app/modules/export_view.dart';
import 'package:todolist_get_new/app/modules/login/bindings/login_binding.dart';
import 'package:todolist_get_new/app/utils/export.dart';
import 'package:todolist_get_new/app/widgets/export.dart';
import 'package:todolist_get_new/theme.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final todoController = Get.find<TodoListController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBlack,
        centerTitle: true,
        title: Text(
          'Profile',
          style: textStyles(18, kWhite, FontWeight.normal),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            HeightSpacer(height: 20.h),
            Text(
              "Username",
              style: textStyles(25, kWhite, FontWeight.w800),
            ),
            HeightSpacer(height: 10.h),
            Obx(
              () => Text(
                controller.username.value,
                style: textStyles(25, kWhite, FontWeight.w800),
              ),
            ),
            HeightSpacer(height: 40.h),
            Obx(
              () {
                if (todoController.isLoading.value) {
                  return const Center(child: LoadingIndicator());
                } else {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 15.h),
                        decoration: BoxDecoration(
                          color: kGrey,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          "${todoController.todos.length} Task left",
                          style: textStyles(14, kWhite, FontWeight.normal),
                        ),
                      ),
                      WidthSpacer(width: 15.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 15.h),
                        decoration: BoxDecoration(
                          color: kGrey,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          "${todoController.completeTodos.length} Task done",
                          style: textStyles(14, kWhite, FontWeight.normal),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
            HeightSpacer(height: 250.h),
            InkWell(
              onTap: () {
                showCustomDialog(
                  content: "Are you sure want to logout?",
                  onConfirm: () async {
                    await UserPreferences().logout();
                    controller.logout();
                    Get.offAll(
                      () => const LoginView(),
                      binding: LoginBinding(),
                      transition: Transition.leftToRight,
                      duration: const Duration(milliseconds: 100),
                    );
                  },
                );
              },
              child: SizedBox(
                width: 160.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.exit_to_app,
                      color: kRed,
                      size: 30,
                    ),
                    WidthSpacer(width: 10.w),
                    Text(
                      "Logout",
                      style: textStyles(25, kRed, FontWeight.normal),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
