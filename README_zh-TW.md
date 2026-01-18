# fish-taskwarrior-cn

讓 Taskwarrior 說中文 🗣️ — 用最自然的方式管理任務

[![GitHub stars](https://img.shields.io/github/stars/stephen9412/fish-taskwarrior-cn?style=social)](https://github.com/stephen9412/fish-taskwarrior-cn/stargazers)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![English](https://img.shields.io/badge/DOCS-English-blue)](./README.md)
[![简体中文](https://img.shields.io/badge/DOCS-简体中文-red)](./README_zh-CN.md)

> 💡 **覺得有用？給個 ⭐️ Star 吧！** 這是對開源作者最大的鼓勵，也能讓更多人發現這個專案。

## 🤔 為什麼寫這個？

用中文思考的時候，沒人想切換輸入法去拼 `due`、`scheduled`、`priority`，更沒人記得「下週五」的英文是 `next Friday` 還是 `Friday next`。歐，對不起，我英文不夠好。

[Taskwarrior](https://github.com/GothenburgBitFactory/taskwarrior) 是我調研多年後，唯一真正跨平台且完整實現 GTD 理念的命令列工具。強大歸強大，但每次要輸入英文關鍵字和日期就得切回英文模式，思緒瞬間被打斷——這誰受得了？

所以我做了這個套件。**讓你用母語的直覺管理任務，不再為了工具委屈自己的大腦。**

## 🚀 快速體驗

![新增任務演示](.github/assets/add_task.gif)

安裝後，你就可以這樣用 Taskwarrior：

```fish
# 完全中文化的任務管理
task add 寫週報 專案：工作 優先級：H 標籤：文書 截止：這週五下午五點

# 修改任務（智能補全描述）
task mod 42 <空格>  # 自動補全為: task mod 42 '原始描述'

# 等待類任務（讓子彈飛一會兒）
task add 打電話給客戶 讓子彈飛到：三天後

# 循環任務
task add 週會 專案：團隊 截止：下週一上午九點 循環：weekly

# 複雜的依賴關係
task add 整合測試 依賴：42 預估耗時：3小時 排程：明天下午兩點
```

**語言支援：** 繁簡通用。身在台灣，用語偏台式，但已儘量涵蓋大陸與港澳的習慣寫法。各地用語差異歡迎提 Issue 或 PR 補充（我真的不知道東北人怎麼說「下週五」）。

## 📦 安裝

### 使用 Fisher（推薦，省時省力）

```fish
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

fisher install stephen9412/fish-cn2int
fisher install stephen9412/fish-taskwarrior-cn
```

### 手動安裝（喜歡自己來的硬派玩家）

```bash
curl -L https://raw.githubusercontent.com/stephen9412/fish-cn2int/refs/heads/main/functions/cn2int.fish \
     -o ~/.config/fish/functions/cn2int.fish

curl -L https://raw.githubusercontent.com/stephen9412/fish-taskwarrior-cn/main/functions/taskwarrior_parse_date.fish \
     -o ~/.config/fish/functions/taskwarrior_parse_date.fish

curl -L https://raw.githubusercontent.com/stephen9412/fish-taskwarrior-cn/main/conf.d/task.fish \
     -o ~/.config/fish/conf.d/task.fish
```

安裝後重啟 Fish Shell 或執行 `source ~/.config/fish/config.fish`。

完成！現在可以開始用中文管理任務了。

## ✨ 核心功能

### 🏷️ 中文關鍵字

所有 Taskwarrior 的屬性都支援中文，**繁體簡體皆可**：

| 中文（繁體） | 中文（簡體） | 英文原文 | 說明 |
|------------|------------|----------|------|
| `專案：`、`項目：` | `专案：`、`项目：` | `project:` | 所屬專案 |
| `優先：`、`優先級：`、`優先權：` | `优先：`、`优先级：`、`优先权：` | `priority:` | 優先級別（H/M/L） |
| `標籤：` | `标签：` | `tags:` | 標籤（可多個） |
| `註解：` | `注解：` | `annotation:` | 註解說明 |
| `依賴：`、`依賴於：`、`卡在：` | `依赖：`、`依赖于：`、`卡在：` | `depends:` | 依賴其他任務 |
| `預估耗時：`、`預估時間：`、`耗時：` | `预估耗时：`、`预估时间：`、`耗时：` | `estimate:` | 預估所需時間 |
| `截止：`、`到期：`、`死線：`、`期限：` | `截止：`、`到期：`、`死线：`、`期限：` | `due:` | 截止時間 |
| `等待：`、`讓子彈飛到：` | `等待：`、`让子弹飞到：` | `wait:` | 等待直到某時間 |
| `排程：`、`預定：`、`預計：`、`計畫：`、`計劃：` | `排程：`、`预定：`、`预计：`、`计划：` | `scheduled:` | 計劃開始時間 |
| `直到：`、`有效期：`、`過期：` | `直到：`、`有效期：`、`过期：` | `until:` | 有效期限 |
| `循環：`、`重複：`、`週期：` | `循环：`、`重复：`、`周期：` | `recur:` | 循環週期 |

**實際使用：**

```fish
# 一行搞定完整的任務屬性
task add 實現新功能 專案：產品開發 優先級：H 標籤：後端 標籤：API 預估耗時：五小時 截止：下週三

# 依賴關係（這個任務卡在其他任務上）
task add 部署上線 依賴：42 卡在：43 排程：明天

# 等待任務（讓子彈飛一會兒）
task add 追蹤進度 讓子彈飛到：三天後

# 循環任務
task add 備份資料庫 循環：daily 排程：早上兩點
```

**💡 小技巧：** 支援全形冒號（`：`）和半形冒號（`:`），不需要切換輸入法！（再也不用在中英文之間瘋狂切換了）

### ⌨️ 智能空格補全

![智能補全演示](.github/assets/modify_task.gif)

在修改任務時，按空格鍵會自動補全任務描述：

```fish
# 輸入
task mod 42<空格>

# 自動展開為
task mod 42 '原始任務描述'
```

游標會自動停在引號內，方便你直接修改描述。不用再手動打開任務列表複製貼上——效率直接起飛。

### 📅 中文日期時間

支援完整的中文日期時間表達，適用於所有時間相關欄位：`due`、`wait`、`scheduled`、`until`、`entry`、`start`、`end`。

#### 基礎別名

```fish
task add 開會 due:明天
task add 報告 due:後天
task add 清理 due:這週末
task add 檢討 due:月底
task add 規劃 due:明年年初
```

**支援的別名：**
- 時間點：`現在`/`现在`、`昨天`、`今天`、`明天`、`後天`/`后天`、`大後天`/`大后天`
- 週末：`週末`/`周末`、`這週末`/`这周末`、`上週末`/`上周末`、`下週末`/`下周末`
- 週：`上週`/`上周`、`這週`/`这周`、`下週`/`下周`
- 月：`這個月`/`这个月`、`上個月`/`上个月`、`下個月`/`下个月`
- 月邊界：`月初`、`月底`、`這個月初`/`这个月初`、`下個月底`/`下个月底`
- 年邊界：`年初`、`年底`、`今年年初`、`明年年底`、`前年年初`、`去年年底`

#### 相對時間

```fish
task add 交作業 due:三天後
task add 會議 due:兩小時後
task add 提醒 wait:半小時後
task add 備註 entry:十天前
```

**支援的單位：** 天、小時、分鐘、秒，可以串接組合：

```fish
task add 緊急任務 due:三天後十二小時後三十分鐘前
# 轉換為: now+3d+12h-30min
```

#### 星期

```fish
task add 週會 due:週一
task add 健身 due:這週三
task add 聚餐 due:下週五
```

**支援：** `週`/`周`/`星期`/`禮拜`/`礼拜` + `一`～`日`/`天`

#### 日期

```fish
task add 發薪 due:15號
task add 繳費 due:這個月28號
task add 聚會 due:下個月5號
```

#### 完整日期時間

```fish
task add 早會 due:明天早上九點
task add 下午茶 due:今天下午三點半
task add 截止 due:這個月三十號下午兩點二十九分
task add 發布 due:明年六月二十號早上九點十五分
```

**時段自動轉換：**
- `早上`、`上午`：0-11 點
- `下午`、`晚上`：自動 +12 小時

**更多日期範例請見 [日期解析詳細說明](#日期解析詳細說明) 章節。**

### ⚙️ 智能日期校正

對於 `due` 和 `until` 欄位，人們通常期望的是「那一天結束前」，而非「那一天開始」。

因此，這兩個欄位會**自動 +1 天**：

```fish
# 你輸入
task add 交件 due:三天後

# 實際轉換為
task add 交件 due:4d

# 語義：三天後的那一天結束前都可以交
# 不是三天後 00:00:00 就爆炸
```

**這個設計讓日期語義更符合人類直覺**——畢竟沒人會在凌晨準時交作業（除非你是肝帝）。

## ⚡ 內建別名與縮寫

為了加速日常操作，套件內建了常用的別名和縮寫（少打字就是多活幾年）：

### 別名（Alias）

```fish
tl      # task list - 列出所有任務
ts      # task sync - 同步任務
tn      # task next - 顯示接下來要做的任務
tnn     # task next limit:1 - 只顯示最重要的一件事（專注力滿分）
```

### 縮寫（Abbreviation）

```fish
tm           # task mod - 修改任務
td           # task done - 完成任務（最爽的指令）
tsta         # task start - 開始任務
tsto         # task stop - 停止任務
tdel         # task delete - 刪除任務
tctx         # task context - 切換情境
```

**使用範例：**

```fish
# 快速列出所有任務
tl

# 查看下一件最重要的事（專注力 100%）
tnn

# 完成任務 42（最爽的時刻）
td 42

# 開始處理任務 42
tsta 42

# 暫停任務 42（先去喝杯咖啡）
tsto 42

# 刪除任務 42（算了不幹了）
tdel 42
```

## 🔧 進階配置：自動展開

> ### ⚠️ **重要：這不是預設功能！**
> 
> **本章節的所有縮寫樣板都需要你自己手動添加到 `~/.config/fish/config.fish`！**
> 
> 雖然本文反覆提及這些用法，但請記住：**這些是給你的靈感和範例**，不是安裝套件後就能用的。你必須根據自己的工作流程客製化專屬的快捷鍵。
> 
> 複製貼上下面的範例，然後改成你自己喜歡的樣子吧！

將以下設定複製到你的 `~/.config/fish/config.fish`，建立自己的快速輸入樣板：

```fish
abbr --add --command task --set-cursor adda 'add "%" 專案： 優先級：L 標籤：'

abbr --add --command task --set-cursor addw 'add "%" 專案：工作 優先級：H 標籤：'

abbr --add --command task --set-cursor addl 'add "%" 專案：生活 優先級：L 標籤：'

abbr --add --command task --set-cursor addp 'add "%" 專案： 優先級：M 截止：下週五 標籤：'
```

**使用方式：**

```fish
# 輸入
task adda<空格>

# 自動展開為
task add "%" 專案： 優先級：L 標籤：
#           ↑ 游標停在這裡，開始輸入任務描述

# 然後按 Tab 跳到下一個欄位，快速填寫
```

**自訂技巧（發揮你的創意）：**
1. 為不同優先級建立快捷樣板（`addh` 高優先、`addl` 低優先、`addwtf` 緊急到爆）
2. 為常用專案建立專屬縮寫（`addreport` 週報、`addmeeting` 開會、`addcoffee` 摸魚）
3. 使用 `--set-cursor` 配合 `%` 讓游標自動定位（Fish shell 的神奇魔法）
4. 根據工作領域設計樣板（工程師、設計師、PM、老闆都有不同需求）

這個功能可以**極大提升任務輸入效率**——一旦習慣了，你會回不去的。

## 📖 日期解析詳細說明

本節深入說明中文日期時間的解析規則與進階用法。

### 數字格式

支援中文數字、阿拉伯數字，甚至混用（隨便你怎麼打）：

```fish
task add 任務 due:一百零八天後        # 108天（龍珠梗？）
task add 任務 due:二十三號            # 23號
task add 任務 due:兩小時後            # 2小時（兩 = 2）
task add 任務 due:半小時後            # 30分鐘
```

**支援的中文數字：**
- 基本：一、二、三、四、五、六、七、八、九、零
- 變體：兩/两、貳/贰、參/叁、肆、伍、陸/陆、柒、捌、玖（想耍文青也行）
- 單位：十、百、千、萬/万、億/亿（可以到「一億天後」，但你活不到那天）
- 特殊：半（在時間中代表 30 分鐘）

### 繁簡混用

所有功能完整支援繁體和簡體中文：

```fish
task add 工作 due:這週三下午三點      # 繁體
task add 工作 due:这周三下午三点      # 簡體
task add 工作 due:这週三下午三点      # 混用（輸入法切一半的受害者）
```

### 超出範圍的數字（騷操作專區）

如果你喜歡挑戰常識，這裡有些騷操作：

```fish
task add 遙遠的未來 due:星期三十
# → sow+29d（從週一算起第30天 = 約4週後）
# 沒錯，星期可以超過七天

task add 這個月一百八十號 due:這個月一百八十號
# → som+179d（從月初算起第180天 = 約6個月後）
# 誰說一個月只有31天？

task add 今年三十月 due:今年三十月
# → soy+29m（從年初算起第30個月 = 後年6月）
# 一年12個月？那是普通人的世界
```

**原理（其實很單純）：**
- `星期N` 的 N 當作「從週一開始的第 N 天」（所以星期100也行）
- `N號` 的 N 當作「從月初開始的第 N 天」（月初往後數N天）
- `N月` 的 N 當作「從年初開始的第 N 個月」（年初往後數N個月）

這不是 bug，是 feature。有些特殊場景（比如「90天後」但你想用「三月九十號」來表達）會很好用。

### 語義驗證

為避免歧義，以下格式會**原樣返回**不解析（程式不猜，你也別猜）：

```fish
# ❌ 缺少單位
task add 任務 due:今年三月二十
# → 保持 "今年三月二十"（是20號？20個什麼？不知道）

# ✅ 正確寫法
task add 任務 due:今年三月二十號
# → soy+2m+19d（清清楚楚）

task add 任務 due:今年三月
# → soy+2m（這個沒問題，就是三月）
```

**規則：每個數字後面都要有明確的單位**（號/日/月/年/天/小時/分/秒）。

不然程式會覺得你在說外星語。

### 轉換對照表

對應 [GothenburgBitFactory/libshared](https://github.com/GothenburgBitFactory/libshared) 的日期格式標準：

| 中文 | Taskwarrior | 說明 |
|------|-------------|------|
| `現在` | `now` | 此刻 |
| `昨天` | `sod-1d` | Start of Day - 1 day |
| `今天` | `sod+0d` | Start of Day |
| `明天` | `sod+1d` | Start of Day + 1 day |
| `這週一` | `sow+0d` | Start of Week + 0 days |
| `下週三` | `sonw+2d` | Start of Next Week + 2 days |
| `15號` | `som+14d` | Start of Month + 14 days |
| `下個月5號` | `sonm+4d` | Start of Next Month + 4 days |
| `三月` | `soy+2m` | Start of Year + 2 months |
| `明年6月` | `sony+5m` | Start of Next Year + 5 months |
| `週末` | `eow` | End of Week |
| `月底` | `eom` | End of Month |
| `年底` | `eoy` | End of Year |
| `三天後` | `now+3d` | 相對於現在 |
| `兩小時前` | `now-2h` | 相對於現在 |

### 完整範例

```fish
# 日常任務
task add 日常任務 due:這週五
task add 專案會議 due:明天下午兩點半
task add 月底結帳 due:這個月28號
task add 年度檢討 due:今年年底

# 專案管理
task add 專案啟動 due:下週一上午九點 專案：新產品 優先級：H
task add 第一階段 due:下個月十五號 依賴：42 預估耗時：2小時
task add 專案結案 due:明年三月底 專案：新產品

# 追蹤過去的事情
task add 過去記錄 entry:去年五月
task add 追蹤 bug entry:三天前

# 緊急與循環任務
task add 緊急會議 due:兩小時後
task add 系統維護 due:三天後早上兩點 wait:兩天後
task add 定期提醒 due:這個月三十號早上八點四十五分 循環：monthly
```

## 🔍 實現原理

本套件透過包裝 `task` 函數，在命令執行前偷偷轉換你的中文輸入：

1. **全形標點轉換**：`：` → `:`（不用切輸入法了）
2. **中文關鍵字替換**：`專案：` → `project:`（翻譯蒟蒻啟動）
3. **日期解析**：`下週五` → `sonw+4d`（呼叫 `_task_parse_date` 函數）
4. **智能校正**：`due` 和 `until` 自動 +1 天（符合人類邏輯）
5. **執行原生命令**：將轉換後的參數傳給真正的 `task` 命令

**日期解析流程（技術細節）：**
1. 使用 [fish-cn2int](https://github.com/stephen9412/fish-cn2int) 將中文數字轉為阿拉伯數字
2. 按優先順序匹配不同日期模式（別名 → 相對時間 → 星期 → 日期 → 月份 → 完整日期時間）
3. 語義驗證：檢查是否有明確單位，避免歧義
4. 轉換為 Taskwarrior 標準格式

整個過程對使用者透明，你只管用中文打字就好。

## 🧪 測試

執行測試套件（確保一切正常）：

```fish
fisher install jorgebucaran/fishtape

fishtape tests/*.fish

fishtape tests/test_nickname.fish
```

目前包含 **325 個測試用例**（沒錯，325 個），涵蓋：
- 基礎別名（現在、昨天、明天...）
- 相對時間（天前、小時後...）
- 星期（週一～週日、上週、下週...）
- 日期（號碼、月份）
- 時間（早上、下午、時分秒）
- 複雜組合（年月日時分秒）
- 邊界情況（超大數字、語義驗證、各種刁鑽問題）

所有測試都必須通過，一個都不能少。

## ❓ 常見問題

**Q: 為什麼「今年三月二十」不會被解析？**  
A: 因為「二十」後面缺少單位（號/日），可能是「三月二十號」也可能是其他意思。為了避免誤判，請明確寫成「今年三月二十號」。（程式不是通靈師）

**Q: 可以用「星期四十九」這種超出範圍的數字嗎？**  
A: 可以！這會被解析為「從週一算起第49天」，相當於7週後。這是設計功能，不是 bug。（雖然看起來很像 bug）

**Q: 支援哪些繁簡字體？**  
A: 完整支援繁體和簡體中文，包括：週/周、個/个、號/号、點/点、來/来、現/现 等所有常見字詞。混用也可以，但不建議（會看起來怪怪的）。

**Q: 全形標點符號會自動轉換嗎？**  
A: 是的！全形冒號（`：`）會自動轉換為半形（`:`），不需要切換輸入法。（終於可以全中文無腦打字了）

**Q: 如何自訂快速輸入樣板？**  
A: 參考 [進階配置](#進階配置自動展開) 章節，使用 `abbr --add --command task --set-cursor` 建立自己的樣板。記得要自己手動添加到 config.fish 喔！

**Q: `due` 和 `until` 為什麼會自動 +1 天？**  
A: 因為人們說「三天後到期」通常指「三天後那一天結束前」，而非「三天後凌晨 00:00:00 就爆炸」。這個設計讓語義更符合人類直覺（而非電腦直覺）。

## 🤝 貢獻

歡迎提交 Pull Request 或開 Issue！

**貢獻方向：**
- 補充更多地區的習慣用語（港澳、東南亞、大陸各地、甚至火星中文）
- 增加新的日期表達模式（發現我沒想到的說法？提出來！）
- 改進語義驗證邏輯（讓它更聰明）
- 提升效能（雖然現在已經夠快了）
- 補充文件與範例（好的範例勝過千言萬語）
- 新增更多預設縮寫樣板（分享你的私房配置）

**請確保：**
1. 所有現有測試都通過：`fishtape tests/*.fish`
2. 為新功能添加測試用例（沒測試等於沒發生）
3. 更新 README.md 說明新功能（讓大家知道你做了什麼）

## 📄 授權

MIT License

## ✍️ 作者

[stephen9412](https://github.com/stephen9412)

## 🙏 致謝

- [Taskwarrior](https://taskwarrior.org/) - 最強大的命令列 GTD 工具
- [Fish Shell](https://fishshell.com/) - 友善且強大的 Shell
- [jorgebucaran/fisher](https://github.com/jorgebucaran/fisher) - Fish 套件管理器
- [jorgebucaran/fishtape](https://github.com/jorgebucaran/fishtape) - Fish 測試框架
