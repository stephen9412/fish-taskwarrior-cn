# fish-taskwarrior-cn

Let Taskwarrior Speak Chinese 🗣️ — Manage Tasks the Natural Way

[![GitHub stars](https://img.shields.io/github/stars/stephen9412/fish-taskwarrior-cn?style=social)](https://github.com/stephen9412/fish-taskwarrior-cn/stargazers)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![繁體中文](https://img.shields.io/badge/DOCS-繁體中文-blue)](./README_zh-TW.md)
[![简体中文](https://img.shields.io/badge/DOCS-简体中文-red)](./README_zh-CN.md)

> 💡 **Find this useful? Give it a ⭐️ Star!** It's the best encouragement for open source developers and helps more people discover this project.

## 🤔 Why Did I Build This?

When thinking in Chinese, nobody wants to switch input methods to type `due`, `scheduled`, `priority`, or remember whether "next Friday" is `next Friday` or `Friday next` in English. Oh, sorry, my English isn't good enough.

[Taskwarrior](https://github.com/GothenburgBitFactory/taskwarrior) is the only truly cross-platform command-line tool that fully implements GTD principles after years of research. It's powerful, but having to switch back to English mode every time you need to enter keywords and dates breaks your flow—who can stand that?

So I built this package. **Let you manage tasks with your native language intuition, without compromising your brain for tools.**

## 🚀 Quick Demo

![Add Task Demo](.github/assets/add_task.gif)

After installation, you can use Taskwarrior like this:

```fish
# Fully Chinese task management
task add 寫週報 專案：工作 優先級：H 標籤：文書 截止：這週五下午五點

# Modify task (smart description completion)
task mod 42<space>  # Auto-expands to: task mod 42 'Original description'

# Wait tasks (let the bullets fly for a while)
task add 打電話給客戶 讓子彈飛到：三天後

# Recurring tasks
task add 週會 專案：團隊 截止：下週一上午九點 循環：weekly

# Complex dependencies
task add 整合測試 依賴：42 預估耗時：3小時 排程：明天下午兩點
```

**Language Support:** Both Traditional and Simplified Chinese. Based in Taiwan with Taiwan-style expressions, but tried to cover mainland and Hong Kong/Macau usage as much as possible. Welcome Issues or PRs for regional expression differences (I really don't know how people in Northeast China say "next Friday").

## 📦 Installation

### Using Fisher (Recommended, Time-Saving)

```fish
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

fisher install stephen9412/fish-cn2int
fisher install stephen9412/fish-taskwarrior-cn
```

### Manual Installation (For DIY Enthusiasts)

```bash
curl -L https://raw.githubusercontent.com/stephen9412/fish-cn2int/refs/heads/main/functions/cn2int.fish \
     -o ~/.config/fish/functions/cn2int.fish

curl -L https://raw.githubusercontent.com/stephen9412/fish-taskwarrior-cn/main/functions/taskwarrior_parse_date.fish \
     -o ~/.config/fish/functions/taskwarrior_parse_date.fish

curl -L https://raw.githubusercontent.com/stephen9412/fish-taskwarrior-cn/main/conf.d/task.fish \
     -o ~/.config/fish/conf.d/task.fish
```

After installation, restart Fish Shell or run `source ~/.config/fish/config.fish`.

Done! You can now start managing tasks in Chinese.

## ✨ Core Features

### 🏷️ Chinese Keywords

All Taskwarrior attributes support Chinese, **both Traditional and Simplified**:

| Chinese (Traditional) | Chinese (Simplified) | English | Description |
|------------|------------|----------|------|
| `專案：`、`項目：` | `专案：`、`项目：` | `project:` | Project |
| `優先：`、`優先級：`、`優先權：` | `优先：`、`优先级：`、`优先权：` | `priority:` | Priority (H/M/L) |
| `標籤：` | `标签：` | `tags:` | Tags (multiple) |
| `註解：` | `注解：` | `annotation:` | Annotation |
| `依賴：`、`依賴於：`、`卡在：` | `依赖：`、`依赖于：`、`卡在：` | `depends:` | Depends on other tasks |
| `預估耗時：`、`預估時間：`、`耗時：` | `预估耗时：`、`预估时间：`、`耗时：` | `estimate:` | Estimated time |
| `截止：`、`到期：`、`死線：`、`期限：` | `截止：`、`到期：`、`死线：`、`期限：` | `due:` | Due date |
| `等待：`、`讓子彈飛到：` | `等待：`、`让子弹飞到：` | `wait:` | Wait until |
| `排程：`、`預定：`、`預計：`、`計畫：`、`計劃：` | `排程：`、`预定：`、`预计：`、`计划：` | `scheduled:` | Scheduled start |
| `直到：`、`有效期：`、`過期：` | `直到：`、`有效期：`、`过期：` | `until:` | Valid until |
| `循環：`、`重複：`、`週期：` | `循环：`、`重复：`、`周期：` | `recur:` | Recurrence |

**Real Usage:**

```fish
# Complete task attributes in one line
task add 實現新功能 專案：產品開發 優先級：H 標籤：後端 標籤：API 預估耗時：五小時 截止：下週三

# Dependencies (this task is blocked by others)
task add 部署上線 依賴：42 卡在：43 排程：明天

# Wait tasks (let the bullets fly for a while)
task add 追蹤進度 讓子彈飛到：三天後

# Recurring tasks
task add 備份資料庫 循環：daily 排程：早上兩點
```

**💡 Pro Tip:** Supports both full-width colon (`：`) and half-width colon (`:`), no need to switch input methods! (No more crazy switching between Chinese and English)

### ⌨️ Smart Space Completion

![Smart Completion Demo](.github/assets/modify_task.gif)

When modifying tasks, pressing space automatically completes the task description:

```fish
# Input
task mod 42<space>

# Auto-expands to
task mod 42 '原始任務描述'
```

The cursor automatically stops inside the quotes for easy editing. No more manually opening task lists to copy-paste—efficiency takes off.

### 📅 Chinese Date & Time

Supports complete Chinese date and time expressions for all time-related fields: `due`, `wait`, `scheduled`, `until`, `entry`, `start`, `end`.

#### Basic Aliases

```fish
task add 開會 due:明天
task add 報告 due:後天
task add 清理 due:這週末
task add 檢討 due:月底
task add 規劃 due:明年年初
```

**Supported Aliases:**
- Time points: `現在`/`现在`、`昨天`、`今天`、`明天`、`後天`/`后天`、`大後天`/`大后天`
- Weekends: `週末`/`周末`、`這週末`/`这周末`、`上週末`/`上周末`、`下週末`/`下周末`
- Weeks: `上週`/`上周`、`這週`/`这周`、`下週`/`下周`
- Months: `這個月`/`这个月`、`上個月`/`上个月`、`下個月`/`下个月`
- Month boundaries: `月初`、`月底`、`這個月初`/`这个月初`、`下個月底`/`下个月底`
- Year boundaries: `年初`、`年底`、`今年年初`、`明年年底`、`前年年初`、`去年年底`

#### Relative Time

```fish
task add 交作業 due:三天後
task add 會議 due:兩小時後
task add 提醒 wait:半小時後
task add 備註 entry:十天前
```

**Supported Units:** Days, hours, minutes, seconds, can be chained:

```fish
task add 緊急任務 due:三天後十二小時後三十分鐘前
# Converts to: now+3d+12h-30min
```

#### Weekdays

```fish
task add 週會 due:週一
task add 健身 due:這週三
task add 聚餐 due:下週五
```

**Supports:** `週`/`周`/`星期`/`禮拜`/`礼拜` + `一`～`日`/`天`

#### Dates

```fish
task add 發薪 due:15號
task add 繳費 due:這個月28號
task add 聚會 due:下個月5號
```

#### Complete Date & Time

```fish
task add 早會 due:明天早上九點
task add 下午茶 due:今天下午三點半
task add 截止 due:這個月三十號下午兩點二十九分
task add 發布 due:明年六月二十號早上九點十五分
```

**Time Period Auto-Conversion:**
- `早上`、`上午`: 0-11 o'clock
- `下午`、`晚上`: Auto +12 hours

**For more date examples, see [Detailed Date Parsing](#detailed-date-parsing) section.**

### ⚙️ Smart Date Correction

For `due` and `until` fields, people usually expect "before the end of that day", not "start of that day".

Therefore, these two fields **automatically +1 day**:

```fish
# You input
task add 交件 due:三天後

# Actually converts to
task add 交件 due:4d

# Semantics: can be submitted before the end of that day in 3 days
# Not exploding at 00:00:00 in 3 days
```

**This design makes date semantics more intuitive**—after all, nobody submits homework at midnight on time (unless you're a night owl).

## ⚡ Built-in Aliases & Abbreviations

To speed up daily operations, the package includes common aliases and abbreviations (less typing = more years to live):

### Aliases

```fish
tl      # task list - list all tasks
ts      # task sync - sync tasks
tn      # task next - show next tasks to do
tnn     # task next limit:1 - show only the most important one (100% focus)
```

### Abbreviations

```fish
tm           # task mod - modify task
td           # task done - complete task (most satisfying command)
tsta         # task start - start task
tsto         # task stop - stop task
tdel         # task delete - delete task
tctx         # task context - switch context
```

**Usage Examples:**

```fish
# Quickly list all tasks
tl

# Check the next most important thing (100% focus)
tnn

# Complete task 42 (most satisfying moment)
td 42

# Start working on task 42
tsta 42

# Pause task 42 (go get a coffee first)
tsto 42

# Delete task 42 (forget it, not doing it)
tdel 42
```

## 🔧 Advanced Configuration: Auto-Expansion

> ### ⚠️ **Important: This is NOT a Default Feature!**
> 
> **All abbreviation templates in this section need to be manually added to `~/.config/fish/config.fish`!**
> 
> Although this document repeatedly mentions these usages, remember: **these are inspirations and examples for you**, not available after package installation. You must customize your own shortcuts according to your workflow.
> 
> Copy-paste the examples below and modify them to your liking!

Copy the following configuration to your `~/.config/fish/config.fish` to create your own quick input templates:

```fish
abbr --add --command task --set-cursor adda 'add "%" 專案： 優先級：L 標籤：'

abbr --add --command task --set-cursor addw 'add "%" 專案：工作 優先級：H 標籤：'

abbr --add --command task --set-cursor addl 'add "%" 專案：生活 優先級：L 標籤：'

abbr --add --command task --set-cursor addp 'add "%" 專案： 優先級：M 截止：下週五 標籤：'
```

**How to Use:**

```fish
# Input
task adda<space>

# Auto-expands to
task add "%" 專案： 優先級：L 標籤：
#           ↑ Cursor stops here, start typing task description

# Then press Tab to jump to next field, quick fill
```

**Customization Tips (Unleash Your Creativity):**
1. Create shortcuts for different priorities (`addh` high priority, `addl` low priority, `addwtf` super urgent)
2. Create project-specific abbreviations (`addreport` weekly report, `addmeeting` meeting, `addcoffee` slacking off)
3. Use `--set-cursor` with `%` to auto-position cursor (Fish shell magic)
4. Design templates based on work domain (engineers, designers, PMs, bosses all have different needs)

This feature can **greatly improve task input efficiency**—once you get used to it, there's no going back.

## 📖 Detailed Date Parsing

This section explains the parsing rules and advanced usage of Chinese date and time in detail.

### Number Formats

Supports Chinese numbers, Arabic numbers, even mixed (type however you want):

```fish
task add 任務 due:一百零八天後        # 108 days (Dragon Ball reference?)
task add 任務 due:二十三號            # 23rd
task add 任務 due:兩小時後            # 2 hours (兩 = 2)
task add 任務 due:半小時後            # 30 minutes
```

**Supported Chinese Numbers:**
- Basic: 一、二、三、四、五、六、七、八、九、零
- Variants: 兩/两、貳/贰、參/叁、肆、伍、陸/陆、柒、捌、玖 (feel free to be literary)
- Units: 十、百、千、萬/万、億/亿 (can go up to "one billion days later", but you won't live to see it)
- Special: 半 (represents 30 minutes in time context)

### Traditional/Simplified Mix

Fully supports both Traditional and Simplified Chinese:

```fish
task add 工作 due:這週三下午三點      # Traditional
task add 工作 due:这周三下午三点      # Simplified
task add 工作 due:这週三下午三点      # Mixed (victim of half-switched input method)
```

### Out-of-Range Numbers (Fancy Operations Zone)

If you like challenging common sense, here are some fancy operations:

```fish
task add 遙遠的未來 due:星期三十
# → sow+29d (30th day from Monday = about 4 weeks later)
# Yes, weeks can go beyond seven days

task add 這個月一百八十號 due:這個月一百八十號
# → som+179d (180th day from month start = about 6 months later)
# Who says a month only has 31 days?

task add 今年三十月 due:今年三十月
# → soy+29m (30th month from year start = June next year)
# 12 months a year? That's the normal people's world
```

**How It Works (Actually Simple):**
- `星期N`: N is treated as "Nth day from Monday" (so 星期100 works too)
- `N號`: N is treated as "Nth day from month start" (count N days from month start)
- `N月`: N is treated as "Nth month from year start" (count N months from year start)

This is not a bug, it's a feature. Some special scenarios (like "90 days later" but you want to express it as `三月九十號`) will be very useful.

### Semantic Validation

To avoid ambiguity, the following formats will **return as-is** without parsing (program doesn't guess, neither should you):

```fish
# ❌ Missing unit
task add 任務 due:今年三月二十
# → Keeps "今年三月二十" (is it the 20th? 20 what? Don't know)

# ✅ Correct way
task add 任務 due:今年三月二十號
# → soy+2m+19d (crystal clear)

task add 任務 due:今年三月
# → soy+2m (this is fine, means March)
```

**Rule: Every number must be followed by a clear unit** (號/号/日/月/年/天/小時/小时/分/秒).

Otherwise the program thinks you're speaking alien language.

### Conversion Reference Table

Corresponds to [GothenburgBitFactory/libshared](https://github.com/GothenburgBitFactory/libshared) date format standard:

| Chinese | Taskwarrior | Description |
|------|-------------|------|
| `現在`/`现在` | `now` | Now |
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
| `三天後`/`三天后` | `now+3d` | Relative to now |
| `兩小時前`/`两小时前` | `now-2h` | Relative to now |

### Complete Examples

```fish
# Daily tasks
task add 日常任務 due:這週五
task add 專案會議 due:明天下午兩點半
task add 月底結帳 due:這個月28號
task add 年度檢討 due:今年年底

# Project management
task add 專案啟動 due:下週一上午九點 專案：新產品 優先級：H
task add 第一階段 due:下個月十五號 依賴：42 預估耗時：2d
task add 專案結案 due:明年三月底 專案：新產品

# Track past events
task add 過去記錄 entry:去年五月
task add 追蹤 bug entry:三天前

# Urgent & recurring tasks
task add 緊急會議 due:兩小時後
task add 系統維護 due:三天後早上兩點 wait:兩天後
task add 定期提醒 due:這個月三十號早上八點四十五分 循環：monthly
```

## 🔍 Implementation

This package wraps the `task` function, secretly converting your Chinese input before command execution:

1. **Full-width Punctuation Conversion**: `：` → `:` (no more input method switching)
2. **Chinese Keyword Replacement**: `專案：`/`专案：` → `project:` (translation gadget activated)
3. **Date Parsing**: `下週五`/`下周五` → `sonw+4d` (calls `_task_parse_date` function)
4. **Smart Correction**: `due` and `until` auto +1 day (matches human logic)
5. **Execute Native Command**: Pass converted parameters to real `task` command

**Date Parsing Flow (Technical Details):**
1. Use [fish-cn2int](https://github.com/stephen9412/fish-cn2int) to convert Chinese numbers to Arabic numbers
2. Match different date patterns by priority (aliases → relative time → weekday → date → month → complete datetime)
3. Semantic validation: check for clear units, avoid ambiguity
4. Convert to Taskwarrior standard format

The entire process is transparent to users, just type in Chinese.

## 🧪 Testing

Run test suite (ensure everything works):

```fish
fisher install jorgebucaran/fishtape

fishtape tests/*.fish

fishtape tests/test_nickname.fish
```

Currently contains **325 test cases** (yes, 325), covering:
- Basic aliases (now, yesterday, tomorrow...)
- Relative time (days ago, hours later...)
- Weekdays (Monday~Sunday, last week, next week...)
- Dates (numbers, months)
- Time (morning, afternoon, hours:minutes:seconds)
- Complex combinations (year-month-day-hour-minute-second)
- Edge cases (huge numbers, semantic validation, all kinds of tricky scenarios)

All tests must pass, not one can fail.

## ❓ FAQ

**Q: Why doesn't "今年三月二十" get parsed?**  
A: Because "二十" lacks a unit (號/号/日), could be "March 20th" or something else. To avoid misjudgment, please write clearly as "今年三月二十號". (The program is not a psychic)

**Q: Can I use out-of-range numbers like "星期四十九"?**  
A: Yes! It will be parsed as "49th day from Monday", equivalent to 7 weeks later. This is a design feature, not a bug. (Though it looks like a bug)

**Q: What Traditional/Simplified characters are supported?**  
A: Fully supports Traditional and Simplified Chinese, including: 週/周、個/个、號/号、點/点、來/来、現/现 and all common characters. Mixing is possible but not recommended (looks weird).

**Q: Will full-width punctuation auto-convert?**  
A: Yes! Full-width colon (`：`) auto-converts to half-width (`:`), no need to switch input methods. (Finally can type in Chinese brainlessly)

**Q: How to customize quick input templates?**  
A: Refer to [Advanced Configuration](#advanced-configuration-auto-expansion) section, use `abbr --add --command task --set-cursor` to create your own templates. Remember to manually add them to config.fish!

**Q: Why do `due` and `until` automatically +1 day?**  
A: Because when people say "due in 3 days" they usually mean "before the end of that day in 3 days", not "exploding at 00:00:00 in 3 days". This design makes semantics more intuitive to humans (not computers).

## 🤝 Contributing

Welcome to submit Pull Requests or open Issues!

**Contribution Directions:**
- Add more regional expressions (Hong Kong, Macau, Southeast Asia, mainland regions, even Martian Chinese)
- Add new date expression patterns (found expressions I didn't think of? Propose them!)
- Improve semantic validation logic (make it smarter)
- Improve performance (though it's already fast enough)
- Add documentation and examples (good examples speak louder than words)
- Add more preset abbreviation templates (share your secret configs)

**Please Ensure:**
1. All existing tests pass: `fishtape tests/*.fish`
2. Add test cases for new features (no tests = didn't happen)
3. Update README.md to document new features (let people know what you did)

## 📄 License

MIT License

## ✍️ Author

[stephen9412](https://github.com/stephen9412)

## 🙏 Acknowledgements

- [Taskwarrior](https://taskwarrior.org/) - Most powerful command-line GTD tool
- [Fish Shell](https://fishshell.com/) - Friendly and powerful shell
- [jorgebucaran/fisher](https://github.com/jorgebucaran/fisher) - Fish package manager
- [jorgebucaran/fishtape](https://github.com/jorgebucaran/fishtape) - Fish testing framework
