import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/theme_controller.dart';
import '../../routes/app_routes.dart';
import '../../themes/app_theme_config.dart';
import '../../widgets/themed_widgets.dart';
import '../../../l10n/app_localizations.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnim;
  bool _confettiFired = false;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();
    _scaleAnim =
        CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut);
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final args = Get.arguments as Map<String, dynamic>? ?? {'type': 'success'};
    final type = args['type'] as String? ?? 'success';
    final streakBonus = args['streakBonus'] as bool? ?? false;

    final tc = Get.find<ThemeController>();
    final theme = tc.theme;
    if (theme == null) return const SizedBox.shrink();

    final hc = Get.find<HomeController>();
    final t = theme;
    final isVoltage = t.isVoltage;
    final isForest = t.isForest;

    final cfg = _getConfig(type, streakBonus, isVoltage, hc, l);
    final isPositive = cfg['positive'] as bool;
    final accentColor = isPositive ? t.accentGreen : t.accentDanger;

    return PageBackground(
      theme: t,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            // Background glow
            Positioned.fill(
              child: IgnorePointer(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: const Alignment(0, -0.3),
                      radius: 0.7,
                      colors: [
                        accentColor.withOpacity(0.13),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Emoji
                      ScaleTransition(
                        scale: _scaleAnim,
                        child: Text(
                          cfg['emoji'] as String,
                          style: const TextStyle(fontSize: 80, color: Colors.white, inherit: false),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Delta badge
                      AnimatedOpacity(
                        opacity: 1.0,
                        duration: const Duration(milliseconds: 300),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 28, vertical: 8),
                          decoration: BoxDecoration(
                            color: isPositive ? t.successBg : t.dangerBg,
                            borderRadius: BorderRadius.circular(99),
                            border:
                                Border.all(color: accentColor.withOpacity(0.2)),
                          ),
                          child: Text(
                            streakBonus ? '+13' : cfg['delta'] as String,
                            style: TextStyle(
                              color: isPositive ? t.successText : t.dangerText,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      // Title
                      Text(
                        cfg['title'] as String,
                        style: TextStyle(
                          color: t.textPrimary,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: isVoltage ? 1.0 : 0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      // Subtitle
                      Text(
                        cfg['subtitle'] as String,
                        style: TextStyle(
                          color: t.textMuted,
                          fontSize: 14,
                          height: 1.6,
                          fontStyle: isForest && !isVoltage
                              ? FontStyle.italic
                              : FontStyle.normal,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      // Stats card
                      Obx(() => ThemedCard(
                            theme: t,
                            padding: const EdgeInsets.symmetric(
                                vertical: 18, horizontal: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _statItem(t, l.momentum, '${hc.momentum.value}',
                                    t.accentAmber, isVoltage),
                                _statItem(t, l.streak, '${hc.streak.value}d',
                                    t.streakColor, isVoltage),
                                _statItem(
                                  t,
                                  l.stage,
                                  ['🌱', '🌿', '🌳', '🌲'][hc.treeStage],
                                  t.accentGreen,
                                  isVoltage,
                                ),
                              ],
                            ),
                          )),
                      // Streak bonus
                      if (streakBonus) ...[
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 18),
                          decoration: BoxDecoration(
                            color: t.accentAmber.withOpacity(0.13),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                                color: t.accentAmber.withOpacity(0.25)),
                          ),
                          child: Text(
                            '🔥 ${isVoltage ? 'STREAK BONUS UNLOCKED ⚡ EVERY 3 DAYS: +3 PTS' : l.streakBonusMsg}',
                            style:
                                TextStyle(color: t.accentAmber, fontSize: 13),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                      // Recovery prompt
                      if ((type == 'relapse' || type == 'craving_yield'))
                        Obx(() {
                          if (!hc.isWithered.value)
                            return const SizedBox.shrink();
                          return Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 14, horizontal: 18),
                              decoration: BoxDecoration(
                                color: t.dangerBg,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                    color: t.accentDanger.withOpacity(0.2)),
                              ),
                              child: Text(
                                hc.canFreeRecover
                                    ? l.freeRecoveryAvailable
                                    : l.watchAdRecover,
                                style: TextStyle(
                                    color: t.dangerText, fontSize: 13),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }),
                      const SizedBox(height: 24),
                      // Back button
                      GradientButton(
                        colors: t.btnPrimaryColors,
                        textColor: t.btnPrimaryText,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        onTap: () => Get.offAllNamed(AppRoutes.home),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.arrow_back,
                                color: t.btnPrimaryText,
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              isVoltage ? 'BACK TO BASE' : l.backToHome,
                              style: TextStyle(
                                color: t.btnPrimaryText,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                letterSpacing: isVoltage ? 1.0 : 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Map<String, dynamic> _getConfig(String type, bool streakBonus, bool isVoltage,
      HomeController hc, AppLocalizations l) {
    switch (type) {
      case 'success':
        return {
          'emoji': '🌱',
          'title': isVoltage
              ? (streakBonus ? 'STREAK BONUS! +13 PTS' : 'CHECKED IN! +10 PTS')
              : (streakBonus
                  ? l.resultSuccessTitleBonus
                  : l.resultSuccessTitle),
          'subtitle': isVoltage
              ? 'CURRENT STREAK: ${hc.streak.value} DAYS'
              : l.resultSuccessSubtitle(hc.streak.value),
          'delta': '+10',
          'positive': true,
        };
      case 'relapse':
        return {
          'emoji': '🍂',
          'title': isVoltage ? 'SETBACK ⚡ -15 PTS' : l.resultRelapseTitle,
          'subtitle': isVoltage
              ? 'STREAK RESET. RECOVER YOUR TREE.'
              : l.resultRelapseSubtitle,
          'delta': '-15',
          'positive': false,
        };
      case 'craving_resist':
        return {
          'emoji': '💪',
          'title': isVoltage
              ? 'CRAVING DEFEATED! +5 PTS'
              : l.resultCravingResistTitle,
          'subtitle': isVoltage
              ? 'WILLPOWER CHARGED. GROWTH BUILDING.'
              : l.resultCravingResistSubtitle,
          'delta': '+5',
          'positive': true,
        };
      case 'craving_yield':
        return {
          'emoji': '🌧️',
          'title':
              isVoltage ? 'CRAVING WON ⚡ -15 PTS' : l.resultCravingYieldTitle,
          'subtitle': isVoltage
              ? 'STREAK RESET. TREE WITHERED. RECOVER NOW.'
              : l.resultCravingYieldSubtitle,
          'delta': '-15',
          'positive': false,
        };
      default:
        return _getConfig('success', streakBonus, isVoltage, hc, l);
    }
  }

  Widget _statItem(AppThemeConfig t, String label, String value, Color color,
      bool isVoltage) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
              color: color, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          isVoltage ? label.toUpperCase() : label,
          style: TextStyle(color: t.textMuted, fontSize: 11),
        ),
      ],
    );
  }
}
