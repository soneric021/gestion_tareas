import 'package:gestion_tareas_prueba_tecnica/model/todo_model.dart';
import 'package:hive/hive.dart';

class TodoController {
  final _todoManagerBox = Hive.box("todo_manager");

  Future<void> saveTodo(TodoModel todoModel) async {
    await _todoManagerBox.add(todoModel.toJson());
  }

  List<TodoModel> getTodos(){
      final data =  _todoManagerBox.keys.map((k)  {
        final item = _todoManagerBox.get(k);
        return TodoModel.fromJson(k,item);
      }).toList();
      return data;
  }

   Future<void> updateTodo(TodoModel todoModel) async {
    await _todoManagerBox.put(todoModel.id,todoModel.toJson());
  }
 Future<void> deleteTodo(dynamic id) async {
    await _todoManagerBox.delete(id);
  }
}
