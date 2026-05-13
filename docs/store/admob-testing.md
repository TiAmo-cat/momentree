# AdMob 测试说明

## 当前配置

- `USE_REAL_ADS` 默认是 `false`
- Android 默认使用 Google 官方测试广告位
- 激励广告只有在 `onUserEarnedReward` 回调成功后才会发放奖励
- Android App ID 已写入 [AndroidManifest.xml](/D:/projects/demo/momentree/android/app/src/main/AndroidManifest.xml)
- iOS 目前仍使用 Google 官方测试 App ID，等你以后创建 iOS 的 AdMob 应用后再替换

## 本地如何跑测试广告

直接正常运行即可：

```powershell
fvm flutter run
```

预期表现：

- 首页底部显示 Google 测试 Banner
- 树木恢复按钮会尝试加载激励测试广告
- 激励广告完整看完后，才会发放恢复奖励

## 如何跑真实广告

只建议在你自己的设备上做少量最终验证，不要反复点击：

```powershell
fvm flutter run --dart-define=USE_REAL_ADS=true
```

## 国内网络的现实情况

AdMob 依赖 Google 服务。在中国大陆网络环境下，常见情况包括：

- 测试广告加载失败
- 激励广告长时间转圈或直接不出现
- Banner 没有填充但页面本身仍正常

这通常是网络可达性问题，不一定是代码问题。

## 最实用的测试顺序

1. 先在国内网络验证页面不崩、按钮流程正常
2. 如果广告不出，再切到能访问 Google 服务的网络
3. 用真实 Android 手机测试，确认设备有 Google Play 服务
4. 反复调试时只用测试广告
5. 真实广告只做一次小范围冒烟验证

## 什么才算通过

- App 能正常启动
- Banner 加载失败时页面布局不乱
- 激励广告失败时不会错误发奖励
- 激励广告成功后才恢复树和分数
- 恢复按钮在广告不可用时能优雅失败

## 后续建议

正式上架前，建议补充 EEA/UK 用户的广告同意流程，也就是 Google UMP。
