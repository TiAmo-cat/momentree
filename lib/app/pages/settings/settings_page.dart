import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/theme_controller.dart';
import '../../controllers/locale_controller.dart';
import '../../routes/app_routes.dart';
import '../../themes/app_theme_config.dart';
import '../../widgets/themed_widgets.dart';
import '../../../l10n/app_localizations.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final tc = Get.find<ThemeController>();
    final lc = Get.find<LocaleController>();
    final theme = tc.theme;
    if (theme == null) return const SizedBox.shrink();
    final t = theme;

    return PageBackground(
      theme: t,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
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
                        child: Icon(Icons.arrow_back_ios_new, size: 16, color: t.textSecondary),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      t.isVoltage ? 'SETTINGS' : l.settings,
                      style: TextStyle(
                        color: t.textPrimary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: t.isVoltage ? 1.5 : 0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Theme section
                Text(
                  t.isVoltage ? 'THEME' : l.chooseTheme,
                  style: TextStyle(color: t.textMuted, fontSize: 12, letterSpacing: 1.0),
                ),
                const SizedBox(height: 12),
                ...allThemes.values.map((themeOpt) {
                  final isActive = tc.themeId == themeOpt.id;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: GestureDetector(
                      onTap: () async {
                        await tc.setTheme(themeOpt.id);
                        Get.offAllNamed(AppRoutes.home);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                        decoration: BoxDecoration(
                          color: isActive
                              ? themeOpt.accentGreen.withOpacity(0.12)
                              : t.bgCard,
                          borderRadius: BorderRadius.circular(t.cardRadius),
                          border: Border.all(
                            color: isActive ? themeOpt.accentGreen : t.bgCardBorder,
                            width: isActive ? 1.5 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(themeOpt.emoji, style: const TextStyle(fontSize: 22, color: Colors.white, inherit: false)),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    themeOpt.id == AppThemeId.forest
                                        ? l.themeForestNight
                                        : themeOpt.id == AppThemeId.dew
                                            ? l.themeMorningField
                                            : l.themeVoltage,
                                    style: TextStyle(
                                      color: isActive ? themeOpt.accentGreenLight : t.textPrimary,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    themeOpt.id == AppThemeId.forest
                                        ? l.themeForestNightTagline
                                        : themeOpt.id == AppThemeId.dew
                                            ? l.themeMorningFieldTagline
                                            : l.themeVoltageTagline,
                                    style: TextStyle(color: t.textMuted, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            if (isActive)
                              Icon(Icons.check_circle_rounded,
                                  color: themeOpt.accentGreen, size: 20),
                          ],
                        ),
                      ),
                    ),
                  );
                }),

                const SizedBox(height: 24),

                // Language section
                Text(
                  t.isVoltage ? 'LANGUAGE' : l.language,
                  style: TextStyle(color: t.textMuted, fontSize: 12, letterSpacing: 1.0),
                ),
                const SizedBox(height: 12),
                Obx(() => Row(
                  children: [
                    _langButton(context, 'English', 'en', lc, t),
                    const SizedBox(width: 10),
                    _langButton(context, '中文', 'zh', lc, t),
                  ],
                )),

                const SizedBox(height: 24),

                // Other section
                Text(
                  t.isVoltage ? 'OTHER' : 'More',
                  style: TextStyle(color: t.textMuted, fontSize: 12, letterSpacing: 1.0),
                ),
                const SizedBox(height: 12),

                // Privacy policy button
                GestureDetector(
                  onTap: () {
                    // Open privacy policy URL
                    // launchUrl(Uri.parse('https://yoursite.com/privacy'));
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        backgroundColor: t.bgPage,
                        title: Text(l.privacyPolicy, style: TextStyle(color: t.textPrimary)),
                        content: Text(
                          'This app stores all data locally on your device. No personal data is collected or shared with third parties.',
                          style: TextStyle(color: t.textSecondary, fontSize: 14),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(l.cancel, style: TextStyle(color: t.accentGreen)),
                          ),
                        ],
                      ),
                    );
                  },
                  child: ThemedCard(
                    theme: t,
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                    child: Row(
                      children: [
                        Icon(Icons.privacy_tip_outlined, color: t.textSecondary, size: 20),
                        const SizedBox(width: 14),
                        Text(
                          l.privacyPolicy,
                          style: TextStyle(color: t.textPrimary, fontSize: 15),
                        ),
                        const Spacer(),
                        Icon(Icons.chevron_right, color: t.textMuted, size: 18),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _langButton(BuildContext context, String label, String code, LocaleController lc, AppThemeConfig t) {
    final isActive = lc.locale.languageCode == code;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (!isActive) lc.toggleLocale();
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: isActive ? t.accentGreen.withOpacity(0.15) : t.bgCard,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isActive ? t.accentGreen : t.bgCardBorder,
              width: isActive ? 1.5 : 1,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isActive ? t.accentGreenLight : t.textPrimary,
                fontSize: 14,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}


