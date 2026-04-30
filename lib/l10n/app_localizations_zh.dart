import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appName => '动力树';

  @override
  String get tagline => '与你的动力一起成长';

  @override
  String get themeForestNight => '森林夜晚';

  @override
  String get themeForestNightTagline => '黑暗中的静默成长';

  @override
  String get themeMorningField => '晨间田野';

  @override
  String get themeMorningFieldTagline => '每天温柔成长';

  @override
  String get themeVoltage => '电压';

  @override
  String get themeVoltageTagline => '突破每一次冲动';

  @override
  String get streak => '连续天数';

  @override
  String get momentum => '动力值';

  @override
  String get days => '天';

  @override
  String get pts => '分';

  @override
  String get totalDays => '总天数';

  @override
  String get resisted => '抵制次数';

  @override
  String get relapses => '复发次数';

  @override
  String get stageSeedling => '🌱 幼苗';

  @override
  String get stageSapling => '🌿 树苗';

  @override
  String get stageYoungTree => '🌳 小树';

  @override
  String get stageFullGrove => '🌲 森林';

  @override
  String get stageDescSeedling => '刚刚发芽——每一天都很重要。';

  @override
  String get stageDescSapling => '正在扎根——继续坚持！';

  @override
  String get stageDescYoungTree => '向阳而生——就快到了！';

  @override
  String get stageDescFullGrove => '一片繁茂的树林——太棒了！';

  @override
  String get stageWitheredDesc => '树需要恢复才能继续生长';

  @override
  String get withered => '✦ 枯萎';

  @override
  String ptsToSapling(int pts) {
    return '距树苗还需 $pts 分';
  }

  @override
  String ptsToYoungTree(int pts) {
    return '距小树还需 $pts 分';
  }

  @override
  String ptsToFullGrove(int pts) {
    return '距森林还需 $pts 分';
  }

  @override
  String get treeWithered => '你的树枯萎了。恢复它以继续成长。';

  @override
  String get freeRecovery => '🌿 免费恢复';

  @override
  String get watchAd => '☀️ 观看广告';

  @override
  String get dailyCheckIn => '今日打卡';

  @override
  String get checkInDone => '✓ 已完成';

  @override
  String get checkInTomorrow => '明天再来打卡吧 🌙';

  @override
  String get heldStrong => '我坚持了';

  @override
  String get slipped => '我失控了';

  @override
  String get heldStrongPts => '+10 分';

  @override
  String get slippedPts => '−15 分';

  @override
  String get iHaveACraving => '我有冲动';

  @override
  String get tapToStart => '点击启动 60 秒倒计时';

  @override
  String get howDidTodayGo => '今天怎么样？';

  @override
  String get iHeldStrongToday => '✓ 我今天坚持住了（+10 分）';

  @override
  String get iBrokeMyStreak => '✗ 我打破了连续记录（−15 分）';

  @override
  String get cancel => '取消';

  @override
  String get cravingShieldTitle => '守住这一刻';

  @override
  String get cravingShieldSubtitle => '点击启动 60 秒冲动抵御计时器';

  @override
  String get seconds => '秒';

  @override
  String get startTimer => '🌿 开始计时';

  @override
  String get iHeldOn => '💪 我坚持住了！（+5 分）';

  @override
  String get iGaveIn => '我失控了（−15 分）';

  @override
  String get iGaveInPts => '我还是失控了（−15 分）';

  @override
  String get exitWithoutPenalty => '无惩罚退出';

  @override
  String get youHeldIt => '你坚持住了！';

  @override
  String get breatheIn => '慢慢吸气...';

  @override
  String get hold => '屏住...';

  @override
  String get breatheOut => '缓缓呼气...';

  @override
  String get mot1 => '你比这股冲动更强大。';

  @override
  String get mot2 => '这种感觉几分钟内就会过去。';

  @override
  String get mot3 => '未来的你会感谢现在的你。';

  @override
  String get mot4 => '每一秒坚持都是一次胜利。';

  @override
  String get mot5 => '不适是暂时的，进步是永久的。';

  @override
  String get mot6 => '冲动如波浪——乘风而过。';

  @override
  String get mot7 => '你的树在指望你。';

  @override
  String timerDuration(int secs) {
    return '计时时长：$secs 秒';
  }

  @override
  String get resultSuccessTitle => '打卡成功！+10 分';

  @override
  String get resultSuccessTitleBonus => '连击加成！+13 分';

  @override
  String resultSuccessSubtitle(int streak) {
    return '你已连续坚持 $streak 天，继续加油！';
  }

  @override
  String get resultRelapseTitle => '没关系，重新开始';

  @override
  String get resultRelapseSubtitle => '每位大师都曾经是初学者。使用恢复功能治愈你的树。';

  @override
  String get resultCravingResistTitle => '你抵制成功！+5 分';

  @override
  String get resultCravingResistSubtitle => '这需要真正的意志力。你越来越强大了。';

  @override
  String get resultCravingYieldTitle => '这次冲动赢了';

  @override
  String get resultCravingYieldSubtitle => '这是过程的一部分。使用恢复功能，再次尝试。';

  @override
  String get streakBonusMsg => '每连续 3 天额外获得 +3 分。你正在冲刺！';

  @override
  String get freeRecoveryAvailable => '🌿 今天你有一次免费恢复机会。';

  @override
  String get watchAdRecover => '☀️ 观看广告可恢复你的树。';

  @override
  String get backToHome => '返回首页';

  @override
  String get stage => '阶段';

  @override
  String get settings => '设置';

  @override
  String get chooseTheme => '选择你的风格';

  @override
  String get themeDescription => '选择最适合你旅程的视觉风格，随时可以更改。';

  @override
  String activate(String name) {
    return '使用$name风格';
  }

  @override
  String get backToApp => '← 返回应用';

  @override
  String get privacyPolicy => '隐私协议';

  @override
  String get language => '语言';

  @override
  String get selectLanguage => '选择语言';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageChinese => '中文';

  @override
  String get timerSettings => '计时器设置';

  @override
  String get forestDesc => '深夜森林氛围，玻璃拟态卡片，翠绿光晕效果。最适合夜间使用。';

  @override
  String get dewDesc => '柔和的白色卡片与温暖绿色设计。适合日常温和的治愈练习。';

  @override
  String get voltageDesc => '高能量游戏化界面，霓虹紫色和青色高光。为想要把自律变成升级体验的用户设计。';
}
