import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gestion_tareas_prueba_tecnica/controller/todo_controller.dart';
import 'package:gestion_tareas_prueba_tecnica/model/todo_model.dart';
import 'package:gestion_tareas_prueba_tecnica/utils/theme.dart';
import 'package:gestion_tareas_prueba_tecnica/widgets/date_field_box.dart';
import 'package:gestion_tareas_prueba_tecnica/widgets/text_field_box.dart';
import 'package:gestion_tareas_prueba_tecnica/widgets/theme_switch.dart';
import 'package:intl/intl.dart';

class AddTodo extends StatefulWidget {
  final TodoModel? todoItem;
  const AddTodo({Key? key, this.todoItem}) : super(key: key);

  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final limitController = TextEditingController();
  final todoController = TodoController();
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final todoColors = theme.extension<TodoColors>()!;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        title: const Text("Gestor de tareas"),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          ThemeSwitch()
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: Text(
                      widget.todoItem == null ? "Agregar tarea" : "Editar tarea",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: todoColors.textPrimaryColor,
                      ),
                    ),
                  ),
                ),
                TextFieldBox(hint: "Ingresa un titulo", controller: titleController),
                  TextFieldBox(hint: "Ingresa una descripción (opcional)", controller: descriptionController),
            
                DateFieldBox(controller: limitController, onTap: _handleDateDialog,),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 50, right: 20, left: 20),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (widget.todoItem == null) {
                      saveTodo();
                    } else {
                      updateTodo();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(widget.todoItem == null ? "Agregar" : "Editar"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> saveTodo() async {
    if(titleController.text.isEmpty){
        Fluttertoast.showToast(
          msg: "Debes agregar un titulo.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0
      );
      return;
    }

    final todo = TodoModel(
      title: titleController.text,
      description: descriptionController.text,
      limit: limitController.text,
    );
    await todoController.saveTodo(todo);
    Navigator.of(context).pop();
  }

  Future<void> updateTodo() async {
    final todo = widget.todoItem;
    if (todo == null) return;
    todo.updateFields({
      "title": titleController.text,
      "description": descriptionController.text,
      "limit": limitController.text,
    });
    await todoController.updateTodo(todo);
    Navigator.of(context).pop();
  }

  Future<void> _handleDateDialog() async {
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
      currentDate: DateTime.now(),
      confirmText: "Ok",
      cancelText: "Cancelar",
    );
    if (pickedDate == null) return;
    setState(() {
      limitController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
    });
  }

  @override
  void initState() {
    titleController.text = widget.todoItem?.title ?? "";
    descriptionController.text = widget.todoItem?.description ?? "";
    limitController.text = widget.todoItem?.limit ?? "";
    super.initState();
  }
}
