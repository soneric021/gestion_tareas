import 'package:flutter/material.dart';
import 'package:gestion_tareas_prueba_tecnica/utils/theme.dart';

class DateFieldBox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onTap;

  const DateFieldBox({
    Key? key,
    required this.controller,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final todoColors = theme.extension<TodoColors>()!;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: theme.cardColor,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: TextField(
        readOnly: true,
        controller: controller,
        onTap: onTap,
        style: TextStyle(color: todoColors.textPrimaryColor),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 8),
          hintText: "Selecciona una fecha límite (opcional)",
          hintStyle: TextStyle(color: todoColors.textSecondaryColor),
          prefixIcon: Icon(Icons.date_range, color: todoColors.textSecondaryColor),
          suffixIcon: Icon(Icons.arrow_right, color: todoColors.textSecondaryColor),
          prefixIconConstraints: const BoxConstraints(maxHeight: 20, minWidth: 25),
          suffixIconConstraints: const BoxConstraints(maxHeight: 20, minWidth: 25),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
