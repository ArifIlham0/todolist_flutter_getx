import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist_get_new/app/data/models/request/todo_req.dart';
import 'package:todolist_get_new/app/modules/todo_list/controllers/todo_list_controller.dart';
import 'package:todolist_get_new/app/utils/export.dart';
import 'package:todolist_get_new/app/widgets/export.dart';
import 'package:todolist_get_new/theme.dart';

class CompletedView extends GetView<TodoListController> {
  const CompletedView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBlack,
        centerTitle: true,
        title: Text(
          'Completed',
          style: textStyles(18, kWhite, FontWeight.normal),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Obx(
                () {
                  if (controller.isLoading.value) {
                    return const Center(child: LoadingIndicator());
                  } else if (controller.completeTodos.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 200.h),
                        child: Text(
                          'No Task',
                          style: textStyles(16, kWhite, FontWeight.normal),
                        ),
                      ),
                    );
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: controller.completeTodos.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final todo = controller.completeTodos[index];

                          return Obx(
                            () => TodoList(
                              todos: todo,
                              isSelected:
                                  controller.selectedTodos.contains(todo.id),
                              isCompleted: true,
                              onTap: () {
                                if (controller.isSelectionMode.value) {
                                  controller.onTodoLongPress(todo.id);
                                }
                              },
                              onLongPress: () {
                                controller.isSelectionMode(true);
                                controller.onTodoLongPress(todo.id);
                              },
                              onPressed: () {
                                controller.updateTodo(
                                  todo.id,
                                  TodoRequest(
                                    title: todo.title,
                                    description: todo.description,
                                    time: todo.time,
                                    completed: false,
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
          Obx(
            () {
              if (controller.isSelectionMode.value) {
                return Positioned(
                  bottom: 20.h,
                  left: 20.w,
                  child: FloatingActionButton(
                    onPressed: () {
                      showCustomDialog(
                        content: "Are you sure want to delete this todo?",
                        onConfirm: () {
                          controller.deleteSelectedTodos();
                          Get.back();
                        },
                      );
                    },
                    backgroundColor: kRed,
                    child: const Icon(Icons.delete, color: kWhite),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }
}
