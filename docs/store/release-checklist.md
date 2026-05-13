# 发布检查清单

## 代码与构建

- App 名称已统一为 Momentree
- Android AdMob App ID 已配置
- Banner 广告已接入
- 激励广告恢复流程已接入
- Android `minSdk` 已提升到 `23`
- 需要你本机再跑一次最终 release 构建

## 正式启用真实广告前

- 如果以后要上 iOS，需要补真实 iOS AdMob App ID
- 建议补 EEA/UK 的 UMP 同意流程
- 用真实 Android 设备验证激励广告奖励回调
- 验证广告失败时不会错误发奖励

## Play Console 需要准备的内容

- 标题
- 简短描述
- 完整描述
- 应用图标
- 截图
- 隐私政策链接
- 支持邮箱
- Data safety 表单
- 内容分级问卷

## Data safety 表单建议

你大概率需要声明：

- App activity
- Device or other identifiers

原因：

- AdMob 广告及其相关诊断、投放、衡量能力

同时可以强调：

- App 主要把进度数据存本地
- 不需要账号注册

## 最终 QA

- 首次启动
- 主题选择
- 成功打卡
- 失败流程
- 冲动计时器完成
- 激励广告恢复成功
- Banner 有广告和没广告两种情况
- 中英文切换
- 离线表现

## 我这边建议你下一步立刻做的事

1. 在能访问 Google 服务的网络下测试一次测试广告
2. 跑一次 Android release 包
3. 准备最终图标 PNG 和 6 张截图
4. 把 `web/privacy.html` 和 `web/support.html` 部署成真实可访问链接
