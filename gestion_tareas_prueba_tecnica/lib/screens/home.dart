import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gestion_tareas_prueba_tecnica/controller/home_controller.dart';
import 'package:gestion_tareas_prueba_tecnica/controller/todo_controller.dart';
import 'package:gestion_tareas_prueba_tecnica/model/todo_model.dart';
import 'package:gestion_tareas_prueba_tecnica/model/todo_state.dart';
import 'package:gestion_tareas_prueba_tecnica/screens/add_todo.dart';
import 'package:gestion_tareas_prueba_tecnica/utils/csv_exporter.dart';
import 'package:gestion_tareas_prueba_tecnica/utils/theme.dart';
import 'package:gestion_tareas_prueba_tecnica/widgets/filter_chips.dart';
import 'package:gestion_tareas_prueba_tecnica/widgets/search_box.dart';
import 'package:gestion_tareas_prueba_tecnica/widgets/theme_switch.dart';
import 'package:gestion_tareas_prueba_tecnica/widgets/todo_list.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoController = TodoController();
  final homeController = HomeController();
   
  List<TodoModel> todoList = List.empty();
  List<TodoModel> todoListFiltered = List.empty();
  TodoState? stateFilter;
  TextEditingController searchController = TextEditingController();
  
 @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        title: const Text("Gestor de tareas"),
        elevation: 0,
        actions: [
          IconButton(onPressed: _handleExportCsv, icon: Icon(Icons.file_download)),
          ThemeSwitch()

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const AddTodo()))
              .then((_) {
            reloadList();
          });
        },
        backgroundColor: theme.primaryColor,
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
         SearchBox(controller: searchController, onChanged: _handleSearchFilter),
         FilterChips(selectedState: stateFilter, onSelected: (s){
              setState(() {
                  stateFilter = s;
                  reloadListFilter();
                });
         }),
         TodoList(todos: todoListFiltered, onTodoClicked: _handleTodoClicked, onTodoDelete: _handleTodoDelete, onTodoEdit: _handleTodoEdit)

        ],
      ),
    );
  }

  @override
  void initState() {
    reloadList();
    super.initState();
  }

  void reloadList() {
    setState(() {
      todoList = homeController.getTodos();
    });
    reloadListFilter();
  }

  void reloadListFilter() {
    setState(() {
      todoListFiltered = homeController.filterTodos(todoList, stateFilter);
    });
  }
    void _handleTodoClicked(TodoModel todoModel) {
      homeController.toggleTodoCompleted(todoModel);
    reloadList();
  }

  void _handleSearchFilter(String value) {
    setState(() {
      todoListFiltered = homeController.searchTodos(todoList, value);
    });
  }

  void _handleTodoEdit(TodoModel todoModel) {
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (context) => AddTodo(todoItem: todoModel)))
        .then((_) {
      reloadList();
    });
  }

  void _handleTodoDelete(TodoModel todoModel) {
    final theme = Theme.of(context);
    final todoColors = theme.extension<TodoColors>()!;
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: theme.cardColor,
        title: Text("Advertencia",
            style: TextStyle(color: todoColors.textPrimaryColor)),
        content: Text("¿Estás seguro que quieres eliminar esta tarea?",
            style: TextStyle(color: todoColors.textSecondaryColor)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'Cancel');
            },
            child: Text("Cancelar",
                style: TextStyle(color: todoColors.deleteIconColor)),
          ),
          TextButton(
            onPressed: () {
              homeController.deleteTodo(todoModel.id ?? 0);
              Navigator.pop(context, 'Ok');
              reloadList();
            },
            child: Text("Ok", style: TextStyle(color: theme.primaryColor)),
          )
        ],
      ),
    );
  }

  Future<void> _handleExportCsv() async {
    if (todoList.isEmpty) {
       Fluttertoast.showToast(
          msg: "Debes tener al menos una tarea para generar csv.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0
      );
      return;
    }

    await CsvExporter.exportTodoToCsv(todoList);
  }

}
