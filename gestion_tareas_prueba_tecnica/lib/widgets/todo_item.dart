import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gestion_tareas_prueba_tecnica/model/todo_model.dart';
import 'package:gestion_tareas_prueba_tecnica/utils/theme.dart';

class TodoItem extends StatelessWidget {
  final TodoModel todoModel;
  final Function(TodoModel) onTodoClicked;
  final Function(TodoModel) onTodoDelete;
  final Function(TodoModel) onTodoEdit;

  const TodoItem({
    Key? key,
    required this.todoModel,
    required this.onTodoClicked,
    required this.onTodoDelete,
    required this.onTodoEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final todoColors = theme.extension<TodoColors>()!;

    final tileColor = todoModel.isCompleted
        ? todoColors.taskCompletedColor
        : todoColors.taskActiveColor;

    return Container(
      margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
      child:  Slidable(
                   key:ValueKey(todoModel.id.toString()),
                 endActionPane:  ActionPane(motion: ScrollMotion(), children: [
 SlidableAction(
        onPressed: (context) {
            onTodoDelete(todoModel);
        },
        backgroundColor: todoColors.deleteIconColor,
        foregroundColor: Colors.white,
        icon: Icons.delete,
        label: 'Borrar',
      
      ),
      SlidableAction(
      
        onPressed: (context){
          onTodoEdit(todoModel);
        },
        backgroundColor: todoColors.editIconColor,
        foregroundColor: Colors.white,
        icon: Icons.edit,
        label: 'Editar',
        padding: EdgeInsets.all(0),
          borderRadius: const BorderRadius.only(topRight: Radius.circular(12), bottomRight: Radius.circular(12)),
      ),
                 ]),  
            child:  ListTile(
        tileColor: tileColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        onTap: () => onTodoClicked(todoModel),
        leading: Icon(
          todoModel.isCompleted
              ? Icons.check_box
              : Icons.check_box_outline_blank_outlined,
          color: todoColors.completeIconColor,
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                todoModel.title ?? "Sin título",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: todoColors.textPrimaryColor,
                  decoration: todoModel.isCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ),
            if (todoModel.limit != null && todoModel.limit!.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(left: 8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: todoColors.highPriorityColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  todoModel.limit!,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
        subtitle: (todoModel.description != null &&
                todoModel.description!.isNotEmpty)
            ? Text(
                todoModel.description!,
                style: TextStyle(
                  color: todoColors.textSecondaryColor,
                  decoration: todoModel.isCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              )
            : null,
      )
   
          ),
    );
  }
}
