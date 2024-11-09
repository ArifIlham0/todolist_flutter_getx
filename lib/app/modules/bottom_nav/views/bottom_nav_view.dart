import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist_get_new/theme.dart';
import 'package:todolist_get_new/app/widgets/export.dart';
import '../controllers/bottom_nav_controller.dart';

class BottomNavView extends GetView<BottomNavController> {
  const BottomNavView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(
          () => IndexedStack(
            index: controller.selectedIndex.value,
            children: controller.pages,
          ),
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            backgroundColor: kGrey,
            items: [
              BottomNavigationBarItem(
                icon: controller.selectedIndex.value != 0
                    ? const Icon(Icons.task_outlined)
                    : const Icon(Icons.task_rounded),
                label: 'Task',
              ),
              BottomNavigationBarItem(
                icon: controller.selectedIndex.value != 1
                    ? const Icon(Icons.check_circle_outlined)
                    : const Icon(Icons.check_circle),
                label: 'Completed',
              ),
              BottomNavigationBarItem(
                icon: controller.selectedIndex.value != 2
                    ? const Icon(Icons.person_pin_outlined)
                    : const Icon(Icons.person_pin_rounded),
                label: 'Profile',
              ),
            ],
            currentIndex: controller.selectedIndex.value,
            onTap: controller.changeIndex,
            selectedItemColor: kWhite,
            iconSize: 30.w,
          ),
        ),
      ),
    );
  }
}
