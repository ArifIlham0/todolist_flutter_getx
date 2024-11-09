import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist_get_new/app/data/models/request/delete_todo_req.dart';
import 'package:todolist_get_new/app/data/models/request/todo_req.dart';
import 'package:todolist_get_new/app/data/models/response/todo_res.dart';
import 'package:todolist_get_new/app/data/services/todo_service.dart';
import 'package:todolist_get_new/app/utils/export.dart';
import 'package:todolist_get_new/app/widgets/export.dart';

class TodoListController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();
  String formattedDateTime = DateTime.now().toUtc().toIso8601String();
  var todos = <Datum>[].obs;
  var overdueTodos = <Datum>[].obs;
  var completeTodos = <Datum>[].obs;
  var selectedTodos = <String>[].obs;
  var isSelectionMode = false.obs;

  var isLoading = true.obs;

  final TodoService _todoService = TodoService();

  @override
  void onInit() {
    super.onInit();
    fetchTodos();
  }

  bool validateForm() {
    return formKey.currentState!.validate();
  }

  void markTodoCompleted(Datum todo) {
    updateTodo(
      todo.id,
      TodoRequest(
        title: todo.title,
        description: todo.description,
        time: todo.time,
        completed: true,
      ),
    );
    fetchTodos(showLoading: false);
  }

  void confirmDeleteSelectedTodos() {
    showCustomDialog(
      content: "Are you sure want to delete this todo?",
      onConfirm: () {
        deleteSelectedTodos();
        Get.back();
      },
    );
  }

  Future<String?> selectDateTime(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (selectedTime != null) {
        final DateTime finalDateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );
        return finalDateTime.toUtc().toIso8601String();
      }
    }
    return null;
  }

  void deleteSelectedTodos() async {
    if (selectedTodos.isNotEmpty) {
      DeleteTodoRequest deleteRequest =
          DeleteTodoRequest(ids: selectedTodos.toList());

      await deleteTodo(deleteRequest);

      selectedTodos.clear();
      isSelectionMode(false);
      fetchTodos(showLoading: false);
    }
  }

  void fetchTodos({bool showLoading = true}) async {
    if (showLoading) {
      isLoading(true);
    }
    try {
      var fetchedTodos = await _todoService.fetchTodos();
      var fetchedOverdue = await _todoService.fetchOverdueTodos();
      var fetchedComplete = await _todoService.fetchCompleteTodos();
      todos.assignAll(fetchedTodos.data);
      overdueTodos.assignAll(fetchedOverdue.data);
      completeTodos.assignAll(fetchedComplete.data);
    } finally {
      if (showLoading) {
        isLoading(false);
      }
    }
  }

  void addTodo(TodoRequest model) async {
    await _todoService.createTodo(model);
    fetchTodos(showLoading: false);
  }

  void updateTodo(String id, TodoRequest model) async {
    await _todoService.updateTodo(id, model);
    todos.indexWhere((element) => element.id == id);
    fetchTodos(showLoading: false);
  }

  Future<void> deleteTodo(DeleteTodoRequest deleteRequest) async {
    await _todoService.deleteTodo(deleteRequest);
    todos.removeWhere((todo) => deleteRequest.ids!.contains(todo.id));
    fetchTodos(showLoading: false);
  }

  void onTodoTap(
      Datum todo,
      TextEditingController title,
      TextEditingController description,
      String formattedDateTime,
      BuildContext context) {
    if (isSelectionMode.value) {
      onTodoLongPress(todo.id);
    } else {
      title.text = todo.title;
      description.text = todo.description;
      modalBottomSheet(
        context: context,
        title: title,
        description: description,
        formKey: formKey,
        onDismiss: () =>
            clearControllers(title, description, formattedDateTime),
        onPressed: () async {
          String? dateTime = await selectDateTime(context);
          if (dateTime != null) {
            formattedDateTime = dateTime;
          }
        },
        onPressed2: () {
          if (validateForm()) {
            updateTodo(
              todo.id,
              TodoRequest(
                title: title.text,
                description: description.text,
                time: DateTime.parse(formattedDateTime),
                completed: false,
              ),
            );
            clearControllers(title, description, formattedDateTime);
            Get.back();
          }
        },
      );
    }
  }

  void onTodoLongPress(String todoId) {
    if (selectedTodos.contains(todoId)) {
      selectedTodos.remove(todoId);
      if (selectedTodos.isEmpty) {
        isSelectionMode(false);
      }
    } else {
      selectedTodos.add(todoId);
      isSelectionMode(true);
    }
  }

  void openAddTodoModal(BuildContext context, TextEditingController title,
      TextEditingController description) {
    modalBottomSheet(
      context: context,
      title: title,
      description: description,
      formKey: formKey,
      onDismiss: () => clearControllers(
          title, description, DateTime.now().toUtc().toIso8601String()),
      onPressed: () async {
        String? dateTime = await selectDateTime(context);
        if (dateTime != null) {
          formattedDateTime = dateTime;
        }
      },
      onPressed2: () {
        if (validateForm()) {
          addTodo(
            TodoRequest(
              title: title.text,
              description: description.text,
              time: DateTime.parse(formattedDateTime),
              completed: false,
            ),
          );
          clearControllers(title, description, formattedDateTime);
          Get.back();
        }
      },
    );
  }

  void clearControllers(TextEditingController title,
      TextEditingController description, String formattedDateTime) {
    title.clear();
    description.clear();
    formattedDateTime = DateTime.now().toUtc().toIso8601String();
  }
}
