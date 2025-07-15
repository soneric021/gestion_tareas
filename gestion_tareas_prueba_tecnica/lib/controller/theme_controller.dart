import 'package:gestion_tareas_prueba_tecnica/utils/constants.dart';
import 'package:hive/hive.dart';

class ThemeController {
  final _themeBox = Hive.box(Constants.THEME_MANAGER);

  bool getTheme(){
    return _themeBox.get("isDarkMode") == true;
  }

  Future<void> setTheme(bool isDarkMode) async {
    _themeBox.put("isDarkMode", isDarkMode);
  }

}