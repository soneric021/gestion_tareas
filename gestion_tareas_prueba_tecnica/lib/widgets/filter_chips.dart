import 'package:flutter/material.dart';
import 'package:gestion_tareas_prueba_tecnica/model/todo_state.dart';
import 'package:gestion_tareas_prueba_tecnica/utils/theme.dart';

class FilterChips extends StatelessWidget {
  final TodoState? selectedState;
  final Function(TodoState?) onSelected;

  const FilterChips({
    super.key,
    required this.selectedState,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<TodoColors>()!;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Wrap(
        spacing: 8,
        children: TodoState.values.map((state) {
          final isSelected = state == selectedState;
          return FilterChip(
            label: Text(
              state.name,
              style: TextStyle(color: isSelected ? Colors.white : colors.textPrimaryColor),
            ),
            selected: isSelected,
            onSelected: (_) => onSelected(isSelected ? null : state),
            selectedColor: theme.primaryColor,
            backgroundColor: theme.cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: colors.borderColor),
            ),
          );
        }).toList(),
      ),
    );
  }
}
