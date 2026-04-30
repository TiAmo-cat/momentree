import 'package:flutter/material.dart';

enum AppThemeId { forest, dew, voltage }

class AppThemeConfig {
  final AppThemeId id;
  final String name;
  final String tagline;
  final String emoji;

  // Backgrounds
  final Color bgPage;
  final Color bgCard;
  final Color bgCardBorder;
  final Color bgCardGlow;
  final Color bgInput;

  // Text
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;

  // Accents
  final Color accentGreen;
  final Color accentGreenLight;
  final Color accentAmber;
  final Color accentDanger;
  final Color accentDangerGlow;
  final Color accentPrimary;
  final Color accentPrimaryGlow;

  // Tree colors
  final Color trunkColor;
  final Color trunkColorWithered;
  final Color foliageBase;
  final Color foliageMid;
  final Color foliageLight;
  final Color foliageWithered;
  final Color foliageGlow;
  final Color groundColor;

  // UI states
  final Color successBg;
  final Color successText;
  final Color dangerBg;
  final Color dangerText;

  // Buttons
  final List<Color> btnPrimaryColors;
  final Color btnPrimaryText;
  final Color btnDanger;
  final Color btnDangerText;
  final List<Color> btnCravingColors;
  final Color btnCravingText;
  final Color btnCravingGlow;
  final Color btnSecondary;
  final Color btnSecondaryText;

  // Progress
  final Color progressBg;
  final List<Color> progressFillColors;
  final Color progressGlow;

  // Streak
  final Color streakColor;

  // Card
  final double cardRadius;
  final bool hasCardBlur;
  final List<Color> pageGradientColors;

  const AppThemeConfig({
    required this.id,
    required this.name,
    required this.tagline,
    required this.emoji,
    required this.bgPage,
    required this.bgCard,
    required this.bgCardBorder,
    required this.bgCardGlow,
    required this.bgInput,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.accentGreen,
    required this.accentGreenLight,
    required this.accentAmber,
    required this.accentDanger,
    required this.accentDangerGlow,
    required this.accentPrimary,
    required this.accentPrimaryGlow,
    required this.trunkColor,
    required this.trunkColorWithered,
    required this.foliageBase,
    required this.foliageMid,
    required this.foliageLight,
    required this.foliageWithered,
    required this.foliageGlow,
    required this.groundColor,
    required this.successBg,
    required this.successText,
    required this.dangerBg,
    required this.dangerText,
    required this.btnPrimaryColors,
    required this.btnPrimaryText,
    required this.btnDanger,
    required this.btnDangerText,
    required this.btnCravingColors,
    required this.btnCravingText,
    required this.btnCravingGlow,
    required this.btnSecondary,
    required this.btnSecondaryText,
    required this.progressBg,
    required this.progressFillColors,
    required this.progressGlow,
    required this.streakColor,
    required this.cardRadius,
    required this.hasCardBlur,
    required this.pageGradientColors,
  });

  bool get isForest => id == AppThemeId.forest;
  bool get isDew => id == AppThemeId.dew;
  bool get isVoltage => id == AppThemeId.voltage;

  ThemeData toMaterialTheme() {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: bgPage,
      colorScheme: ColorScheme.dark(
        primary: accentPrimary,
        secondary: accentGreen,
        surface: bgCard,
        error: accentDanger,
      ),
      textTheme: TextTheme(
        bodyMedium: TextStyle(color: textPrimary),
        bodySmall: TextStyle(color: textSecondary),
      ),
    );
  }
}

