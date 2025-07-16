import 'package:gestion_tareas_prueba_tecnica/controller/todo_controller.dart';
import 'package:gestion_tareas_prueba_tecnica/model/todo_model.dart';
import 'package:gestion_tareas_prueba_tecnica/model/todo_state.dart';

class HomeController {
  final TodoController _todoController = TodoController();

  List<TodoModel> getTodos() {
    return _todoController.getTodos();
  }

  List<TodoModel> filterTodos(List<TodoModel> todos, TodoState? stateFilter) {
    return todos.where((i) {
      if (stateFilter == null) return true;
      return stateFilter == TodoState.Completadas ? i.isCompleted : !i
          .isCompleted;
    }).toList()
      ..sort((a, b) {
        if (a.isCompleted == b.isCompleted) return 0;
        return b.isCompleted ? -1 : 1;
      });
  }

  List<TodoModel> searchTodos(List<TodoModel> todos, String query) {
    return todos.where((t) =>
    t.title?.toLowerCase().contains(query.toLowerCase()) == true ||
        t.description?.toLowerCase().contains(query.toLowerCase()) == true
    ).toList()
      ..sort((a, b) {
        if (a.isCompleted == b.isCompleted) return 0;
        return b.isCompleted ? -1 : 1;
      });
  }

  void toggleTodoCompleted(TodoModel todo) {
    todo.updateIsCompleted();
    _todoController.updateTodo(todo);
  }

  void deleteTodo(int id) {
    _todoController.deleteTodo(id);
  }
}
