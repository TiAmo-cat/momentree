import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class LocaleController extends GetxController {
  static LocaleController get to => Get.find();

  final _locale = const Locale('en').obs;
  Locale get locale => _locale.value;
  bool get isChinese => _locale.value.languageCode == 'zh';

  @override
  void onInit() {
    super.onInit();
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final lang = prefs.getString('locale') ?? 'en';
    _locale.value = Locale(lang);
    Get.updateLocale(Locale(lang));
  }

  Future<void> toggleLocale() async {
    final newLang = isChinese ? 'en' : 'zh';
    _locale.value = Locale(newLang);
    Get.updateLocale(Locale(newLang));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', newLang);
  }
}

