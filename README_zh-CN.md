# fish-taskwarrior-cn

让 Taskwarrior 说中文 🗣️ — 用最自然的方式管理任务

[![GitHub stars](https://img.shields.io/github/stars/stephen9412/fish-taskwarrior-cn?style=social)](https://github.com/stephen9412/fish-taskwarrior-cn/stargazers)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![English](https://img.shields.io/badge/DOCS-English-blue)](./README.md)
[![繁體中文](https://img.shields.io/badge/DOCS-繁體中文-green)](./README_zh-TW.md)

> 💡 **觉得有用？给个 ⭐️ Star 吧！** 这是对开源作者最大的鼓励，也能让更多人发现这个项目。

## 🤔 为什么写这个？

用中文思考的时候，没人想切换输入法去拼 `due`、`scheduled`、`priority`，更没人记得「下周五」的英文是 `next Friday` 还是 `Friday next`。欧，对不起，我英文不够好。

[Taskwarrior](https://github.com/GothenburgBitFactory/taskwarrior) 是我调研多年后，唯一真正跨平台且完整实现 GTD 理念的命令行工具。强大归强大，但每次要输入英文关键字和日期就得切回英文模式，思绪瞬间被打断——这谁受得了？

所以我做了这个套件。**让你用母语的直觉管理任务，不再为了工具委屈自己的大脑。**

## 🚀 快速体验

![新增任务演示](.github/assets/add_task.gif)

安装后，你就可以这样用 Taskwarrior：

```fish
# 完全中文化的任务管理
task add 写周报 专案：工作 优先级：H 标签：文书 截止：这周五下午五点

# 修改任务（智能补全描述）
task mod 42<空格>  # 自动补全为: task mod 42 '原始描述'

# 等待类任务（让子弹飞一会儿）
task add 打电话给客户 让子弹飞到：三天后

# 循环任务
task add 周会 专案：团队 截止：下周一上午九点 循环：weekly

# 复杂的依赖关系
task add 整合测试 依赖：42 预估耗时：3小时 排程：明天下午两点
```

**语言支持：** 繁简通用。身在台湾，用语偏台式，但已尽量涵盖大陆与港澳的习惯写法。各地用语差异欢迎提 Issue 或 PR 补充（我真的不知道东北人怎么说「下周五」）。

## 📦 安装

### 使用 Fisher（推荐，省时省力）

```fish
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

fisher install stephen9412/fish-cn2int
fisher install stephen9412/fish-taskwarrior-cn
```

### 手动安装（喜欢自己来的硬派玩家）

```bash
curl -L https://raw.githubusercontent.com/stephen9412/fish-cn2int/refs/heads/main/functions/cn2int.fish \
     -o ~/.config/fish/functions/cn2int.fish

curl -L https://raw.githubusercontent.com/stephen9412/fish-taskwarrior-cn/main/functions/taskwarrior_parse_date.fish \
     -o ~/.config/fish/functions/taskwarrior_parse_date.fish

curl -L https://raw.githubusercontent.com/stephen9412/fish-taskwarrior-cn/main/conf.d/task.fish \
     -o ~/.config/fish/conf.d/task.fish
```

安装后重启 Fish Shell 或执行 `source ~/.config/fish/config.fish`。

完成！现在可以开始用中文管理任务了。

## ✨ 核心功能

### 🏷️ 中文关键字

所有 Taskwarrior 的属性都支持中文，**繁体简体皆可**：

| 中文（繁体） | 中文（简体） | 英文原文 | 说明 |
|------------|------------|----------|------|
| `專案：`、`項目：` | `专案：`、`项目：` | `project:` | 所属专案 |
| `優先：`、`優先級：`、`優先權：` | `优先：`、`优先级：`、`优先权：` | `priority:` | 优先级别（H/M/L） |
| `標籤：` | `标签：` | `tags:` | 标签（可多个） |
| `註解：` | `注解：` | `annotation:` | 注解说明 |
| `依賴：`、`依賴於：`、`卡在：` | `依赖：`、`依赖于：`、`卡在：` | `depends:` | 依赖其他任务 |
| `預估耗時：`、`預估時間：`、`耗時：` | `预估耗时：`、`预估时间：`、`耗时：` | `estimate:` | 预估所需时间 |
| `截止：`、`到期：`、`死線：`、`期限：` | `截止：`、`到期：`、`死线：`、`期限：` | `due:` | 截止时间 |
| `等待：`、`讓子彈飛到：` | `等待：`、`让子弹飞到：` | `wait:` | 等待直到某时间 |
| `排程：`、`預定：`、`預計：`、`計畫：`、`計劃：` | `排程：`、`预定：`、`预计：`、`计划：` | `scheduled:` | 计划开始时间 |
| `直到：`、`有效期：`、`過期：` | `直到：`、`有效期：`、`过期：` | `until:` | 有效期限 |
| `循環：`、`重複：`、`週期：` | `循环：`、`重复：`、`周期：` | `recur:` | 循环周期 |

**实际使用：**

```fish
# 一行搞定完整的任务属性
task add 实现新功能 专案：产品开发 优先级：H 标签：后端 标签：API 预估耗时：五小时 截止：下周三

# 依赖关系（这个任务卡在其他任务上）
task add 部署上线 依赖：42 卡在：43 排程：明天

# 等待任务（让子弹飞一会儿）
task add 追踪进度 让子弹飞到：三天后

# 循环任务
task add 备份数据库 循环：daily 排程：早上两点
```

**💡 小技巧：** 支持全形冒号（`：`）和半形冒号（`:`），不需要切换输入法！（再也不用在中英文之间疯狂切换了）

### ⌨️ 智能空格补全

![智能补全演示](.github/assets/modify_task.gif)

在修改任务时，按空格键会自动补全任务描述：

```fish
# 输入
task mod 42<空格>

# 自动展开为
task mod 42 '原始任务描述'
```

游标会自动停在引号内，方便你直接修改描述。不用再手动打开任务列表复制粘贴——效率直接起飞。

### 📅 中文日期时间

支持完整的中文日期时间表达，适用于所有时间相关字段：`due`、`wait`、`scheduled`、`until`、`entry`、`start`、`end`。

#### 基础别名

```fish
task add 开会 due:明天
task add 报告 due:后天
task add 清理 due:这周末
task add 检讨 due:月底
task add 规划 due:明年年初
```

**支持的别名：**
- 时间点：`現在`/`现在`、`昨天`、`今天`、`明天`、`後天`/`后天`、`大後天`/`大后天`
- 周末：`週末`/`周末`、`這週末`/`这周末`、`上週末`/`上周末`、`下週末`/`下周末`
- 周：`上週`/`上周`、`這週`/`这周`、`下週`/`下周`
- 月：`這個月`/`这个月`、`上個月`/`上个月`、`下個月`/`下个月`
- 月边界：`月初`、`月底`、`這個月初`/`这个月初`、`下個月底`/`下个月底`
- 年边界：`年初`、`年底`、`今年年初`、`明年年底`、`前年年初`、`去年年底`

#### 相对时间

```fish
task add 交作业 due:三天后
task add 会议 due:两小时后
task add 提醒 wait:半小时后
task add 备注 entry:十天前
```

**支持的单位：** 天、小时、分钟、秒，可以串接组合：

```fish
task add 紧急任务 due:三天后十二小时后三十分钟前
# 转换为: now+3d+12h-30min
```

#### 星期

```fish
task add 周会 due:周一
task add 健身 due:这周三
task add 聚餐 due:下周五
```

**支持：** `週`/`周`/`星期`/`禮拜`/`礼拜` + `一`～`日`/`天`

#### 日期

```fish
task add 发薪 due:15号
task add 缴费 due:这个月28号
task add 聚会 due:下个月5号
```

#### 完整日期时间

```fish
task add 早会 due:明天早上九点
task add 下午茶 due:今天下午三点半
task add 截止 due:这个月三十号下午两点二十九分
task add 发布 due:明年六月二十号早上九点十五分
```

**时段自动转换：**
- `早上`、`上午`：0-11 点
- `下午`、`晚上`：自动 +12 小时

**更多日期范例请见 [日期解析详细说明](#日期解析详细说明) 章节。**

### ⚙️ 智能日期校正

对于 `due` 和 `until` 字段，人们通常期望的是「那一天结束前」，而非「那一天开始」。

因此，这两个字段会**自动 +1 天**：

```fish
# 你输入
task add 交件 due:三天后

# 实际转换为
task add 交件 due:4d

# 语义：三天后的那一天结束前都可以交
# 不是三天后 00:00:00 就爆炸
```

**这个设计让日期语义更符合人类直觉**——毕竟没人会在凌晨准时交作业（除非你是肝帝）。

## ⚡ 内建别名与缩写

为了加速日常操作，套件内建了常用的别名和缩写（少打字就是多活几年）：

### 别名（Alias）

```fish
tl      # task list - 列出所有任务
ts      # task sync - 同步任务
tn      # task next - 显示接下来要做的任务
tnn     # task next limit:1 - 只显示最重要的一件事（专注力满分）
```

### 缩写（Abbreviation）

```fish
tm           # task mod - 修改任务
td           # task done - 完成任务（最爽的指令）
tsta         # task start - 开始任务
tsto         # task stop - 停止任务
tdel         # task delete - 删除任务
tctx         # task context - 切换情境
```

**使用范例：**

```fish
# 快速列出所有任务
tl

# 查看下一件最重要的事（专注力 100%）
tnn

# 完成任务 42（最爽的时刻）
td 42

# 开始处理任务 42
tsta 42

# 暂停任务 42（先去喝杯咖啡）
tsto 42

# 删除任务 42（算了不干了）
tdel 42
```

## 🔧 进阶配置：自动展开

> ### ⚠️ **重要：这不是预设功能！**
> 
> **本章节的所有缩写样板都需要你自己手动添加到 `~/.config/fish/config.fish`！**
> 
> 虽然本文反复提及这些用法，但请记住：**这些是给你的灵感和范例**，不是安装套件后就能用的。你必须根据自己的工作流程客制化专属的快捷键。
> 
> 复制粘贴下面的范例，然后改成你自己喜欢的样子吧！

将以下设定复制到你的 `~/.config/fish/config.fish`，建立自己的快速输入样板：

```fish
abbr --add --command task --set-cursor adda 'add "%" 专案： 优先级：L 标签：'

abbr --add --command task --set-cursor addw 'add "%" 专案：工作 优先级：H 标签：'

abbr --add --command task --set-cursor addl 'add "%" 专案：生活 优先级：L 标签：'

abbr --add --command task --set-cursor addp 'add "%" 专案： 优先级：M 截止：下周五 标签：'
```

**使用方式：**

```fish
# 输入
task adda<空格>

# 自动展开为
task add "%" 专案： 优先级：L 标签：
#           ↑ 游标停在这里，开始输入任务描述

# 然后按 Tab 跳到下一个字段，快速填写
```

**自订技巧（发挥你的创意）：**
1. 为不同优先级建立快捷样板（`addh` 高优先、`addl` 低优先、`addwtf` 紧急到爆）
2. 为常用专案建立专属缩写（`addreport` 周报、`addmeeting` 开会、`addcoffee` 摸鱼）
3. 使用 `--set-cursor` 配合 `%` 让游标自动定位（Fish shell 的神奇魔法）
4. 根据工作领域设计样板（工程师、设计师、PM、老板都有不同需求）

这个功能可以**极大提升任务输入效率**——一旦习惯了，你会回不去的。

## 📖 日期解析详细说明

本节深入说明中文日期时间的解析规则与进阶用法。

### 数字格式

支持中文数字、阿拉伯数字，甚至混用（随便你怎么打）：

```fish
task add 任务 due:一百零八天后        # 108天（龙珠梗？）
task add 任务 due:二十三号            # 23号
task add 任务 due:两小时后            # 2小时（两 = 2）
task add 任务 due:半小时后            # 30分钟
```

**支持的中文数字：**
- 基本：一、二、三、四、五、六、七、八、九、零
- 变体：兩/两、貳/贰、參/叁、肆、伍、陸/陆、柒、捌、玖（想耍文青也行）
- 单位：十、百、千、萬/万、億/亿（可以到「一亿天后」，但你活不到那天）
- 特殊：半（在时间中代表 30 分钟）

### 繁简混用

所有功能完整支持繁体和简体中文：

```fish
task add 工作 due:這週三下午三點      # 繁体
task add 工作 due:这周三下午三点      # 简体
task add 工作 due:这週三下午三点      # 混用（输入法切一半的受害者）
```

### 超出范围的数字（骚操作专区）

如果你喜欢挑战常识，这里有些骚操作：

```fish
task add 遥远的未来 due:星期三十
# → sow+29d（从周一算起第30天 = 约4周后）
# 没错，星期可以超过七天

task add 这个月一百八十号 due:这个月一百八十号
# → som+179d（从月初算起第180天 = 约6个月后）
# 谁说一个月只有31天？

task add 今年三十月 due:今年三十月
# → soy+29m（从年初算起第30个月 = 后年6月）
# 一年12个月？那是普通人的世界
```

**原理（其实很单纯）：**
- `星期N` 的 N 当作「从周一开始的第 N 天」（所以星期100也行）
- `N号` 的 N 当作「从月初开始的第 N 天」（月初往后数N天）
- `N月` 的 N 当作「从年初开始的第 N 个月」（年初往后数N个月）

这不是 bug，是 feature。有些特殊场景（比如「90天后」但你想用「三月九十号」来表达）会很好用。

### 语义验证

为避免歧义，以下格式会**原样返回**不解析（程序不猜，你也别猜）：

```fish
# ❌ 缺少单位
task add 任务 due:今年三月二十
# → 保持 "今年三月二十"（是20号？20个什么？不知道）

# ✅ 正确写法
task add 任务 due:今年三月二十号
# → soy+2m+19d（清清楚楚）

task add 任务 due:今年三月
# → soy+2m（这个没问题，就是三月）
```

**规则：每个数字后面都要有明确的单位**（號/号/日/月/年/天/小时/分/秒）。

不然程序会觉得你在说外星语。

### 转换对照表

对应 [GothenburgBitFactory/libshared](https://github.com/GothenburgBitFactory/libshared) 的日期格式标准：

| 中文 | Taskwarrior | 说明 |
|------|-------------|------|
| `現在`/`现在` | `now` | 此刻 |
| `昨天` | `sod-1d` | Start of Day - 1 day |
| `今天` | `sod+0d` | Start of Day |
| `明天` | `sod+1d` | Start of Day + 1 day |
| `這週一`/`这周一` | `sow+0d` | Start of Week + 0 days |
| `下週三`/`下周三` | `sonw+2d` | Start of Next Week + 2 days |
| `15號`/`15号` | `som+14d` | Start of Month + 14 days |
| `下個月5號`/`下个月5号` | `sonm+4d` | Start of Next Month + 4 days |
| `三月` | `soy+2m` | Start of Year + 2 months |
| `明年6月` | `sony+5m` | Start of Next Year + 5 months |
| `週末`/`周末` | `eow` | End of Week |
| `月底` | `eom` | End of Month |
| `年底` | `eoy` | End of Year |
| `三天後`/`三天后` | `now+3d` | 相对于现在 |
| `兩小時前`/`两小时前` | `now-2h` | 相对于现在 |

### 完整范例

```fish
# 日常任务
task add 日常任务 due:这周五
task add 专案会议 due:明天下午两点半
task add 月底结账 due:这个月28号
task add 年度检讨 due:今年年底

# 专案管理
task add 专案启动 due:下周一上午九点 专案：新产品 优先级：H
task add 第一阶段 due:下个月十五号 依赖：42 预估耗时：2小时
task add 专案结案 due:明年三月底 专案：新产品

# 追踪过去的事情
task add 过去记录 entry:去年五月
task add 追踪 bug entry:三天前

# 紧急与循环任务
task add 紧急会议 due:两小时后
task add 系统维护 due:三天后早上两点 wait:两天后
task add 定期提醒 due:这个月三十号早上八点四十五分 循环：monthly
```

## 🔍 实现原理

本套件透过包装 `task` 函数，在命令执行前偷偷转换你的中文输入：

1. **全形标点转换**：`：` → `:`（不用切输入法了）
2. **中文关键字替换**：`專案：`/`专案：` → `project:`（翻译蒟蒻启动）
3. **日期解析**：`下週五`/`下周五` → `sonw+4d`（呼叫 `_task_parse_date` 函数）
4. **智能校正**：`due` 和 `until` 自动 +1 天（符合人类逻辑）
5. **执行原生命令**：将转换后的参数传给真正的 `task` 命令

**日期解析流程（技术细节）：**
1. 使用 [fish-cn2int](https://github.com/stephen9412/fish-cn2int) 将中文数字转为阿拉伯数字
2. 按优先顺序匹配不同日期模式（别名 → 相对时间 → 星期 → 日期 → 月份 → 完整日期时间）
3. 语义验证：检查是否有明确单位，避免歧义
4. 转换为 Taskwarrior 标准格式

整个过程对使用者透明，你只管用中文打字就好。

## 🧪 测试

执行测试套件（确保一切正常）：

```fish
fisher install jorgebucaran/fishtape

fishtape tests/*.fish

fishtape tests/test_nickname.fish
```

目前包含 **325 个测试用例**（没错，325 个），涵盖：
- 基础别名（现在、昨天、明天...）
- 相对时间（天前、小时后...）
- 星期（周一～周日、上周、下周...）
- 日期（号码、月份）
- 时间（早上、下午、时分秒）
- 复杂组合（年月日时分秒）
- 边界情况（超大数字、语义验证、各种刁钻问题）

所有测试都必须通过，一个都不能少。

## ❓ 常见问题

**Q: 为什么「今年三月二十」不会被解析？**  
A: 因为「二十」后面缺少单位（號/号/日），可能是「三月二十号」也可能是其他意思。为了避免误判，请明确写成「今年三月二十号」。（程序不是通灵师）

**Q: 可以用「星期四十九」这种超出范围的数字吗？**  
A: 可以！这会被解析为「从周一算起第49天」，相当于7周后。这是设计功能，不是 bug。（虽然看起来很像 bug）

**Q: 支持哪些繁简字体？**  
A: 完整支持繁体和简体中文，包括：週/周、個/个、號/号、點/点、來/来、現/现 等所有常见字词。混用也可以，但不建议（会看起来怪怪的）。

**Q: 全形标点符号会自动转换吗？**  
A: 是的！全形冒号（`：`）会自动转换为半形（`:`），不需要切换输入法。（终于可以全中文无脑打字了）

**Q: 如何自订快速输入样板？**  
A: 参考 [进阶配置](#进阶配置自动展开) 章节，使用 `abbr --add --command task --set-cursor` 建立自己的样板。记得要自己手动添加到 config.fish 喔！

**Q: `due` 和 `until` 为什么会自动 +1 天？**  
A: 因为人们说「三天后到期」通常指「三天后那一天结束前」，而非「三天后凌晨 00:00:00 就爆炸」。这个设计让语义更符合人类直觉（而非电脑直觉）。

## 🤝 贡献

欢迎提交 Pull Request 或开 Issue！

**贡献方向：**
- 补充更多地区的习惯用语（港澳、东南亚、大陆各地、甚至火星中文）
- 增加新的日期表达模式（发现我没想到的说法？提出来！）
- 改进语义验证逻辑（让它更聪明）
- 提升效能（虽然现在已经够快了）
- 补充文件与范例（好的范例胜过千言万语）
- 新增更多预设缩写样板（分享你的私房配置）

**请确保：**
1. 所有现有测试都通过：`fishtape tests/*.fish`
2. 为新功能添加测试用例（没测试等于没发生）
3. 更新 README.md 说明新功能（让大家知道你做了什么）

## 📄 授权

MIT License

## ✍️ 作者

[stephen9412](https://github.com/stephen9412)

## 🙏 致谢

- [Taskwarrior](https://taskwarrior.org/) - 最强大的命令行 GTD 工具
- [Fish Shell](https://fishshell.com/) - 友善且强大的 Shell
- [jorgebucaran/fisher](https://github.com/jorgebucaran/fisher) - Fish 套件管理器
- [jorgebucaran/fishtape](https://github.com/jorgebucaran/fishtape) - Fish 测试框架
