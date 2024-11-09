import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist_get_new/app/modules/export_view.dart';

class BottomNavController extends GetxController {
  var selectedIndex = 0.obs;

  final List<Widget> _pages = [
    const TodoListView(),
    const CompletedView(),
    const ProfileView(),
  ];

  List<Widget> get pages => _pages;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
