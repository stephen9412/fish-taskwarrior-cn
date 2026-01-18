set -l test_dir (dirname (status filename))
source $test_dir/../functions/taskwarrior_parse_date.fish

@test "AST: 1月 -> soy+0m" (_task_parse_date 1月) = "soy+0m"
@test "AST: 2月 -> soy+1m" (_task_parse_date 2月) = "soy+1m"
@test "AST: 3月 -> soy+2m" (_task_parse_date 3月) = "soy+2m"
@test "AST: 4月 -> soy+3m" (_task_parse_date 4月) = "soy+3m"
@test "AST: 5月 -> soy+4m" (_task_parse_date 5月) = "soy+4m"
@test "AST: 6月 -> soy+5m" (_task_parse_date 6月) = "soy+5m"
@test "AST: 7月 -> soy+6m" (_task_parse_date 7月) = "soy+6m"
@test "AST: 8月 -> soy+7m" (_task_parse_date 8月) = "soy+7m"
@test "AST: 9月 -> soy+8m" (_task_parse_date 9月) = "soy+8m"
@test "AST: 10月 -> soy+9m" (_task_parse_date 10月) = "soy+9m"
@test "AST: 11月 -> soy+10m" (_task_parse_date 11月) = "soy+10m"
@test "AST: 12月 -> soy+11m" (_task_parse_date 12月) = "soy+11m"

@test "AST: 一月 -> soy+0m" (_task_parse_date 一月) = "soy+0m"
@test "AST: 二月 -> soy+1m" (_task_parse_date 二月) = "soy+1m"
@test "AST: 三月 -> soy+2m" (_task_parse_date 三月) = "soy+2m"
@test "AST: 四月 -> soy+3m" (_task_parse_date 四月) = "soy+3m"
@test "AST: 五月 -> soy+4m" (_task_parse_date 五月) = "soy+4m"
@test "AST: 六月 -> soy+5m" (_task_parse_date 六月) = "soy+5m"
@test "AST: 七月 -> soy+6m" (_task_parse_date 七月) = "soy+6m"
@test "AST: 八月 -> soy+7m" (_task_parse_date 八月) = "soy+7m"
@test "AST: 九月 -> soy+8m" (_task_parse_date 九月) = "soy+8m"
@test "AST: 十月 -> soy+9m" (_task_parse_date 十月) = "soy+9m"
@test "AST: 十一月 -> soy+10m" (_task_parse_date 十一月) = "soy+10m"
@test "AST: 十二月 -> soy+11m" (_task_parse_date 十二月) = "soy+11m"

@test "AST: 前年5月 -> sopy+4m" (_task_parse_date 前年5月) = "sopy+4m"
@test "AST: 明年5月 -> sony+4m" (_task_parse_date 明年5月) = "sony+4m"

@test "AST: 這個月二十號 -> som+19d" (_task_parse_date 這個月二十號) = "som+19d"
@test "AST: 这个月二十号 -> som+19d" (_task_parse_date 这个月二十号) = "som+19d"

@test "AST: 上個月二十號 -> sopm+19d" (_task_parse_date 上個月二十號) = "sopm+19d"
@test "AST: 上个月二十号 -> sopm+19d" (_task_parse_date 上个月二十号) = "sopm+19d"

@test "AST: 下個月二十號 -> sonm+19d" (_task_parse_date 下個月二十號) = "sonm+19d"
@test "AST: 下个月二十号 -> sonm+19d" (_task_parse_date 下个月二十号) = "sonm+19d"