// ─── FOREST NIGHT ─────────────────────────────────────────────────────────────
const forestTheme = AppThemeConfig(
  id: AppThemeId.forest,
  name: 'Forest Night',
  tagline: 'Silent growth in darkness',
  emoji: '🌙',
  bgPage: Color(0xFF080F08),
  bgCard: Color(0x0F22C55E),
  bgCardBorder: Color(0x2E22C55E),
  bgCardGlow: Color(0x0A22C55E),
  bgInput: Color(0x1422C55E),
  textPrimary: Color(0xFFE8F5E8),
  textSecondary: Color(0xFF86EFAC),
  textMuted: Color(0x664ADE80),
  accentGreen: Color(0xFF22C55E),
  accentGreenLight: Color(0xFF4ADE80),
  accentAmber: Color(0xFFFBBF24),
  accentDanger: Color(0xFFF87171),
  accentDangerGlow: Color(0x66F87171),
  accentPrimary: Color(0xFF22C55E),
  accentPrimaryGlow: Color(0x5922C55E),
  trunkColor: Color(0xFF713F12),
  trunkColorWithered: Color(0xFF44403C),
  foliageBase: Color(0xFF14532D),
  foliageMid: Color(0xFF15803D),
  foliageLight: Color(0xFF22C55E),
  foliageWithered: Color(0xFF374151),
  foliageGlow: Color(0x4D22C55E),
  groundColor: Color(0xFF1A2E1A),
  successBg: Color(0x2622C55E),
  successText: Color(0xFF4ADE80),
  dangerBg: Color(0x1FF87171),
  dangerText: Color(0xFFF87171),
  btnPrimaryColors: [Color(0xFF15803D), Color(0xFF22C55E)],
  btnPrimaryText: Color(0xFFF0FDF4),
  btnDanger: Color(0x26F87171),
  btnDangerText: Color(0xFFF87171),
  btnCravingColors: [Color(0xFFB91C1C), Color(0xFFDC2626)],
  btnCravingText: Color(0xFFFEF2F2),
  btnCravingGlow: Color(0x80DC2626),
  btnSecondary: Color(0x1A22C55E),
  btnSecondaryText: Color(0xFF86EFAC),
  progressBg: Color(0x4422C55E),
  progressFillColors: [Color(0xFF15803D), Color(0xFF22C55E)],
  progressGlow: Color(0x6622C55E),
  streakColor: Color(0xFFFBBF24),
  cardRadius: 20.0,
  hasCardBlur: true,
  pageGradientColors: [Color(0xFF080F08), Color(0xFF0D1A0D), Color(0xFF080F08)],
);

// ─── MORNING FIELD (dew) ──────────────────────────────────────────────────────
const dewTheme = AppThemeConfig(
  id: AppThemeId.dew,
  name: 'Morning Field',
  tagline: 'Gentle growth every day',
  emoji: '🌸',
  bgPage: Color(0xFFF4FBF0),
  bgCard: Color(0xFFFFFFFF),
  bgCardBorder: Color(0x12000000),
  bgCardGlow: Color(0x00000000),
  bgInput: Color(0xFFF1F8EE),
  textPrimary: Color(0xFF1A2E1A),
  textSecondary: Color(0xFF3F6B38),
  textMuted: Color(0xFF94A891),
  accentGreen: Color(0xFF15803D),
  accentGreenLight: Color(0xFF4ADE80),
  accentAmber: Color(0xFFD97706),
  accentDanger: Color(0xFFDC2626),
  accentDangerGlow: Color(0x33DC2626),
  accentPrimary: Color(0xFF16A34A),
  accentPrimaryGlow: Color(0x3316A34A),
  trunkColor: Color(0xFF92400E),
  trunkColorWithered: Color(0xFF78716C),
  foliageBase: Color(0xFF14532D),
  foliageMid: Color(0xFF16A34A),
  foliageLight: Color(0xFF4ADE80),
  foliageWithered: Color(0xFFA8A29E),
  foliageGlow: Color(0x00000000),
  groundColor: Color(0xFFD1FAE5),
  successBg: Color(0xFFF0FDF4),
  successText: Color(0xFF15803D),
  dangerBg: Color(0xFFFEF2F2),
  dangerText: Color(0xFFDC2626),
  btnPrimaryColors: [Color(0xFF16A34A), Color(0xFF22C55E)],
  btnPrimaryText: Color(0xFFFFFFFF),
  btnDanger: Color(0xFFFEF2F2),
  btnDangerText: Color(0xFFDC2626),
  btnCravingColors: [Color(0xFFD97706), Color(0xFFF59E0B)],
  btnCravingText: Color(0xFFFFFFFF),
  btnCravingGlow: Color(0x00000000),
  btnSecondary: Color(0xFFF1F8EE),
  btnSecondaryText: Color(0xFF3F6B38),
  progressBg: Color(0xFFD1EAC8),
  progressFillColors: [Color(0xFF16A34A), Color(0xFF4ADE80)],
  progressGlow: Color(0x00000000),
  streakColor: Color(0xFFD97706),
  cardRadius: 24.0,
  hasCardBlur: false,
  pageGradientColors: [Color(0xFFF4FBF0), Color(0xFFE8F7E0)],
);

