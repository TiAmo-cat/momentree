import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/theme_controller.dart';
import '../../controllers/locale_controller.dart';
import '../../routes/app_routes.dart';
import '../../themes/app_theme_config.dart';
import '../../widgets/tree_visual.dart';
import '../../widgets/themed_widgets.dart';
import '../../../l10n/app_localizations.dart';

class StyleSelectorPage extends StatefulWidget {
  const StyleSelectorPage({super.key});

  @override
  State<StyleSelectorPage> createState() => _StyleSelectorPageState();
}

class _StyleSelectorPageState extends State<StyleSelectorPage>
    with TickerProviderStateMixin {
  AppThemeId _selected = AppThemeId.forest;
  bool _confirming = false;
  late AnimationController _starsController;

  @override
  void initState() {
    super.initState();
    final tc = Get.find<ThemeController>();
    _selected = tc.themeId ?? AppThemeId.forest;
    _starsController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _starsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final lc = Get.find<LocaleController>();
    final activeTheme = allThemes[_selected]!;
    final tc = Get.find<ThemeController>();

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF08080F), Color(0xFF0D1A0D), Color(0xFF08080F)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            // Stars background
            _buildStars(),
            // Full-page scroll
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Top padding for floating language button
                    const SizedBox(height: 52),
                    // Header
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                      child: Column(
                        children: [
                          const Text('🌳', style: TextStyle(fontSize: 40)),
                          const SizedBox(height: 12),
                          ShaderMask(
                            shaderCallback: (bounds) => const LinearGradient(
                              colors: [Color(0xFF22C55E), Color(0xFFFBBF24), Color(0xFF8B5CF6)],
                            ).createShader(bounds),
                            child: const Text(
                              'Momentum',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            l.themeDescription,
                            style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    // Phone mockup row (horizontal scroll)
                    SizedBox(
                      height: 410,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        clipBehavior: Clip.none,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                        children: allThemes.values.map((theme) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: GestureDetector(
                              onTap: () => setState(() => _selected = theme.id),
                              child: AnimatedScale(
                                scale: _selected == theme.id ? 1.04 : 1.0,
                                duration: const Duration(milliseconds: 200),
                                child: _PhoneMockupWithLabel(
                                  theme: theme,
                                  active: _selected == theme.id,
                                  l: l,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Theme info
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: Container(
                          key: ValueKey(_selected),
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: activeTheme.accentGreen.withOpacity(0.07),
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: activeTheme.accentGreen.withOpacity(0.18),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(activeTheme.emoji, style: const TextStyle(fontSize: 26, color: Colors.white, inherit: false)),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _selected == AppThemeId.forest
                                          ? l.themeForestNight
                                          : _selected == AppThemeId.dew
                                              ? l.themeMorningField
                                              : l.themeVoltage,
                                      style: TextStyle(
                                        color: activeTheme.accentGreenLight,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      _selected == AppThemeId.forest
                                          ? l.forestDesc
                                          : _selected == AppThemeId.dew
                                              ? l.dewDesc
                                              : l.voltageDesc,
                                      style: const TextStyle(
                                        color: Color(0xFF94A3B8),
                                        fontSize: 13,
                                        height: 1.5,
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
                    const SizedBox(height: 20),
                    // CTA
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          GradientButton(
                            colors: activeTheme.btnPrimaryColors,
                            textColor: activeTheme.btnPrimaryText,
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            glowColor: activeTheme.accentPrimaryGlow,
                            onTap: _confirming
                                ? null
                                : () async {
                                    setState(() => _confirming = true);
                                    await Get.find<ThemeController>().setTheme(_selected);
                                    await Future.delayed(const Duration(milliseconds: 400));
                                    Get.offAllNamed(AppRoutes.home);
                                  },
                            child: Center(
                              child: Text(
                                 _confirming
                                    ? '⏳ Loading...'
                                    : _selected == AppThemeId.voltage
                                        ? '⚡ ACTIVATE ${l.themeVoltage.toUpperCase()}'
                                        : '${activeTheme.emoji} ${l.activate(_selected == AppThemeId.forest ? l.themeForestNight : l.themeMorningField)}',
                                style: TextStyle(
                                  color: activeTheme.btnPrimaryText,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: _selected == AppThemeId.voltage ? 1.0 : 0,
                                ),
                              ),
                            ),
                          ),
                          if (tc.themeId != null) ...[
                            const SizedBox(height: 10),
                            TextButton(
                              onPressed: () => Get.back(),
                              child: Text(
                                l.backToApp,
                                style: const TextStyle(color: Color(0xFF64748B), fontSize: 14),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            // Floating language button - top right
            Positioned(
              top: MediaQuery.of(context).padding.top + 12,
              right: 24,
              child: Obx(() => LanguageButton(
                isChinese: lc.isChinese,
                theme: forestTheme,
              )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStars() {
    return Positioned.fill(
      child: IgnorePointer(
        child: AnimatedBuilder(
          animation: _starsController,
          builder: (_, __) => CustomPaint(
            painter: _StarsPainter(opacity: _starsController.value),
          ),
        ),
      ),
    );
  }
}

class _StarsPainter extends CustomPainter {
  final double opacity;
  static final _rng = [
    [0.12, 0.08], [0.45, 0.15], [0.78, 0.05], [0.23, 0.32],
    [0.67, 0.22], [0.89, 0.40], [0.05, 0.55], [0.34, 0.70],
    [0.56, 0.82], [0.90, 0.65], [0.15, 0.90], [0.72, 0.95],
    [0.38, 0.48], [0.85, 0.18], [0.61, 0.38], [0.28, 0.12],
    [0.94, 0.78], [0.42, 0.95], [0.08, 0.42], [0.76, 0.60],
  ];

  const _StarsPainter({required this.opacity});

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < _rng.length; i++) {
      final o = (i % 3 == 0) ? opacity * 0.4 : (i % 3 == 1) ? (1 - opacity) * 0.3 : opacity * 0.2;
      canvas.drawCircle(
        Offset(_rng[i][0] * size.width, _rng[i][1] * size.height),
        1.0,
        Paint()..color = Colors.white.withOpacity(o.clamp(0.05, 0.4)),
      );
    }
  }

  @override
  bool shouldRepaint(_StarsPainter old) => old.opacity != opacity;
}

class _PhoneMockupWithLabel extends StatelessWidget {
  final AppThemeConfig theme;
  final bool active;
  final AppLocalizations l;

  const _PhoneMockupWithLabel({required this.theme, required this.active, required this.l});

  List<Color> get _previewColors {
    switch (theme.id) {
      case AppThemeId.forest:
        return [const Color(0xFF22C55E), const Color(0xFFFBBF24), const Color(0xFF4ADE80)];
      case AppThemeId.dew:
        return [const Color(0xFFD97706), const Color(0xFFF59E0B), const Color(0xFF15803D)];
      case AppThemeId.voltage:
        return [const Color(0xFF10B981), const Color(0xFF22D3EE), const Color(0xFF8B5CF6)];
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = theme;
    final themeName = t.id == AppThemeId.forest
        ? l.themeForestNight
        : t.id == AppThemeId.dew
            ? l.themeMorningField
            : l.themeVoltage;
    final colors = _previewColors;

    return Column(
      children: [
        _buildMockup(t),
        const SizedBox(height: 10),
        // Theme name
        Text(
          themeName,
          style: TextStyle(
            color: active ? t.accentGreenLight : const Color(0xFF94A3B8),
            fontSize: 12,
            fontWeight: active ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        const SizedBox(height: 6),
        // Color dots
        Row(
          mainAxisSize: MainAxisSize.min,
          children: colors.map((c) => Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(right: 5),
            decoration: BoxDecoration(color: c, shape: BoxShape.circle),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildMockup(AppThemeConfig t) {
    final isVoltage = t.isVoltage;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 160,
      height: 300,
      decoration: BoxDecoration(
        color: t.bgPage,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: active ? t.accentGreen : Colors.transparent,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: active ? t.accentGreen.withOpacity(0.25) : Colors.black.withOpacity(0.4),
            blurRadius: active ? 30 : 20,
            spreadRadius: active ? 2 : 0,
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          Column(
            children: [
          // Status bar
          Container(
            height: 20,
            color: (t.isForest || isVoltage)
                ? Colors.black.withOpacity(0.3)
                : Colors.white.withOpacity(0.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ...List.generate(3, (_) => Container(
                  width: 3, height: 3,
                  margin: const EdgeInsets.only(right: 4),
                  decoration: BoxDecoration(
                    color: t.textMuted,
                    shape: BoxShape.circle,
                  ),
                )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                // Header label
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    isVoltage ? 'MOMENTUM' : t.isForest ? 'Momentum' : 'Keep Growing',
                    style: TextStyle(
                      fontSize: 7,
                      color: t.textMuted,
                      letterSpacing: isVoltage ? 1 : 0,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                // Stat cards
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: t.bgCard,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: t.bgCardBorder),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('STREAK', style: TextStyle(fontSize: 5, color: t.textMuted)),
                            Text('12', style: TextStyle(fontSize: 12, color: t.streakColor, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: t.bgCard,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: t.bgCardBorder),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('MOMENTUM', style: TextStyle(fontSize: 5, color: t.textMuted)),
                            Text('48', style: TextStyle(fontSize: 12, color: t.accentAmber, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 2),
                            Container(
                              height: 3,
                              decoration: BoxDecoration(
                                color: t.progressBg,
                                borderRadius: BorderRadius.circular(99),
                              ),
                              child: FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: 0.45,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: t.accentGreen,
                                    borderRadius: BorderRadius.circular(99),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                // Tree
                Center(
                  child: TreeVisual(stage: 2, withered: false, theme: t, size: 70),
                ),
                const SizedBox(height: 4),
                // Buttons
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          color: t.isForest || isVoltage
                              ? t.accentGreen.withOpacity(0.2)
                              : const Color(0xFFDCFCE7),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                             Text('✅', style: TextStyle(fontSize: 8, color: t.accentGreen)),
                            Text('Held', style: TextStyle(fontSize: 5, color: t.accentGreen)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          color: t.dangerBg,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                             Text('❌', style: TextStyle(fontSize: 8, color: t.accentDanger)),
                            Text('Slipped', style: TextStyle(fontSize: 5, color: t.accentDanger)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                // Craving button
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: t.btnCravingColors),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      '🔥 ${isVoltage ? 'CRAVING' : 'craving'}',
                      style: TextStyle(fontSize: 6, color: t.btnCravingText),
                    ),
                  ),
                ),
              ],
            ),
          ),
            ],
          ),
          // Active checkmark
          if (active)
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: theme.accentGreen,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, size: 12, color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}

