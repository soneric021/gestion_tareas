import 'package:flutter/material.dart';
import 'package:gestion_tareas_prueba_tecnica/model/todo_model.dart';
import 'package:gestion_tareas_prueba_tecnica/widgets/todo_item.dart';

class TodoList extends StatelessWidget {
  final List<TodoModel> todos;
  final Function(TodoModel) onTodoClicked;
  final Function(TodoModel) onTodoDelete;
  final Function(TodoModel) onTodoEdit;

  const TodoList({
    super.key,
    required this.todos,
    required this.onTodoClicked,
    required this.onTodoDelete,
    required this.onTodoEdit,
  });

  @override
  Widget build(BuildContext context) {
    if (todos.isEmpty) {
      return const Expanded(
        child: Center(
          child: Text("No hay tareas para mostrar"),
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (_, index) => TodoItem(
          key: ValueKey(todos[index].id),
          todoModel: todos[index],
          onTodoClicked: onTodoClicked,
          onTodoDelete: onTodoDelete,
          onTodoEdit: onTodoEdit,
        ),
      ),
    );
  }
}