// ─── VOLTAGE ──────────────────────────────────────────────────────────────────
const voltageTheme = AppThemeConfig(
  id: AppThemeId.voltage,
  name: 'Voltage',
  tagline: 'Power through every urge',
  emoji: '⚡',
  bgPage: Color(0xFF080812),
  bgCard: Color(0x148B5CF6),
  bgCardBorder: Color(0x4D8B5CF6),
  bgCardGlow: Color(0x0D8B5CF6),
  bgInput: Color(0x1A8B5CF6),
  textPrimary: Color(0xFFF8FAFC),
  textSecondary: Color(0xFFC4B5FD),
  textMuted: Color(0x667C3AED),
  accentGreen: Color(0xFF10B981),
  accentGreenLight: Color(0xFF34D399),
  accentAmber: Color(0xFF22D3EE),
  accentDanger: Color(0xFFF97316),
  accentDangerGlow: Color(0x66F97316),
  accentPrimary: Color(0xFF8B5CF6),
  accentPrimaryGlow: Color(0x668B5CF6),
  trunkColor: Color(0xFF4C1D95),
  trunkColorWithered: Color(0xFF374151),
  foliageBase: Color(0xFF064E3B),
  foliageMid: Color(0xFF059669),
  foliageLight: Color(0xFF34D399),
  foliageWithered: Color(0xFF374151),
  foliageGlow: Color(0x6634D399),
  groundColor: Color(0xFF1E1B4B),
  successBg: Color(0x2610B981),
  successText: Color(0xFF34D399),
  dangerBg: Color(0x1FF97316),
  dangerText: Color(0xFFF97316),
  btnPrimaryColors: [Color(0xFF6D28D9), Color(0xFF8B5CF6)],
  btnPrimaryText: Color(0xFFFFFFFF),
  btnDanger: Color(0x26F97316),
  btnDangerText: Color(0xFFF97316),
  btnCravingColors: [Color(0xFFC2410C), Color(0xFFF97316)],
  btnCravingText: Color(0xFFFFFFFF),
  btnCravingGlow: Color(0x80F97316),
  btnSecondary: Color(0x268B5CF6),
  btnSecondaryText: Color(0xFFC4B5FD),
  progressBg: Color(0x448B5CF6),
  progressFillColors: [Color(0xFF6D28D9), Color(0xFF8B5CF6), Color(0xFF22D3EE)],
  progressGlow: Color(0x808B5CF6),
  streakColor: Color(0xFF22D3EE),
  cardRadius: 16.0,
  hasCardBlur: true,
  pageGradientColors: [Color(0xFF080812), Color(0xFF0D0D1F), Color(0xFF080812)],
);

const Map<AppThemeId, AppThemeConfig> allThemes = {
  AppThemeId.forest: forestTheme,
  AppThemeId.dew: dewTheme,
  AppThemeId.voltage: voltageTheme,
};

