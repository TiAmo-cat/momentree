import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui';
import '../themes/app_theme_config.dart';
import '../controllers/locale_controller.dart';
import '../../l10n/app_localizations.dart';

class ThemedCard extends StatelessWidget {
  final AppThemeConfig theme;
  final Widget child;
  final EdgeInsets? padding;
  final double? borderRadius;

  const ThemedCard({
    super.key,
    required this.theme,
    required this.child,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? theme.cardRadius;
    final card = Container(
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.bgCard,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: theme.bgCardBorder),
      ),
      child: child,
    );

    if (theme.hasCardBlur) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: card,
        ),
      );
    }
    return card;
  }
}

class GradientButton extends StatelessWidget {
  final List<Color> colors;
  final Color textColor;
  final VoidCallback? onTap;
  final Widget child;
  final double borderRadius;
  final EdgeInsets padding;
  final Color? glowColor;
  final double? width;

  const GradientButton({
    super.key,
    required this.colors,
    required this.textColor,
    required this.child,
    this.onTap,
    this.borderRadius = 18,
    this.padding = const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
    this.glowColor,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: width,
        padding: padding,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: colors,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: glowColor != null
              ? [BoxShadow(color: glowColor!, blurRadius: 20, spreadRadius: 2)]
              : null,
        ),
        child: DefaultTextStyle(
          style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.w600),
          child: child,
        ),
      ),
    );
  }
}

class PageBackground extends StatelessWidget {
  final AppThemeConfig theme;
  final Widget child;

  const PageBackground({super.key, required this.theme, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: theme.pageGradientColors.length > 1
              ? theme.pageGradientColors
              : [theme.bgPage, theme.bgPage],
          stops: theme.pageGradientColors.length == 3
              ? const [0.0, 0.5, 1.0]
              : null,
        ),
      ),
      child: child,
    );
  }
}

class LanguageButton extends StatelessWidget {
  final bool isChinese;
  final AppThemeConfig theme;

  const LanguageButton({
    super.key,
    required this.isChinese,
    required this.theme,
  });

  void _showSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _LanguageSheet(theme: theme),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showSheet(context),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: theme.bgCard,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: theme.bgCardBorder),
        ),
        child: Icon(Icons.language, size: 18, color: theme.textSecondary),
      ),
    );
  }
}

class _LanguageSheet extends StatelessWidget {
  final AppThemeConfig theme;

  const _LanguageSheet({required this.theme});

  @override
  Widget build(BuildContext context) {
    final t = theme;
    final lc = Get.find<LocaleController>();
    final isDark = t.isForest || t.isVoltage;
    final l = AppLocalizations.of(context)!;

    final langs = [
      {'code': 'en', 'label': 'English', 'flag': '🇺🇸'},
      {'code': 'zh', 'label': '中文', 'flag': '🇨🇳'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF111111) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 48),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF444444),
              borderRadius: BorderRadius.circular(99),
            ),
          ),
          // Title
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                l.language,
                style: TextStyle(
                  color: t.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Obx(() {
            final currentCode = lc.locale.languageCode;
            return Column(
              children: langs.map((lang) {
                final isActive = currentCode == lang['code'];
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                  leading: Text(lang['flag']!, style: const TextStyle(fontSize: 22)),
                  title: Text(
                    lang['label']!,
                    style: TextStyle(
                      color: isActive ? t.accentGreenLight : t.textPrimary,
                      fontSize: 16,
                      fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  trailing: isActive
                      ? Icon(Icons.check_circle_rounded, color: t.accentGreen, size: 22)
                      : Icon(Icons.radio_button_unchecked, color: t.textMuted, size: 22),
                  onTap: () {
                    if (!isActive) lc.toggleLocale();
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            );
          }),
        ],
      ),
    );
  }
}

