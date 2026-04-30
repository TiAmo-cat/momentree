import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_record.dart';
import '../services/storage_service.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  final momentum = 0.obs;
  final streak = 0.obs;
  final isWithered = false.obs;
  final checkedInToday = false.obs;
  final freeRecoveryUsedDate = ''.obs;
  final cravingResists = 0.obs;
  final relapseCount = 0.obs;
  final totalDays = 0.obs;
  final lastCheckInDate = ''.obs;

  String get todayStr =>
      DateTime.now().toIso8601String().split('T')[0];

  bool get canFreeRecover => freeRecoveryUsedDate.value != todayStr;

  int get treeStage {
    final m = momentum.value;
    if (m >= 100) return 3;
    if (m >= 50) return 2;
    if (m >= 20) return 1;
    return 0;
  }

  @override
  void onInit() {
    super.onInit();
    _loadState();
  }

  Future<void> _loadState() async {
    final prefs = await SharedPreferences.getInstance();
    momentum.value = prefs.getInt('momentum') ?? 0;
    streak.value = prefs.getInt('streak') ?? 0;
    isWithered.value = prefs.getBool('isWithered') ?? false;
    freeRecoveryUsedDate.value = prefs.getString('freeRecoveryUsedDate') ?? '';
    cravingResists.value = prefs.getInt('cravingResists') ?? 0;
    relapseCount.value = prefs.getInt('relapseCount') ?? 0;
    totalDays.value = prefs.getInt('totalDays') ?? 0;
    lastCheckInDate.value = prefs.getString('lastCheckInDate') ?? '';

    // Reset checkedInToday if it's a new day
    checkedInToday.value = lastCheckInDate.value == todayStr
        ? (prefs.getBool('checkedInToday') ?? false)
        : false;
  }

  Future<void> _saveState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('momentum', momentum.value);
    await prefs.setInt('streak', streak.value);
    await prefs.setBool('isWithered', isWithered.value);
    await prefs.setString('freeRecoveryUsedDate', freeRecoveryUsedDate.value);
    await prefs.setInt('cravingResists', cravingResists.value);
    await prefs.setInt('relapseCount', relapseCount.value);
    await prefs.setInt('totalDays', totalDays.value);
    await prefs.setString('lastCheckInDate', lastCheckInDate.value);
    await prefs.setBool('checkedInToday', checkedInToday.value);
  }

  /// 每日打卡成功 +10 pts（每3天连击加3分）
  Future<int> checkInSuccess() async {
    final newStreak = streak.value + 1;
    int delta = 10;
    if (newStreak % 3 == 0) delta += 3;
    momentum.value += delta;
    streak.value = newStreak;
    isWithered.value = false;
    checkedInToday.value = true;
    totalDays.value += 1;
    lastCheckInDate.value = todayStr;
    await _saveState();
    await StorageService.insertRecord(AppRecord(
      date: todayStr,
      streak: streak.value,
      momentum: momentum.value,
      success: true,
    ));
    return delta;
  }

  /// 破戒打卡：-15 pts，连续清零，树枯萎
  Future<void> checkInRelapse() async {
    momentum.value = (momentum.value - 15).clamp(0, 9999);
    streak.value = 0;
    isWithered.value = true;
    checkedInToday.value = true;
    lastCheckInDate.value = todayStr;
    relapseCount.value += 1;
    await _saveState();
    await StorageService.insertRecord(AppRecord(
      date: todayStr,
      streak: 0,
      momentum: momentum.value,
      success: false,
    ));
  }

  /// 抵制冲动成功：+5 pts
  Future<void> cravingResist() async {
    momentum.value += 5;
    cravingResists.value += 1;
    await _saveState();
  }

  /// 冲动失败：-15 pts，连续清零，树枯萎
  Future<void> cravingYield() async {
    momentum.value = (momentum.value - 15).clamp(0, 9999);
    streak.value = 0;
    isWithered.value = true;
    relapseCount.value += 1;
    await _saveState();
  }

  /// 免费复活树木：恢复 +5 pts（今日只能用一次）
  Future<int> freeRecover() async {
    const bonus = 5;
    isWithered.value = false;
    momentum.value += bonus;
    freeRecoveryUsedDate.value = todayStr;
    await _saveState();
    return bonus;
  }

  /// 看广告复活树木：恢复 +10 pts（感谢支持）
  Future<int> adRecover() async {
    const bonus = 10;
    isWithered.value = false;
    momentum.value += bonus;
    await _saveState();
    return bonus;
  }
}
