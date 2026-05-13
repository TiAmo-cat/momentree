import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Momentree';

  @override
  String get tagline => 'Habit & Urge Tracker';

  @override
  String get themeForestNight => 'Forest Night';

  @override
  String get themeForestNightTagline => 'Silent growth in darkness';

  @override
  String get themeMorningField => 'Morning Field';

  @override
  String get themeMorningFieldTagline => 'Gentle growth every day';

  @override
  String get themeVoltage => 'Voltage';

  @override
  String get themeVoltageTagline => 'Power through every urge';

  @override
  String get streak => 'Streak';

  @override
  String get momentum => 'Growth';

  @override
  String get days => 'days';

  @override
  String get pts => 'pts';

  @override
  String get totalDays => 'Total Days';

  @override
  String get resisted => 'Resisted';

  @override
  String get relapses => 'Relapses';

  @override
  String get stageSeedling => '🌱 Seedling';

  @override
  String get stageSapling => '🌿 Sapling';

  @override
  String get stageYoungTree => '🌳 Young Tree';

  @override
  String get stageFullGrove => '🌲 Full Grove';

  @override
  String get stageDescSeedling => 'Just sprouting — every day counts.';

  @override
  String get stageDescSapling => 'Growing roots — keep going!';

  @override
  String get stageDescYoungTree => 'Reaching for light — so close!';

  @override
  String get stageDescFullGrove => 'A mighty grove — incredible!';

  @override
  String get stageWitheredDesc => 'Tree needs recovery to grow again';

  @override
  String get withered => '✦ Withered';

  @override
  String ptsToSapling(int pts) {
    return '$pts pts to Sapling';
  }

  @override
  String ptsToYoungTree(int pts) {
    return '$pts pts to Young Tree';
  }

  @override
  String ptsToFullGrove(int pts) {
    return '$pts pts to Full Grove';
  }

  @override
  String get treeWithered => 'Your tree is withered. Restore it to continue growing.';

  @override
  String get freeRecovery => '🌿 Free Recovery';

  @override
  String get watchAd => '☀️ Watch Ad';

  @override
  String get dailyCheckIn => 'Today\'s Check-In';

  @override
  String get checkInDone => '✓ Done';

  @override
  String get checkInTomorrow => 'Come back tomorrow to check in again 🌙';

  @override
  String get heldStrong => 'Held Strong';

  @override
  String get slipped => 'I Slipped';

  @override
  String get heldStrongPts => '+10 pts';

  @override
  String get slippedPts => '−15 pts';

  @override
  String get iHaveACraving => 'I\'m having a craving';

  @override
  String get tapToStart => 'Tap to start your 60-second hold timer';

  @override
  String get howDidTodayGo => 'How did today go?';

  @override
  String get iHeldStrongToday => '✓ I held strong today (+10 pts)';

  @override
  String get iBrokeMyStreak => '✗ I broke my streak (−15 pts)';

  @override
  String get cancel => 'Cancel';

  @override
  String get cravingShieldTitle => 'Hold the moment';

  @override
  String get cravingShieldSubtitle => 'Tap to start your 60-second hold timer';

  @override
  String get seconds => 'seconds';

  @override
  String get startTimer => '🌿 Start holding';

  @override
  String get iHeldOn => '💪 I held on! (+5 pts)';

  @override
  String get iGaveIn => 'I gave in (−15 pts)';

  @override
  String get iGaveInPts => 'I gave in anyway (−15 pts)';

  @override
  String get exitWithoutPenalty => 'Exit without penalty';

  @override
  String get youHeldIt => 'You held it!';

  @override
  String get breatheIn => 'Breathe in slowly...';

  @override
  String get hold => 'Hold...';

  @override
  String get breatheOut => 'Breathe out gently...';

  @override
  String get mot1 => 'You are stronger than this urge.';

  @override
  String get mot2 => 'This feeling will pass in minutes.';

  @override
  String get mot3 => 'Your future self will thank you.';

  @override
  String get mot4 => 'Each second you hold on is a victory.';

  @override
  String get mot5 => 'Discomfort is temporary. Progress is permanent.';

  @override
  String get mot6 => 'The urge is a wave — ride it out.';

  @override
  String get mot7 => 'Your tree is counting on you.';

  @override
  String timerDuration(int secs) {
    return 'Timer duration: ${secs}s';
  }

  @override
  String get resultSuccessTitle => 'Checked In! +10 pts';

  @override
  String get resultSuccessTitleBonus => 'Streak Bonus! +13 pts';

  @override
  String resultSuccessSubtitle(int streak) {
    return 'You\'re on a $streak-day streak. Keep going!';
  }

  @override
  String get resultRelapseTitle => 'It\'s okay to start again';

  @override
  String get resultRelapseSubtitle => 'Every master was once a beginner. Use recovery to heal your tree.';

  @override
  String get resultCravingResistTitle => 'You resisted! +5 pts';

  @override
  String get resultCravingResistSubtitle => 'That took real strength. You\'re getting stronger.';

  @override
  String get resultCravingYieldTitle => 'The urge won this time';

  @override
  String get resultCravingYieldSubtitle => 'It\'s part of the process. Use your recovery and try again.';

  @override
  String get streakBonusMsg => 'Every 3-day streak earns a bonus +3 pts. You\'re on a roll!';

  @override
  String get freeRecoveryAvailable => '🌿 You have a free recovery available today.';

  @override
  String get watchAdRecover => '☀️ You can restore your tree by watching an ad.';

  @override
  String get backToHome => 'Back to home';

  @override
  String get stage => 'Stage';

  @override
  String get settings => 'Settings';

  @override
  String get chooseTheme => 'Choose your style';

  @override
  String get themeDescription => 'Choose the visual style that resonates with your journey. You can change this anytime.';

  @override
  String activate(String name) {
    return 'Use $name style';
  }

  @override
  String get backToApp => '← Back to app';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get language => 'Language';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageChinese => '中文';

  @override
  String get timerSettings => 'Timer Settings';

  @override
  String get forestDesc => 'Deep forest atmosphere with glass-morphism cards, emerald glows, and elegant typography. Best for evening use.';

  @override
  String get dewDesc => 'Soft, breathable design with white cards and warm greens. Ideal for a gentle, therapeutic daily practice.';

  @override
  String get voltageDesc => 'High-energy gamified interface with neon violet and cyan accents. Designed for users who want discipline to feel like leveling up.';
}
