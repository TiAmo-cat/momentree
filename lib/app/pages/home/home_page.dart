import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/theme_controller.dart';
import '../../controllers/locale_controller.dart';
import '../../routes/app_routes.dart';
import '../../services/ad_service.dart';
import '../../widgets/ad_banner.dart';
import '../../widgets/tree_visual.dart';
import '../../widgets/themed_widgets.dart';
import '../../themes/app_theme_config.dart';
import '../../../l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _treeFloatController;
  late Animation<double> _treeFloatAnim;
  late AnimationController _cravingPulseController;
  late Animation<double> _cravingPulseAnim;
  String? _floatDelta;
  bool _rewardedAdLoading = false;

  @override
  void initState() {
    super.initState();
    _treeFloatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    )..repeat(reverse: true);
    _treeFloatAnim = Tween<double>(begin: 0, end: -6).animate(
      CurvedAnimation(parent: _treeFloatController, curve: Curves.easeInOut),
    );

    _cravingPulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat(reverse: true);
    _cravingPulseAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _cravingPulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _treeFloatController.dispose();
    _cravingPulseController.dispose();
    super.dispose();
  }

  void _showDelta(String text) {
    setState(() => _floatDelta = text);
    Future.delayed(const Duration(milliseconds: 1800), () {
      if (mounted) setState(() => _floatDelta = null);
    });
  }

  void _handleCheckInSuccess(HomeController hc, AppLocalizations l) async {
    final delta = await hc.checkInSuccess();
    final isBonus = delta > 10;
    _showDelta(isBonus ? '+$delta 🔥' : '+$delta');
    Get.toNamed(AppRoutes.result, arguments: {
      'type': 'success',
      'streakBonus': isBonus,
    });
  }

  // ignore: unused_element
  void _handleCheckInRelapse(HomeController hc) async {
    await hc.checkInRelapse();
    Get.toNamed(AppRoutes.result, arguments: {'type': 'relapse'});
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return GetBuilder<ThemeController>(
      builder: (tc) {
        final theme = tc.theme;
        if (theme == null) {
          Get.offAllNamed(AppRoutes.select);
          return const SizedBox.shrink();
        }
        return GetBuilder<HomeController>(
          builder: (hc) => _buildPage(context, theme, hc, l),
        );
      },
    );
  }

  Widget _buildPage(BuildContext context, AppThemeConfig t, HomeController hc,
      AppLocalizations l) {
    final lc = Get.find<LocaleController>();
    final maxMomentum = 150;
    final progressPct = (hc.momentum.value / maxMomentum).clamp(0.0, 1.0);

    return PageBackground(
      theme: t,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            // Background orbs for dark themes
            if (t.isForest || t.isVoltage) _buildBgOrbs(t),

            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 100),
                child: Column(
                  children: [
                    _buildHeader(context, t, hc, lc, l),
                    const SizedBox(height: 4),
                    _buildStatsRow(t, hc, progressPct, maxMomentum, l),
                    const SizedBox(height: 12),
                    _buildTreeSection(t, hc, l),
                    const SizedBox(height: 12),
                    if (hc.isWithered.value) _buildRecoverySection(t, hc, l),
                    _buildCheckInSection(t, hc, l),
                    const SizedBox(height: 12),
                    _buildCravingButton(t, hc, l),
                    const SizedBox(height: 12),
                    _buildStatsFooter(t, hc, l),
                    const SizedBox(height: 12),
                    AdBanner(theme: t),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBgOrbs(AppThemeConfig t) {
    return Positioned.fill(
      child: IgnorePointer(
        child: Stack(
          children: [
            Positioned(
              top: -80,
              left: -80,
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.4,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      (t.isForest
                              ? const Color(0xFF22C55E)
                              : const Color(0xFF8B5CF6))
                          .withOpacity(0.05),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -60,
              right: -60,
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.height * 0.35,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      (t.isForest
                              ? const Color(0xFFFBBF24)
                              : const Color(0xFF22D3EE))
                          .withOpacity(0.04),
                      Colors.transparent,
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

  Widget _buildHeader(BuildContext context, AppThemeConfig t, HomeController hc,
      LocaleController lc, AppLocalizations l) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (t.isDew)
                  Text(
                    _formatDate(context),
                    style: TextStyle(color: t.textMuted, fontSize: 12),
                  ),
                Text(
                  t.isVoltage
                      ? 'MOMENTREE'
                      : t.isDew
                          ? l.appName
                          : 'Momentree',
                  style: TextStyle(
                    color: t.textPrimary,
                    fontSize: t.isVoltage ? 22 : 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: t.isVoltage ? 1.5 : 0,
                  ),
                ),
                if (t.isDew)
                  Text(
                    "You're doing great. One day at a time.",
                    style: TextStyle(color: t.textSecondary, fontSize: 12),
                  ),
              ],
            ),
          ),
          // Language button
          Obx(() => LanguageButton(
                isChinese: lc.isChinese,
                theme: t,
              )),
          const SizedBox(width: 8),
          // Settings button
          GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.settings),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: t.bgCard,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: t.bgCardBorder),
              ),
              child: Icon(Icons.settings_outlined,
                  size: 18, color: t.textSecondary),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(BuildContext context) {
    final now = DateTime.now();
    final weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${weekdays[now.weekday - 1]}, ${months[now.month - 1]} ${now.day}';
  }

  Widget _buildStatsRow(AppThemeConfig t, HomeController hc, double progressPct,
      int maxMomentum, AppLocalizations l) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Streak card
            Expanded(
              child: ThemedCard(
                theme: t,
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.local_fire_department,
                            size: 14, color: t.streakColor),
                        const SizedBox(width: 4),
                        Text(
                          t.isVoltage ? 'STREAK' : l.streak.toUpperCase(),
                          style: TextStyle(
                            color: t.textMuted,
                            fontSize: 10,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Obx(() => Text(
                          '${hc.streak.value}',
                          style: TextStyle(
                            color: t.streakColor,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            height: 1,
                          ),
                        )),
                    Text(l.days,
                        style: TextStyle(color: t.textMuted, fontSize: 10)),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            // Momentum card
            Expanded(
              flex: 2,
              child: ThemedCard(
                theme: t,
                padding: const EdgeInsets.all(14),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.bolt, size: 14, color: t.accentAmber),
                            const SizedBox(width: 4),
                            Text(
                              t.isVoltage ? 'GROWTH' : l.momentum.toUpperCase(),
                              style: TextStyle(
                                color: t.textMuted,
                                fontSize: 10,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Obx(() => Text(
                              '${hc.momentum.value}',
                              style: TextStyle(
                                color: t.accentAmber,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                height: 1,
                              ),
                            )),
                        const SizedBox(height: 8),
                        // Progress bar: track + fill via Stack
                        Obx(() {
                          final pct =
                              (hc.momentum.value / maxMomentum).clamp(0.0, 1.0);
                          return SizedBox(
                            height: 6,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                // Background track
                                Container(
                                  decoration: BoxDecoration(
                                    color: t.progressBg,
                                    borderRadius: BorderRadius.circular(99),
                                  ),
                                ),
                                // Filled portion
                                if (pct > 0)
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: FractionallySizedBox(
                                      widthFactor: pct,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              colors: t.progressFillColors),
                                          borderRadius:
                                              BorderRadius.circular(99),
                                          boxShadow: t.progressGlow !=
                                                  Colors.transparent
                                              ? [
                                                  BoxShadow(
                                                      color: t.progressGlow,
                                                      blurRadius: 4)
                                                ]
                                              : null,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        }),
                        const SizedBox(height: 4),
                        Obx(() => Text(
                              '${hc.momentum.value} / $maxMomentum pts',
                              style:
                                  TextStyle(color: t.textMuted, fontSize: 10),
                            )),
                      ],
                    ),
                    // Float delta
                    if (_floatDelta != null)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: AnimatedOpacity(
                          opacity: _floatDelta != null ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 300),
                          child: Text(
                            _floatDelta ?? '',
                            style: TextStyle(
                              color: t.accentGreenLight,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ], // Stack children
                ), // Stack
              ), // ThemedCard momentum
            ), // Expanded momentum
          ], // Row children
        ), // Row
      ), // IntrinsicHeight
    );
  }

  Widget _buildTreeSection(
      AppThemeConfig t, HomeController hc, AppLocalizations l) {
    final stageLabels = [
      l.stageSeedling,
      l.stageSapling,
      l.stageYoungTree,
      l.stageFullGrove
    ];
    final stageDescs = [
      l.stageDescSeedling,
      l.stageDescSapling,
      l.stageDescYoungTree,
      l.stageDescFullGrove
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ThemedCard(
        theme: t,
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
        child: Obx(() {
          final stage = hc.treeStage;
          final isW = hc.isWithered.value;
          return Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  // Withered badge
                  if (isW)
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          color: t.dangerBg,
                          borderRadius: BorderRadius.circular(99),
                          border: Border.all(
                              color: t.accentDanger.withOpacity(0.3)),
                        ),
                        child: Text(
                          l.withered,
                          style: TextStyle(color: t.dangerText, fontSize: 11),
                        ),
                      ),
                    ),
                  const SizedBox(height: 8),
                  // Tree animation
                  AnimatedBuilder(
                    animation: _treeFloatAnim,
                    builder: (context, child) => Transform.translate(
                      offset:
                          isW ? Offset.zero : Offset(0, _treeFloatAnim.value),
                      child: child,
                    ),
                    child: TreeVisual(
                      stage: stage,
                      withered: isW,
                      theme: t,
                      size: 180,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    stageLabels[stage],
                    style: TextStyle(
                      color: isW ? t.textMuted : t.textSecondary,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    isW ? l.stageWitheredDesc : stageDescs[stage],
                    style: TextStyle(color: t.textMuted, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                  if (!isW && stage < 3) ...[
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.eco, size: 11, color: t.textMuted),
                        const SizedBox(width: 4),
                        Text(
                          stage == 0
                              ? l.ptsToSapling(20 - hc.momentum.value)
                              : stage == 1
                                  ? l.ptsToYoungTree(50 - hc.momentum.value)
                                  : l.ptsToFullGrove(100 - hc.momentum.value),
                          style: TextStyle(color: t.textMuted, fontSize: 11),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildRecoverySection(
      AppThemeConfig t, HomeController hc, AppLocalizations l) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: t.dangerBg,
          borderRadius: BorderRadius.circular(t.cardRadius),
          border: Border.all(color: t.accentDanger.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Text(
              l.treeWithered,
              style: TextStyle(color: t.dangerText, fontSize: 13),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                if (hc.canFreeRecover) ...[
                  Expanded(
                    child: GradientButton(
                      colors: t.btnPrimaryColors,
                      textColor: t.btnPrimaryText,
                      borderRadius: 14,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      onTap: () async {
                        final pts = await hc.freeRecover();
                        _showDelta('🌿 +$pts');
                      },
                      child: Center(
                        child: Text(l.freeRecovery,
                            style: TextStyle(
                                color: t.btnPrimaryText, fontSize: 13)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      final pts = await _showRewardedRecoveryAd(hc, t);
                      if (pts == null) return;
                      _showDelta('☀️ +$pts');
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: t.btnSecondary,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: t.bgCardBorder),
                      ),
                      child: Center(
                        child: Text(l.watchAd,
                            style: TextStyle(
                                color: t.btnSecondaryText, fontSize: 13)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<int?> _showRewardedRecoveryAd(
      HomeController hc, AppThemeConfig t) async {
    final adUnitId = AdService.rewardedAdUnitId;
    if (adUnitId == null || _rewardedAdLoading) {
      _showAdUnavailable(t);
      return null;
    }

    final completer = Completer<int?>();
    setState(() => _rewardedAdLoading = true);

    await RewardedAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          if (!mounted) {
            ad.dispose();
            if (!completer.isCompleted) completer.complete(null);
            return;
          }

          setState(() => _rewardedAdLoading = false);
          var rewardEarned = false;
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) async {
              ad.dispose();
              if (!completer.isCompleted) {
                completer.complete(rewardEarned ? await hc.adRecover() : null);
              }
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              if (!completer.isCompleted) completer.complete(null);
              if (mounted) _showAdUnavailable(t);
            },
          );

          ad.show(
            onUserEarnedReward: (ad, reward) {
              rewardEarned = true;
            },
          );
        },
        onAdFailedToLoad: (error) {
          if (mounted) {
            setState(() => _rewardedAdLoading = false);
            _showAdUnavailable(t);
          }
          if (!completer.isCompleted) completer.complete(null);
        },
      ),
    );

    return completer.future;
  }

  void _showAdUnavailable(AppThemeConfig t) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Ad is not ready. Please try again later.'),
        backgroundColor: t.bgPage,
      ),
    );
  }

  Widget _buildCheckInSection(
      AppThemeConfig t, HomeController hc, AppLocalizations l) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ThemedCard(
        theme: t,
        padding: const EdgeInsets.all(18),
        child: Obx(() {
          final checkedIn = hc.checkedInToday.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    t.isVoltage ? 'DAILY CHECK-IN' : l.dailyCheckIn,
                    style: TextStyle(
                      color: t.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (checkedIn)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        color: t.successBg,
                        borderRadius: BorderRadius.circular(99),
                      ),
                      child: Text(
                        l.checkInDone,
                        style: TextStyle(color: t.accentGreen, fontSize: 11),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 14),
              if (checkedIn)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      l.checkInTomorrow,
                      style: TextStyle(color: t.textMuted, fontSize: 13),
                    ),
                  ),
                )
              else
                Row(
                  children: [
                    Expanded(
                      child: GradientButton(
                        colors: t.btnPrimaryColors,
                        textColor: t.btnPrimaryText,
                        borderRadius: 16,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        glowColor: t.accentPrimaryGlow,
                        onTap: () => _handleCheckInSuccess(hc, l),
                        child: Container(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('✅', style: TextStyle(fontSize: 20)),
                              const SizedBox(height: 4),
                              Text(t.isVoltage ? 'HELD STRONG' : l.heldStrong,
                                  style: TextStyle(
                                      color: t.btnPrimaryText, fontSize: 13)),
                              const SizedBox(height: 2),
                              Text(l.heldStrongPts,
                                  style: TextStyle(
                                      color: t.btnPrimaryText.withOpacity(0.8),
                                      fontSize: 11)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _showRelapseDialog(hc, t, l),
                        child: Container(
                          alignment: Alignment.center,
                          height: 90,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: t.btnDanger,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                                color: t.accentDanger.withOpacity(0.2)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('❌', style: TextStyle(fontSize: 14)),
                              const SizedBox(height: 2),
                              Text(t.isVoltage ? 'SLIPPED' : l.slipped,
                                  style: TextStyle(
                                      color: t.btnDangerText, fontSize: 13)),
                              Text(l.slippedPts,
                                  style: TextStyle(
                                      color: t.btnDangerText.withOpacity(0.7),
                                      fontSize: 11)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          );
        }),
      ),
    );
  }

  void _showRelapseDialog(
      HomeController hc, AppThemeConfig t, AppLocalizations l) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _RelapseBottomSheet(theme: t, hc: hc, l: l),
    );
  }

  Widget _buildCravingButton(
      AppThemeConfig t, HomeController hc, AppLocalizations l) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          AnimatedBuilder(
            animation: _cravingPulseAnim,
            builder: (context, child) {
              final glow = t.btnCravingGlow != Colors.transparent
                  ? t.btnCravingGlow
                      .withOpacity(0.3 + _cravingPulseAnim.value * 0.4)
                  : null;
              return GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.craving),
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: t.btnCravingColors,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: glow != null
                        ? [
                            BoxShadow(
                                color: glow, blurRadius: 24, spreadRadius: 2)
                          ]
                        : null,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('🔥', style: TextStyle(fontSize: 20)),
                      const SizedBox(width: 10),
                      Text(
                        t.isVoltage ? 'I HAVE A CRAVING' : l.iHaveACraving,
                        style: TextStyle(
                          color: t.btnCravingText,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: t.isVoltage ? 1.0 : 0,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.chevron_right,
                          color: t.btnCravingText, size: 18),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 6),
          Text(
            t.isVoltage ? 'ACTIVATE CRAVING SHIELD' : l.tapToStart,
            style: TextStyle(color: t.textMuted, fontSize: 11),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildStatsFooter(
      AppThemeConfig t, HomeController hc, AppLocalizations l) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ThemedCard(
        theme: t,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        child: Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _statItem(t, '📅', '${hc.totalDays.value}', l.totalDays),
                _statItem(t, '💪', '${hc.cravingResists.value}', l.resisted),
                _statItemIcon(
                    t, Icons.replay, '${hc.relapseCount.value}', l.relapses),
              ],
            )),
      ),
    );
  }

  Widget _statItem(AppThemeConfig t, String icon, String value, String label) {
    return Column(
      children: [
        Text(icon, style: const TextStyle(fontSize: 18)),
        const SizedBox(height: 3),
        Text(
          value,
          style: TextStyle(
            color: t.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: t.textMuted,
            fontSize: 10,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _statItemIcon(
      AppThemeConfig t, IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, size: 18, color: t.textSecondary),
        const SizedBox(height: 3),
        Text(
          value,
          style: TextStyle(
            color: t.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: t.textMuted,
            fontSize: 10,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // ignore: unused_element
  Widget buildLegacyAdBanner(AppThemeConfig t) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: t.bgCard,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: t.bgCardBorder, style: BorderStyle.solid),
        ),
        child: Center(
          child: Text(
            '📢 Banner Ad Placement',
            style: TextStyle(color: t.textMuted, fontSize: 11),
          ),
        ),
      ),
    );
  }
}

class _RelapseBottomSheet extends StatelessWidget {
  final AppThemeConfig theme;
  final HomeController hc;
  final AppLocalizations l;

  const _RelapseBottomSheet(
      {required this.theme, required this.hc, required this.l});

  @override
  Widget build(BuildContext context) {
    final t = theme;
    final isForest = t.isForest;
    final isVoltage = t.isVoltage;

    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: () {},
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: isForest || isVoltage
                  ? const Color(0xFF111111)
                  : Colors.white,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(28)),
            ),
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 48),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFF444444),
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  l.dailyCheckIn,
                  style: TextStyle(
                    color: t.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l.howDidTodayGo,
                  style: TextStyle(color: t.textMuted, fontSize: 14),
                ),
                const SizedBox(height: 24),
                GradientButton(
                  colors: t.btnPrimaryColors,
                  textColor: t.btnPrimaryText,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  onTap: () {
                    Navigator.pop(context);
                    hc.checkInSuccess();
                    Get.toNamed(AppRoutes.result,
                        arguments: {'type': 'success', 'streakBonus': false});
                  },
                  child: Center(
                    child: Text(l.iHeldStrongToday,
                        style:
                            TextStyle(color: t.btnPrimaryText, fontSize: 15)),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    hc.checkInRelapse();
                    Get.toNamed(AppRoutes.result,
                        arguments: {'type': 'relapse'});
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    decoration: BoxDecoration(
                      color: t.btnDanger,
                      borderRadius: BorderRadius.circular(16),
                      border:
                          Border.all(color: t.accentDanger.withOpacity(0.2)),
                    ),
                    child: Center(
                      child: Text(
                        l.iBrokeMyStreak,
                        style: TextStyle(color: t.btnDangerText, fontSize: 14),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(l.cancel,
                      style: TextStyle(color: t.textMuted, fontSize: 14)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
