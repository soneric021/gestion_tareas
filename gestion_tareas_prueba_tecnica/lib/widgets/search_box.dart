import 'package:flutter/material.dart';
import 'package:gestion_tareas_prueba_tecnica/utils/theme.dart';

class SearchBox extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const SearchBox({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<TodoColors>()!;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: theme.cardColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: TextStyle(color: colors.textPrimaryColor),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          prefixIcon: Icon(Icons.search, color: colors.textSecondaryColor, size: 20),
          prefixIconConstraints: const BoxConstraints(maxHeight: 20, minWidth: 25),
          border: InputBorder.none,
          hintText: "Buscar por título o descripción",
          hintStyle: TextStyle(color: colors.textSecondaryColor),
        ),
      ),
    );
  }
}
