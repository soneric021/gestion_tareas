import 'package:flutter/material.dart';
import 'package:gestion_tareas_prueba_tecnica/controller/theme_controller.dart';
import 'package:gestion_tareas_prueba_tecnica/utils/theme.dart';
import 'package:gestion_tareas_prueba_tecnica/utils/theme_notifier.dart';
import 'package:provider/provider.dart';

class ThemeSwitch extends StatefulWidget {
  @override
  _ThemeSwitchState createState() => _ThemeSwitchState();
}

class _ThemeSwitchState extends State<ThemeSwitch> {
  var _darkTheme = true;
  final themeController = ThemeController();

  void onThemeChanged(bool value, ThemeNotifier themeNotifier) async {
    (value)
        ? themeNotifier.setTheme(darkThemeCustom)
        : themeNotifier.setTheme(lightTheme);
    themeController.setTheme(value);
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    _darkTheme = (themeNotifier.getTheme() == darkThemeCustom);
    return Switch(
      activeColor: Theme.of(context).secondaryHeaderColor,
      onChanged: (value) {
        setState(() {
          _darkTheme = value;
        });
        onThemeChanged(value, themeNotifier);
      },
      value: _darkTheme,
    );
  }
}