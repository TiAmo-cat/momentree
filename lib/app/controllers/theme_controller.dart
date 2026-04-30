import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../themes/app_theme_config.dart';

class ThemeController extends GetxController {
  static ThemeController get to => Get.find();

  final _themeId = Rxn<AppThemeId>();
  AppThemeId? get themeId => _themeId.value;
  AppThemeConfig? get theme => themeId != null ? allThemes[themeId] : null;

  @override
  void onInit() {
    super.onInit();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('themeId');
    if (raw != null) {
      _themeId.value = AppThemeId.values.firstWhereOrNull((e) => e.name == raw);
    }
  }

  Future<void> setTheme(AppThemeId id) async {
    _themeId.value = id;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeId', id.name);
  }
}

