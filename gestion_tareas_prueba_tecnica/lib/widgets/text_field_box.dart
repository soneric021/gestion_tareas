import 'package:flutter/material.dart';
import 'package:gestion_tareas_prueba_tecnica/utils/theme.dart';

class TextFieldBox extends StatelessWidget {
  final String hint;
  final TextEditingController controller;

  const TextFieldBox({
    Key? key,
    required this.hint,
    required this.controller,
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
        controller: controller,
        style: TextStyle(color: todoColors.textPrimaryColor),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 8),
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(color: todoColors.textSecondaryColor),
        ),
      ),
    );
  }
}
