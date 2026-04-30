# 🌳 Momentum App - UI Design Driven Dev Spec (V2.0)

---

# 一、产品核心不变

```text id="core_001"
Momentum = 戒断成长系统 + 冲动干预 + 树木成长 + 可恢复机制
```

---

# 二、UI系统（核心变化）

应用支持 3 种视觉风格，可在 Settings 中切换：

---

# 2.1 🌲 Forest Night（默认风格）

## 🌌 视觉定义

```text id="ui_001"
- 深夜森林氛围
- glassmorphism 卡片
- emerald green glow
- Playfair Display 标题字体
```

## 🎨 设计关键词

* 深绿色背景
* 发光边框
* 模糊玻璃卡片
* 情绪：安静 / 克制 / 内省

---

## 📱 UI表现（对应Home）

```text id="ui_002"
- STREAK / MOMENTUM 卡片（玻璃态）
- 中央发光树（绿色 glow）
- 红色“craving button”
- 深色背景 + 星点粒子
```

---

## 🎯 适用场景

```text id="ui_003"
✔ 夜间使用
✔ 强克制用户
✔ 情绪控制
```

---

# 2.2 🌸 Morning Field

## 🌤 视觉定义

```text id="ui_004"
- 明亮治愈风
- 白色/浅米色背景
- 柔和阴影卡片
- 温暖橙色强调
```

---

## 🎨 设计关键词

* 白底 / 浅暖背景
* 圆润卡片
* soft shadow
* 情绪：轻松 / 日常 / 正向

---

## 📱 UI表现

```text id="ui_005"
- 白色卡片 STREAK / MOMENTUM
- 绿色小树 + 柔光
- 橙色按钮（craving）
- 空间感更大
```

---

## 🎯 适用场景

```text id="ui_006"
✔ 日常打卡
✔ 新用户
✔ 低压力体验
```

---

# 2.3 ⚡ Voltage

## ⚡ 视觉定义

```text id="ui_007"
- 深蓝紫科技风
- neon glow（青蓝/紫）
- 高对比UI
- 动态能量感
```

---

## 🎨 设计关键词

* dark navy background
* neon cyan / purple glow
* cyber feel
* 情绪：驱动 / 能量 / 冲击

---

## 📱 UI表现

```text id="ui_008"
- MOMENTUM 发光进度条
- 紫色能量树
- 橙色高对比按钮
- UI有轻微 pulse 动效
```

---

## 🎯 适用场景

```text id="ui_009"
✔ 高强度用户
✔ 游戏化体验
✔ 成就驱动
```

---

# 三、核心页面 UI结构（统一逻辑）

---

# 3.1 Home Page（所有风格共用结构）

```text id="home_001"
--------------------------------
TOP AREA
Day X
Momentum Value

--------------------------------
TREE AREA（核心）
根据 style 渲染不同 tree skin

--------------------------------
STREAK / MOMENTUM CARDS
（glass / soft / neon）

--------------------------------
ACTION AREA
✔ Success
❌ Fail
🔥 Craving

--------------------------------
BOTTOM
Banner Ad
```

---

# 3.2 Tree 系统（统一逻辑 + 视觉适配）

## 核心规则不变：

```text id="tree_001"
momentum → tree stage
```

---

## 🌱 树状态

| Momentum | 表现     |
| -------- | ------ |
| 0-20     | seed   |
| 20-50    | sprout |
| 50-100   | tree   |
| 100+     | forest |

---

## 🌌 Style适配

### Forest Night

* glow green
* soft particles

### Morning Field

* soft natural green
* warm sunlight

### Voltage

* neon cyan/purple
* energy pulse animation

---

# 四、Craving（冲动页面 UI）

---

## 统一结构

```text id="crave_001"
CENTER
60s Countdown

TEXT
"Craving is temporary"

BUTTONS
✔ I held strong
❌ I gave in
```

---

## 风格适配

### 🌲 Forest Night

* dark blur background
* soft glow timer

### 🌸 Morning Field

* white background
* gentle fade animation

### ⚡ Voltage

* pulsing neon ring
* high energy timer animation

---

# 五、Settings（新增：Theme Switch）

---

## UI结构

```text id="settings_001"
Theme Selection

[ Forest Night ] 🌲
[ Morning Field ] 🌸
[ Voltage ] ⚡
```

---

## 切换逻辑

```text id="settings_002"
ThemeController.currentTheme = selectedStyle
→ rebuild MaterialApp theme
→ rebuild all UI
```

---

# 六、视觉系统规则（非常重要）

---

## 1️⃣ UI不改变功能，只改变表现

```text id="rule_001"
✔ 数据逻辑完全一致
✔ UI只是皮肤层
```

---

## 2️⃣ 所有状态统一

```text id="rule_002"
streak / momentum / tree → 三套UI共享
```

---

## 3️⃣ 动画统一原则

```text id="rule_003"
Forest → calm animation
Morning → soft fade
Voltage → pulse / glow
```

---

# 七、广告UI规则

---

## 位置统一

```text id="ad_001"
Home bottom only
```

---

## 风格适配

| Style   | 广告风格   |
| ------- | ------ |
| Forest  | 半透明玻璃  |
| Morning | 白色卡片   |
| Voltage | neon边框 |

---

# 八、UI设计核心理念（非常重要）

---

## 1️⃣ 情绪驱动UI

```text id="ph_001"
UI = 用户当前心理状态映射
```

---

## 2️⃣ 三种人格模式

```text id="ph_002"
Forest → 内省
Morning → 日常
Voltage → 冲刺
```

---

## 3️⃣ UI不只是风格，是行为强化

```text id="ph_003"
视觉 → 决定用户是否继续使用
```

---

# 九、最终产品定义（UI版本）

```text id="final_001"
一个通过三种视觉人格系统（Forest / Morning / Voltage），将用户自律行为具象化为“树木成长”的戒断应用
```

---
