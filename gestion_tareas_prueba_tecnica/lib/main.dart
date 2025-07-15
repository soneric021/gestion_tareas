import 'package:flutter/material.dart';
import 'package:gestion_tareas_prueba_tecnica/controller/theme_controller.dart';
import 'package:gestion_tareas_prueba_tecnica/model/todo_model.dart';
import 'package:gestion_tareas_prueba_tecnica/screens/home.dart';
import 'package:gestion_tareas_prueba_tecnica/utils/constants.dart';
import 'package:gestion_tareas_prueba_tecnica/utils/theme_notifier.dart';
import 'package:hive/hive.dart' show Hive;
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'utils/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await hiveConfig();
  runApp(ChangeNotifierProvider<ThemeNotifier>(create: (_) => ThemeNotifier(lightTheme), child: MainApp(),));
}

Future<void> hiveConfig() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TodoModelAdapter());
  await Hive.openBox(Constants.TODO_MANAGER);
  await Hive.openBox(Constants.THEME_MANAGER);
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final themeController = ThemeController();
    final isDarkMode = themeController.getTheme();
    toggleTheme(isDarkMode, themeNotifier);
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeNotifier.getTheme(),
      home: const Home()
    );
  }
  
  void toggleTheme(bool isDarkMode, ThemeNotifier themeNotifier) {
    if (isDarkMode) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
          themeNotifier.setTheme(darkThemeCustom);
        });
    }
  }
}
