import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist_get_new/app/widgets/export.dart';
import 'package:todolist_get_new/theme.dart';
import '../controllers/todo_list_controller.dart';

class TodoListView extends GetView<TodoListController> {
  const TodoListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBlack,
        centerTitle: true,
        title: Text(
          'Task',
          style: textStyles(18, kWhite, FontWeight.normal),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: 400.h,
                child: Obx(
                  () {
                    if (controller.isLoading.value) {
                      return const Center(child: LoadingIndicator());
                    } else if (controller.todos.isEmpty) {
                      return Center(
                        child: Text(
                          'No Task',
                          style: textStyles(16, kWhite, FontWeight.normal),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: controller.todos.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final todo = controller.todos[index];

                          return Obx(
                            () => TodoList(
                              todos: todo,
                              isSelected:
                                  controller.selectedTodos.contains(todo.id),
                              onTap: () => controller.onTodoTap(
                                todo,
                                controller.title,
                                controller.description,
                                controller.formattedDateTime,
                                context,
                              ),
                              onLongPress: () =>
                                  controller.onTodoLongPress(todo.id),
                              onPressed: () =>
                                  controller.markTodoCompleted(todo),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                      decoration: BoxDecoration(
                        color: kGrey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        "Overdue",
                        style: textStyles(14, kWhite, FontWeight.normal),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(
                () {
                  if (controller.isLoading.value) {
                    return const Center(child: LoadingIndicator());
                  } else if (controller.overdueTodos.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 45.h),
                        child: Text(
                          'No Task',
                          style: textStyles(16, kWhite, FontWeight.normal),
                        ),
                      ),
                    );
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: controller.overdueTodos.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final todo = controller.overdueTodos[index];
                          return Obx(
                            () => TodoListOverdue(
                              todos: todo,
                              isSelected:
                                  controller.selectedTodos.contains(todo.id),
                              onTap: () => controller.onTodoLongPress(todo.id),
                              onLongPress: () =>
                                  controller.onTodoLongPress(todo.id),
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
          Obx(() {
            if (controller.isSelectionMode.value) {
              return Positioned(
                bottom: 20.h,
                left: 20.w,
                child: FloatingActionButton(
                  onPressed: controller.confirmDeleteSelectedTodos,
                  backgroundColor: kRed,
                  child: const Icon(Icons.delete, color: kWhite),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
          Positioned(
            bottom: 20.h,
            right: 20.w,
            child: FloatingActionButton(
              onPressed: () => controller.openAddTodoModal(
                context,
                controller.title,
                controller.description,
              ),
              backgroundColor: kPurple,
              child: const Icon(Icons.add, color: kWhite),
            ),
          ),
        ],
      ),
    );
  }
}
