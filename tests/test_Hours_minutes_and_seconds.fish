set -l test_dir (dirname (status filename))
source $test_dir/../functions/taskwarrior_parse_date.fish

@test "AST: 今天九點 -> sod+0d+9h" (_task_parse_date 今天九點) = "sod+0d+9h"
@test "AST: 今天二十點四十八分四十八秒 -> sod+0d+20h+48min+48s" (_task_parse_date 今天二十點四十八分四十八秒) = "sod+0d+20h+48min+48s"
@test "AST: 今天早上九點 -> sod+0d+9h" (_task_parse_date 今天早上九點) = "sod+0d+9h"
@test "AST: 今天下午三點 -> sod+0d+15h" (_task_parse_date 今天下午三點) = "sod+0d+15h"
@test "AST: 今天下午三點半 -> sod+0d+15h+30min" (_task_parse_date 今天下午三點半) = "sod+0d+15h+30min"
@test "AST: 今天下午四點三十二分 -> sod+0d+16h+32min" (_task_parse_date 今天下午四點三十二分) = "sod+0d+16h+32min"
@test "AST: 今天下午八點十三分二十九秒 -> sod+0d+20h+13min+29s" (_task_parse_date 今天下午八點十三分二十九秒) = "sod+0d+20h+13min+29s"

@test "AST: 今天二十分 -> sod+20min" (_task_parse_date 今天二十分) = "sod+20min"
@test "AST: 今天三十秒 -> sod+30s" (_task_parse_date 今天三十秒) = "sod+30s"

@test "AST: 明天下午三點半 -> sod+1d+15h+30min" (_task_parse_date 明天下午三點半) = "sod+1d+15h+30min"
@test "AST: 明天下午四點三十二分 -> sod+1d+16h+32min" (_task_parse_date 明天下午四點三十二分) = "sod+1d+16h+32min"

@test "AST: 後天下午三點半 -> sod+2d+15h+30min" (_task_parse_date 後天下午三點半) = "sod+2d+15h+30min"
@test "AST: 後天下午四點三十二分 -> sod+2d+16h+32min" (_task_parse_date 後天下午四點三十二分) = "sod+2d+16h+32min"

@test "AST: 三十號下午兩點二十九 -> som+30d+14h+29min" (_task_parse_date 三十號下午兩點二十九) = "som+30d+14h+29min"
@test "AST: 這個月三十號下午兩點二十九 -> som+30d+14h+29min" (_task_parse_date 這個月三十號下午兩點二十九) = "som+30d+14h+29min"
@test "AST: 下個月十五號早上八點四十五分 -> sonm+14d+8h+45min" (_task_parse_date 下個月十五號早上八點四十五分) = "sonm+14d+8h+45min"
@test "AST: 上個月八號早上六點十七分 -> sopm+7d+6h+17min" (_task_parse_date 上個月八號早上六點十七分) = "sopm+7d+6h+17min"

@test "AST: 今年三月十五號下午三點半 -> soy+2m+14d+15h+30min" (_task_parse_date 今年三月十五號下午三點半) = "soy+2m+14d+15h+30min"
@test "AST: 明年六月二十號早上九點十五分 -> sony+5m+19d+9h+15min" (_task_parse_date 明年六月二十號早上九點十五分) = "sony+5m+19d+9h+15min"
@test "AST: 去年十月八號下午兩點三十分 -> sopy+9m+7d+14h+30min" (_task_parse_date 去年十月八號下午兩點三十分) = "sopy+9m+7d+14h+30min"

@test "AST: 今年三月八點 -> soy+3m+8h" (_task_parse_date 今年三月八點) = "soy+3m+8h"

# 不支援沒有單位的用例
@test "AST: 今年三月二十 -> 今年三月二十" (_task_parse_date 今年三月二十) = "今年三月二十"
