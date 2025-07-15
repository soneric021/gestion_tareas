import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color(0xFFF5F5F5), // Fondo general
  primaryColor: Colors.purple, // Color principal (botones, fab)
  cardColor: Colors.white, // Tarjetas activas
  iconTheme: IconThemeData(color: Colors.grey[700]),

  // Colores personalizados
  extensions: <ThemeExtension<dynamic>>[
    TodoColors(
      taskCompletedColor: Color(0xFFE0E0E0),
      taskActiveColor: Colors.white,
      deleteIconColor: Colors.redAccent,
      completeIconColor: Colors.green,
      editIconColor: Colors.blue,
      highPriorityColor: Colors.orange,
      borderColor: Colors.black12,
      textPrimaryColor: Colors.black87,
      textSecondaryColor: Colors.black54,
    )
  ],

  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black87),
    bodyMedium: TextStyle(color: Colors.black54),
  ),
);

final darkThemeCustom = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF121212), // Fondo general
  primaryColor: Colors.purpleAccent,
  cardColor: const Color(0xFF1E1E1E), // Tarjetas activas
  iconTheme: IconThemeData(color: Colors.grey[300]),

  extensions: <ThemeExtension<dynamic>>[
    TodoColors(
      taskCompletedColor: Color(0xFF2A2A2A),
      taskActiveColor: Color(0xFF1E1E1E),
      deleteIconColor: Colors.redAccent.shade100,
      completeIconColor: Colors.greenAccent.shade200,
      editIconColor: Colors.blue.shade200,
      highPriorityColor: Colors.orangeAccent,
      borderColor: Colors.white10,
      textPrimaryColor: Colors.white,
      textSecondaryColor: Colors.white70,
    )
  ],

  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white70),
  ),
);

/// Custom ThemeExtension to hold extra color values
@immutable
class TodoColors extends ThemeExtension<TodoColors> {
  final Color taskCompletedColor;
  final Color taskActiveColor;
  final Color deleteIconColor;
  final Color completeIconColor;
  final Color editIconColor;
  final Color highPriorityColor;
  final Color borderColor;
  final Color textPrimaryColor;
  final Color textSecondaryColor;

  const TodoColors({
    required this.taskCompletedColor,
    required this.taskActiveColor,
    required this.deleteIconColor,
    required this.completeIconColor,
    required this.editIconColor,
    required this.highPriorityColor,
    required this.borderColor,
    required this.textPrimaryColor,
    required this.textSecondaryColor,
  });

  @override
  TodoColors copyWith({
    Color? taskCompletedColor,
    Color? taskActiveColor,
    Color? deleteIconColor,
    Color? completeIconColor,
    Color? editIconColor,
    Color? highPriorityColor,
    Color? borderColor,
    Color? textPrimaryColor,
    Color? textSecondaryColor,
  }) {
    return TodoColors(
      taskCompletedColor: taskCompletedColor ?? this.taskCompletedColor,
      taskActiveColor: taskActiveColor ?? this.taskActiveColor,
      deleteIconColor: deleteIconColor ?? this.deleteIconColor,
      completeIconColor: completeIconColor ?? this.completeIconColor,
      editIconColor: editIconColor ?? this.editIconColor,
      highPriorityColor: highPriorityColor ?? this.highPriorityColor,
      borderColor: borderColor ?? this.borderColor,
      textPrimaryColor: textPrimaryColor ?? this.textPrimaryColor,
      textSecondaryColor: textSecondaryColor ?? this.textSecondaryColor,
    );
  }

  @override
  TodoColors lerp(ThemeExtension<TodoColors>? other, double t) {
    if (other is! TodoColors) return this;
    return TodoColors(
      taskCompletedColor: Color.lerp(taskCompletedColor, other.taskCompletedColor, t)!,
      taskActiveColor: Color.lerp(taskActiveColor, other.taskActiveColor, t)!,
      deleteIconColor: Color.lerp(deleteIconColor, other.deleteIconColor, t)!,
      completeIconColor: Color.lerp(completeIconColor, other.completeIconColor, t)!,
      editIconColor: Color.lerp(editIconColor, other.editIconColor, t)!,
      highPriorityColor: Color.lerp(highPriorityColor, other.highPriorityColor, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      textPrimaryColor: Color.lerp(textPrimaryColor, other.textPrimaryColor, t)!,
      textSecondaryColor: Color.lerp(textSecondaryColor, other.textSecondaryColor, t)!,
    );
  }
}
