 import 'package:gestion_tareas_prueba_tecnica/model/todo_model.dart';
import 'package:to_csv/to_csv.dart' as exportCSV;

class CsvExporter {
  static Future<void> exportTodoToCsv(List<TodoModel> todolist) async {
    List<String> headers = [];
    headers.add("id");
    headers.add("Titulo");
    headers.add("Descripcion");
    headers.add("Fecha limite");
    headers.add("Estado");
    
    List<List<String>> rows = [];
    for (var i = 0; i < todolist.length; i++) {
      rows.add([
        todolist[i].id?.toString() ?? "",
        todolist[i].title ?? "",
        todolist[i].description ?? "",
        todolist[i].limit ?? "",
        todolist[i].isCompleted ? "Completada" : "Pendiente"
      ]);
    }

    await exportCSV.myCSV(headers, rows, setHeadersInFirstRow: true);
  }
}