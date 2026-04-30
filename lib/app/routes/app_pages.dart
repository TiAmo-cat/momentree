import 'package:get/get.dart';
import 'package:momentree/app/controllers/home_controller.dart';
import 'package:momentree/app/controllers/theme_controller.dart';
import 'package:momentree/app/controllers/craving_controller.dart';
import 'package:momentree/app/pages/home/home_page.dart';
import 'package:momentree/app/pages/style_selector/style_selector_page.dart';
import 'package:momentree/app/pages/craving/craving_page.dart';
import 'package:momentree/app/pages/result/result_page.dart';
import 'package:momentree/app/pages/settings/settings_page.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.home,
      page: () {
        final tc = Get.find<ThemeController>();
        if (tc.themeId == null) {
          return const StyleSelectorPage();
        }
        return const HomePage();
      },
      binding: BindingsBuilder(() {
        Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
      }),
    ),
    GetPage(
      name: AppRoutes.select,
      page: () => const StyleSelectorPage(),
    ),
    GetPage(
      name: AppRoutes.craving,
      page: () => const CravingPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<CravingController>(() => CravingController(), fenix: true);
      }),
    ),
    GetPage(
      name: AppRoutes.result,
      page: () => const ResultPage(),
    ),
    GetPage(
      name: AppRoutes.settings,
      page: () => const SettingsPage(),
    ),
  ];
}






