import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app/controllers/theme_controller.dart';
import 'app/controllers/locale_controller.dart';
import 'app/controllers/home_controller.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'l10n/app_localizations.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  Get.put(ThemeController());
  Get.put(LocaleController());
  Get.put(HomeController());
  await Future.delayed(const Duration(milliseconds: 150));
  runApp(const MomentumApp());
}
class MomentumApp extends StatelessWidget {
  const MomentumApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final lc = Get.find<LocaleController>();
      final tc = Get.find<ThemeController>();
      final themeData = tc.theme?.toMaterialTheme() ?? ThemeData.dark();
      return GetMaterialApp(
        title: 'Momentum',
        debugShowCheckedModeBanner: false,
        theme: themeData,
        locale: lc.locale,
        fallbackLocale: const Locale('en'),
        supportedLocales: const [Locale('en'), Locale('zh')],
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        initialRoute: tc.themeId == null ? AppRoutes.select : AppRoutes.home,
        getPages: AppPages.pages,
        defaultTransition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 300),
      );
    });
  }
}
