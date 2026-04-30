import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/craving_controller.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/theme_controller.dart';
import '../../routes/app_routes.dart';
import '../../themes/app_theme_config.dart';
import '../../widgets/themed_widgets.dart';
import '../../../l10n/app_localizations.dart';
import 'dart:math' as math;

class CravingPage extends StatefulWidget {
  const CravingPage({super.key});

  @override
  State<CravingPage> createState() => _CravingPageState();
}

class _CravingPageState extends State<CravingPage>
    with TickerProviderStateMixin {
  late CravingController cc;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnim;
  bool _showSettings = false;  // 控制设置面板显示

  final List<String> _breathKeys = ['breatheIn', 'hold', 'breatheOut', 'hold'];
  final List<int> _breathDurations = [4, 4, 6, 2];
  int _breathPhaseIdx = 0;
  int _elapsedInPhase = 0;

  @override
  void initState() {
    super.initState();
    cc = Get.find<CravingController>();
    cc.reset();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _pulseAnim = Tween<double>(begin: 0.04, end: 0.12).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _onRunningChanged(bool running) {
    if (running) {
      _pulseController.repeat(reverse: true);
    } else {
      _pulseController.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final tc = Get.find<ThemeController>();
    final theme = tc.theme;
    if (theme == null) return const SizedBox.shrink();

    return PageBackground(
      theme: theme,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Obx(() {
            final running = cc.running.value;
            final finished = cc.finished.value;
            final timeLeft = cc.timeLeft.value;
            final duration = cc.duration.value;
            final progress = timeLeft / duration;

            // Determine timer color
            Color timerColor;
            if (progress > 0.5) {
              timerColor = theme.accentGreen;
            } else if (progress > 0.2) {
              timerColor = theme.accentAmber;
            } else {
              timerColor = theme.accentDanger;
            }

            if (running && !_pulseController.isAnimating) {
              _pulseController.repeat(reverse: true);
            } else if (!running && _pulseController.isAnimating) {
              _pulseController.stop();
            }

            return Stack(
              children: [
                // Breathing bg pulse
                if (running && !finished)
                  AnimatedBuilder(
                    animation: _pulseAnim,
                    builder: (_, __) => Positioned.fill(
                      child: IgnorePointer(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: RadialGradient(
                              colors: [
                                timerColor.withOpacity(_pulseAnim.value),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Column(
                    children: [
                      _buildHeader(theme, running, l),
                      const SizedBox(height: 8),
                      // Timer settings - only visible when _showSettings is true
                      if (!running && !finished && _showSettings) _buildSettings(theme, l),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildTimerCircle(theme, timerColor, timeLeft, duration, finished, l),
                            const SizedBox(height: 28),
                            // Breathing cue
                            if (running && !finished)
                              _buildBreathingCue(theme, timeLeft, l),
                            const SizedBox(height: 8),
                            // Motivational message
                            if (running && !finished)
                              _buildMotivationalMsg(theme, l),
                            const SizedBox(height: 24),
                            _buildCTAs(theme, running, finished, l),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildHeader(AppThemeConfig t, bool running, AppLocalizations l) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: t.bgCard,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: t.bgCardBorder),
            ),
            child: Icon(Icons.close, size: 18, color: t.textMuted),
          ),
        ),
        Text(
          t.isVoltage
              ? 'CRAVING SHIELD'
              : t.isForest
                  ? l.cravingShieldTitle
                  : 'Breathe through it 🌊',
          style: TextStyle(
            color: t.textPrimary,
            fontSize: 17,
            fontWeight: FontWeight.bold,
            letterSpacing: t.isVoltage ? 1.5 : 0,
          ),
        ),
        if (!cc.running.value)
          GestureDetector(
            onTap: () {
              setState(() => _showSettings = !_showSettings);
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _showSettings ? t.accentPrimary.withOpacity(0.2) : t.bgCard,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _showSettings ? t.accentPrimary : t.bgCardBorder,
                ),
              ),
              child: Icon(Icons.tune, size: 18, color: _showSettings ? t.accentPrimary : t.textMuted),
            ),
          )
        else
          const SizedBox(width: 40),
      ],
    );
  }

  Widget _buildSettings(AppThemeConfig t, AppLocalizations l) {
    return Obx(() => Container(
      margin: const EdgeInsets.only(top: 8, bottom: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: t.bgCard,
        borderRadius: BorderRadius.circular(t.cardRadius),
        border: Border.all(color: t.bgCardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l.timerDuration(cc.duration.value),
            style: TextStyle(color: t.textSecondary, fontSize: 13),
          ),
          const SizedBox(height: 8),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: t.accentPrimary,
              inactiveTrackColor: t.progressBg,
              thumbColor: t.accentPrimary,
              overlayColor: t.accentPrimaryGlow.withOpacity(0.2),
            ),
            child: Slider(
              min: 10,
              max: 300,
              divisions: 29,
              value: cc.duration.value.toDouble(),
              onChanged: (v) => cc.setDuration(v.round()),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('10s', style: TextStyle(color: t.textMuted, fontSize: 11)),
              Text('5 min', style: TextStyle(color: t.textMuted, fontSize: 11)),
            ],
          ),
        ],
      ),
    ));
  }

  Widget _buildTimerCircle(AppThemeConfig t, Color timerColor, int timeLeft, int duration, bool finished, AppLocalizations l) {
    const circleSize = 220.0;
    const radius = 90.0;
    final circumference = 2 * math.pi * radius;
    final progress = timeLeft / duration;
    final dashOffset = circumference - progress * circumference;

    return SizedBox(
      width: circleSize,
      height: circleSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // SVG-like circle
          CustomPaint(
            size: const Size(circleSize, circleSize),
            painter: _TimerRingPainter(
              progress: progress,
              timerColor: timerColor,
              bgColor: t.bgCard,
            ),
          ),
          // Center content
          if (!finished)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Text(
                    '$timeLeft',
                    key: ValueKey(timeLeft),
                    style: TextStyle(
                      color: timerColor,
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      height: 1,
                    ),
                  ),
                ),
                Text(l.seconds, style: TextStyle(color: t.textMuted, fontSize: 12)),
              ],
            )
          else
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('🎉', style: TextStyle(fontSize: 44)),
                const SizedBox(height: 4),
                Text(
                  t.isVoltage ? 'HELD IT!' : l.youHeldIt,
                  style: TextStyle(color: t.accentGreen, fontSize: 13),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildBreathingCue(AppThemeConfig t, int timeLeft, AppLocalizations l) {
    // Cycle through breathing phases
    final elapsed = (Get.find<CravingController>().duration.value - timeLeft);
    int total = 0;
    int phaseIdx = 0;
    for (int i = 0; i < _breathDurations.length * 100; i++) {
      final idx = i % _breathDurations.length;
      total += _breathDurations[idx];
      if (total > elapsed % (_breathDurations.fold(0, (a, b) => a + b))) {
        phaseIdx = idx;
        break;
      }
    }
    final breathTexts = [l.breatheIn, l.hold, l.breatheOut, l.hold];
    return Text(
      breathTexts[phaseIdx % 4],
      style: TextStyle(
        color: t.textSecondary,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildMotivationalMsg(AppThemeConfig t, AppLocalizations l) {
    final msgs = [l.mot1, l.mot2, l.mot3, l.mot4, l.mot5, l.mot6, l.mot7];
    return Obx(() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        '"${msgs[cc.msgIdx.value % msgs.length]}"',
        style: TextStyle(
          color: t.textMuted,
          fontSize: 14,
          fontStyle: t.isForest ? FontStyle.italic : FontStyle.normal,
          height: 1.5,
        ),
        textAlign: TextAlign.center,
      ),
    ));
  }

  Widget _buildCTAs(AppThemeConfig t, bool running, bool finished, AppLocalizations l) {
    final hc = Get.find<HomeController>();
    return Column(
      children: [
        if (!running && !finished)
          GradientButton(
            colors: t.btnPrimaryColors,
            textColor: t.btnPrimaryText,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20),
            glowColor: t.accentPrimaryGlow,
            onTap: cc.start,
            child: Center(
              child: Text(
                 t.isVoltage
                     ? '⚡ ACTIVATE TIMER'
                    : t.isForest
                        ? l.startTimer
                        : '🌊 Start the timer',
                style: TextStyle(
                  color: t.btnPrimaryText,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  letterSpacing: t.isVoltage ? 1.0 : 0,
                ),
              ),
            ),
          ),
        if (finished) ...[
          GradientButton(
            colors: t.btnPrimaryColors,
            textColor: t.btnPrimaryText,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20),
            glowColor: t.accentPrimaryGlow,
            onTap: () async {
              await hc.cravingResist();
              Get.toNamed(AppRoutes.result, arguments: {'type': 'craving_resist'});
            },
            child: Center(
              child: Text(
                t.isVoltage ? '💪 I HELD ON! +5 PTS' : l.iHeldOn,
                style: TextStyle(color: t.btnPrimaryText, fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () async {
              await hc.cravingYield();
              Get.toNamed(AppRoutes.result, arguments: {'type': 'craving_yield'});
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: t.btnDanger,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: t.accentDanger.withOpacity(0.2)),
              ),
              child: Center(
                child: Text(
                  l.iGaveInPts,
                  style: TextStyle(color: t.btnDangerText, fontSize: 14),
                ),
              ),
            ),
          ),
        ],
        if (running && !finished)
          TextButton(
            onPressed: () async {
              await hc.cravingYield();
              Get.toNamed(AppRoutes.result, arguments: {'type': 'craving_yield'});
            },
            child: Text(l.iGaveIn, style: TextStyle(color: t.textMuted, fontSize: 13)),
          ),
        if (!running && !finished)
          TextButton(
            onPressed: () => Get.back(),
            child: Text(l.exitWithoutPenalty, style: TextStyle(color: t.textMuted, fontSize: 13)),
          ),
      ],
    );
  }
}

class _TimerRingPainter extends CustomPainter {
  final double progress;
  final Color timerColor;
  final Color bgColor;

  _TimerRingPainter({
    required this.progress,
    required this.timerColor,
    required this.bgColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.41;
    const strokeWidth = 14.0;

    // Background ring
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = bgColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth,
    );

    // Progress arc
    final progressPaint = Paint()
      ..color = timerColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(_TimerRingPainter old) =>
      old.progress != progress || old.timerColor != timerColor;
}

