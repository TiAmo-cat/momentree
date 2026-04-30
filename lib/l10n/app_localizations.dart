import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Momentum'**
  String get appName;

  /// No description provided for @tagline.
  ///
  /// In en, this message translates to:
  /// **'Grow with your momentum'**
  String get tagline;

  /// No description provided for @themeForestNight.
  ///
  /// In en, this message translates to:
  /// **'Forest Night'**
  String get themeForestNight;

  /// No description provided for @themeForestNightTagline.
  ///
  /// In en, this message translates to:
  /// **'Silent growth in darkness'**
  String get themeForestNightTagline;

  /// No description provided for @themeMorningField.
  ///
  /// In en, this message translates to:
  /// **'Morning Field'**
  String get themeMorningField;

  /// No description provided for @themeMorningFieldTagline.
  ///
  /// In en, this message translates to:
  /// **'Gentle growth every day'**
  String get themeMorningFieldTagline;

  /// No description provided for @themeVoltage.
  ///
  /// In en, this message translates to:
  /// **'Voltage'**
  String get themeVoltage;

  /// No description provided for @themeVoltageTagline.
  ///
  /// In en, this message translates to:
  /// **'Power through every urge'**
  String get themeVoltageTagline;

  /// No description provided for @streak.
  ///
  /// In en, this message translates to:
  /// **'Streak'**
  String get streak;

  /// No description provided for @momentum.
  ///
  /// In en, this message translates to:
  /// **'Momentum'**
  String get momentum;

  /// No description provided for @days.
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get days;

  /// No description provided for @pts.
  ///
  /// In en, this message translates to:
  /// **'pts'**
  String get pts;

  /// No description provided for @totalDays.
  ///
  /// In en, this message translates to:
  /// **'Total Days'**
  String get totalDays;

  /// No description provided for @resisted.
  ///
  /// In en, this message translates to:
  /// **'Resisted'**
  String get resisted;

  /// No description provided for @relapses.
  ///
  /// In en, this message translates to:
  /// **'Relapses'**
  String get relapses;

  /// No description provided for @stageSeedling.
  ///
  /// In en, this message translates to:
  /// **'🌱 Seedling'**
  String get stageSeedling;

  /// No description provided for @stageSapling.
  ///
  /// In en, this message translates to:
  /// **'🌿 Sapling'**
  String get stageSapling;

  /// No description provided for @stageYoungTree.
  ///
  /// In en, this message translates to:
  /// **'🌳 Young Tree'**
  String get stageYoungTree;

  /// No description provided for @stageFullGrove.
  ///
  /// In en, this message translates to:
  /// **'🌲 Full Grove'**
  String get stageFullGrove;

  /// No description provided for @stageDescSeedling.
  ///
  /// In en, this message translates to:
  /// **'Just sprouting — every day counts.'**
  String get stageDescSeedling;

  /// No description provided for @stageDescSapling.
  ///
  /// In en, this message translates to:
  /// **'Growing roots — keep going!'**
  String get stageDescSapling;

  /// No description provided for @stageDescYoungTree.
  ///
  /// In en, this message translates to:
  /// **'Reaching for light — so close!'**
  String get stageDescYoungTree;

  /// No description provided for @stageDescFullGrove.
  ///
  /// In en, this message translates to:
  /// **'A mighty grove — incredible!'**
  String get stageDescFullGrove;

  /// No description provided for @stageWitheredDesc.
  ///
  /// In en, this message translates to:
  /// **'Tree needs recovery to grow again'**
  String get stageWitheredDesc;

  /// No description provided for @withered.
  ///
  /// In en, this message translates to:
  /// **'✦ Withered'**
  String get withered;

  /// No description provided for @ptsToSapling.
  ///
  /// In en, this message translates to:
  /// **'{pts} pts to Sapling'**
  String ptsToSapling(int pts);

  /// No description provided for @ptsToYoungTree.
  ///
  /// In en, this message translates to:
  /// **'{pts} pts to Young Tree'**
  String ptsToYoungTree(int pts);

  /// No description provided for @ptsToFullGrove.
  ///
  /// In en, this message translates to:
  /// **'{pts} pts to Full Grove'**
  String ptsToFullGrove(int pts);

  /// No description provided for @treeWithered.
  ///
  /// In en, this message translates to:
  /// **'Your tree is withered. Restore it to continue growing.'**
  String get treeWithered;

  /// No description provided for @freeRecovery.
  ///
  /// In en, this message translates to:
  /// **'🌿 Free Recovery'**
  String get freeRecovery;

  /// No description provided for @watchAd.
  ///
  /// In en, this message translates to:
  /// **'☀️ Watch Ad'**
  String get watchAd;

  /// No description provided for @dailyCheckIn.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Check-In'**
  String get dailyCheckIn;

  /// No description provided for @checkInDone.
  ///
  /// In en, this message translates to:
  /// **'✓ Done'**
  String get checkInDone;

  /// No description provided for @checkInTomorrow.
  ///
  /// In en, this message translates to:
  /// **'Come back tomorrow to check in again 🌙'**
  String get checkInTomorrow;

  /// No description provided for @heldStrong.
  ///
  /// In en, this message translates to:
  /// **'Held Strong'**
  String get heldStrong;

  /// No description provided for @slipped.
  ///
  /// In en, this message translates to:
  /// **'I Slipped'**
  String get slipped;

  /// No description provided for @heldStrongPts.
  ///
  /// In en, this message translates to:
  /// **'+10 pts'**
  String get heldStrongPts;

  /// No description provided for @slippedPts.
  ///
  /// In en, this message translates to:
  /// **'−15 pts'**
  String get slippedPts;

  /// No description provided for @iHaveACraving.
  ///
  /// In en, this message translates to:
  /// **'I\'m having a craving'**
  String get iHaveACraving;

  /// No description provided for @tapToStart.
  ///
  /// In en, this message translates to:
  /// **'Tap to start your 60-second hold timer'**
  String get tapToStart;

  /// No description provided for @howDidTodayGo.
  ///
  /// In en, this message translates to:
  /// **'How did today go?'**
  String get howDidTodayGo;

  /// No description provided for @iHeldStrongToday.
  ///
  /// In en, this message translates to:
  /// **'✓ I held strong today (+10 pts)'**
  String get iHeldStrongToday;

  /// No description provided for @iBrokeMyStreak.
  ///
  /// In en, this message translates to:
  /// **'✗ I broke my streak (−15 pts)'**
  String get iBrokeMyStreak;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @cravingShieldTitle.
  ///
  /// In en, this message translates to:
  /// **'Hold the moment'**
  String get cravingShieldTitle;

  /// No description provided for @cravingShieldSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tap to start your 60-second hold timer'**
  String get cravingShieldSubtitle;

  /// No description provided for @seconds.
  ///
  /// In en, this message translates to:
  /// **'seconds'**
  String get seconds;

  /// No description provided for @startTimer.
  ///
  /// In en, this message translates to:
  /// **'🌿 Start holding'**
  String get startTimer;

  /// No description provided for @iHeldOn.
  ///
  /// In en, this message translates to:
  /// **'💪 I held on! (+5 pts)'**
  String get iHeldOn;

  /// No description provided for @iGaveIn.
  ///
  /// In en, this message translates to:
  /// **'I gave in (−15 pts)'**
  String get iGaveIn;

  /// No description provided for @iGaveInPts.
  ///
  /// In en, this message translates to:
  /// **'I gave in anyway (−15 pts)'**
  String get iGaveInPts;

  /// No description provided for @exitWithoutPenalty.
  ///
  /// In en, this message translates to:
  /// **'Exit without penalty'**
  String get exitWithoutPenalty;

  /// No description provided for @youHeldIt.
  ///
  /// In en, this message translates to:
  /// **'You held it!'**
  String get youHeldIt;

  /// No description provided for @breatheIn.
  ///
  /// In en, this message translates to:
  /// **'Breathe in slowly...'**
  String get breatheIn;

  /// No description provided for @hold.
  ///
  /// In en, this message translates to:
  /// **'Hold...'**
  String get hold;

  /// No description provided for @breatheOut.
  ///
  /// In en, this message translates to:
  /// **'Breathe out gently...'**
  String get breatheOut;

  /// No description provided for @mot1.
  ///
  /// In en, this message translates to:
  /// **'You are stronger than this urge.'**
  String get mot1;

  /// No description provided for @mot2.
  ///
  /// In en, this message translates to:
  /// **'This feeling will pass in minutes.'**
  String get mot2;

  /// No description provided for @mot3.
  ///
  /// In en, this message translates to:
  /// **'Your future self will thank you.'**
  String get mot3;

  /// No description provided for @mot4.
  ///
  /// In en, this message translates to:
  /// **'Each second you hold on is a victory.'**
  String get mot4;

  /// No description provided for @mot5.
  ///
  /// In en, this message translates to:
  /// **'Discomfort is temporary. Progress is permanent.'**
  String get mot5;

  /// No description provided for @mot6.
  ///
  /// In en, this message translates to:
  /// **'The urge is a wave — ride it out.'**
  String get mot6;

  /// No description provided for @mot7.
  ///
  /// In en, this message translates to:
  /// **'Your tree is counting on you.'**
  String get mot7;

  /// No description provided for @timerDuration.
  ///
  /// In en, this message translates to:
  /// **'Timer duration: {secs}s'**
  String timerDuration(int secs);

  /// No description provided for @resultSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Checked In! +10 pts'**
  String get resultSuccessTitle;

  /// No description provided for @resultSuccessTitleBonus.
  ///
  /// In en, this message translates to:
  /// **'Streak Bonus! +13 pts'**
  String get resultSuccessTitleBonus;

  /// No description provided for @resultSuccessSubtitle.
  ///
  /// In en, this message translates to:
  /// **'You\'re on a {streak}-day streak. Keep going!'**
  String resultSuccessSubtitle(int streak);

  /// No description provided for @resultRelapseTitle.
  ///
  /// In en, this message translates to:
  /// **'It\'s okay to start again'**
  String get resultRelapseTitle;

  /// No description provided for @resultRelapseSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Every master was once a beginner. Use recovery to heal your tree.'**
  String get resultRelapseSubtitle;

  /// No description provided for @resultCravingResistTitle.
  ///
  /// In en, this message translates to:
  /// **'You resisted! +5 pts'**
  String get resultCravingResistTitle;

  /// No description provided for @resultCravingResistSubtitle.
  ///
  /// In en, this message translates to:
  /// **'That took real strength. You\'re getting stronger.'**
  String get resultCravingResistSubtitle;

  /// No description provided for @resultCravingYieldTitle.
  ///
  /// In en, this message translates to:
  /// **'The urge won this time'**
  String get resultCravingYieldTitle;

  /// No description provided for @resultCravingYieldSubtitle.
  ///
  /// In en, this message translates to:
  /// **'It\'s part of the process. Use your recovery and try again.'**
  String get resultCravingYieldSubtitle;

  /// No description provided for @streakBonusMsg.
  ///
  /// In en, this message translates to:
  /// **'Every 3-day streak earns a bonus +3 pts. You\'re on a roll!'**
  String get streakBonusMsg;

  /// No description provided for @freeRecoveryAvailable.
  ///
  /// In en, this message translates to:
  /// **'🌿 You have a free recovery available today.'**
  String get freeRecoveryAvailable;

  /// No description provided for @watchAdRecover.
  ///
  /// In en, this message translates to:
  /// **'☀️ You can restore your tree by watching an ad.'**
  String get watchAdRecover;

  /// No description provided for @backToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to home'**
  String get backToHome;

  /// No description provided for @stage.
  ///
  /// In en, this message translates to:
  /// **'Stage'**
  String get stage;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @chooseTheme.
  ///
  /// In en, this message translates to:
  /// **'Choose your style'**
  String get chooseTheme;

  /// No description provided for @themeDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose the visual style that resonates with your journey. You can change this anytime.'**
  String get themeDescription;

  /// No description provided for @activate.
  ///
  /// In en, this message translates to:
  /// **'Use {name} style'**
  String activate(String name);

  /// No description provided for @backToApp.
  ///
  /// In en, this message translates to:
  /// **'← Back to app'**
  String get backToApp;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageChinese.
  ///
  /// In en, this message translates to:
  /// **'中文'**
  String get languageChinese;

  /// No description provided for @timerSettings.
  ///
  /// In en, this message translates to:
  /// **'Timer Settings'**
  String get timerSettings;

  /// No description provided for @forestDesc.
  ///
  /// In en, this message translates to:
  /// **'Deep forest atmosphere with glass-morphism cards, emerald glows, and elegant typography. Best for evening use.'**
  String get forestDesc;

  /// No description provided for @dewDesc.
  ///
  /// In en, this message translates to:
  /// **'Soft, breathable design with white cards and warm greens. Ideal for a gentle, therapeutic daily practice.'**
  String get dewDesc;

  /// No description provided for @voltageDesc.
  ///
  /// In en, this message translates to:
  /// **'High-energy gamified interface with neon violet and cyan accents. Designed for users who want discipline to feel like leveling up.'**
  String get voltageDesc;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'zh': return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
