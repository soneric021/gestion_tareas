import 'package:gestion_tareas_prueba_tecnica/controller/todo_controller.dart';
import 'package:gestion_tareas_prueba_tecnica/model/todo_model.dart';

class AddTodoController {
  final TodoController _todoController = TodoController();

  bool validateTitle(String title) {
    return title.isNotEmpty;
  }

  Future<void> saveTodo(String title, String description, String limit) async {
    final todo = TodoModel(
        title: title, description: description, limit: limit);
    await _todoController.saveTodo(todo);
  }

  Future<void> updateTodo(TodoModel todo, String title, String description,
      String limit) async {
    todo.updateFields(
        {"title": title, "description": description, "limit": limit});
    await _todoController.updateTodo(todo);
  }
}
