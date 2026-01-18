set -l test_dir (dirname (status filename))
source $test_dir/../functions/taskwarrior_parse_date.fish

# days
@test "AST: 三天前 -> now-3d" (_task_parse_date 三天前) = "now-3d"
@test "AST: 十天前 -> now-10d" (_task_parse_date 十天前) = "now-10d"
@test "AST: 十五天前 -> now-15d" (_task_parse_date 十五天前) = "now-15d"
@test "AST: 六十三天前 -> now-63d" (_task_parse_date 六十三天前) = "now-63d"
@test "AST: 八十四天前 -> now-84d" (_task_parse_date 八十四天前) = "now-84d"
@test "AST: 一百四天前 -> now-104d" (_task_parse_date 一百四天前) = "now-104d"
@test "AST: 一百零八天前 -> now-108d" (_task_parse_date 一百零八天前) = "now-108d"
@test "AST: 一百三十天前 -> now-130d" (_task_parse_date 一百三十天前) = "now-130d"
@test "AST: 一百五十三天前 -> now-153d" (_task_parse_date 一百五十三天前) = "now-153d"
@test "AST: 一百九十九天前 -> now-199d" (_task_parse_date 一百九十九天前) = "now-199d"
@test "AST: 三天後 -> now+3d" (_task_parse_date 三天後) = "now+3d"
@test "AST: 十天後 -> now+10d" (_task_parse_date 十天後) = "now+10d"
@test "AST: 十五天後 -> now+15d" (_task_parse_date 十五天後) = "now+15d"
@test "AST: 六十三天後 -> now+63d" (_task_parse_date 六十三天後) = "now+63d"
@test "AST: 八十四天後 -> now+84d" (_task_parse_date 八十四天後) = "now+84d"
@test "AST: 一百四天後 -> now+104d" (_task_parse_date 一百四天後) = "now+104d"
@test "AST: 一百零八天後 -> now+108d" (_task_parse_date 一百零八天後) = "now+108d"
@test "AST: 一百三十天後 -> now+130d" (_task_parse_date 一百三十天後) = "now+130d"
@test "AST: 一百五十三天後 -> now+153d" (_task_parse_date 一百五十三天後) = "now+153d"
@test "AST: 一百九十九天後 -> now+199d" (_task_parse_date 一百九十九天後) = "now+199d"

# hours
@test "AST: 一小時前 -> now+1h" (_task_parse_date 一小時前) = "now-1h"
@test "AST: 兩小時前 -> now+2h" (_task_parse_date 兩小時前) = "now-2h"
@test "AST: 一小時後 -> now+1h" (_task_parse_date 一小時後) = "now+1h"
@test "AST: 兩小時後 -> now+2h" (_task_parse_date 兩小時後) = "now+2h"

# minutes
@test "AST: 十分鐘前 -> now-10min" (_task_parse_date 十分鐘前) = "now-10min"
@test "AST: 十三分鐘前 -> now-13min" (_task_parse_date 十三分鐘前) = "now-13min"
@test "AST: 半小時前 -> now-30min" (_task_parse_date 半小時前) = "now-30min"
@test "AST: 十分鐘後 -> now+10min" (_task_parse_date 十分鐘後) = "now+10min"
@test "AST: 十五分鐘後 -> now+15min" (_task_parse_date 十五分鐘後) = "now+15min"
@test "AST: 半小時後 -> now+30min" (_task_parse_date 半小時後) = "now+30min"

# seconds
@test "AST: 十秒前 -> now-10s" (_task_parse_date 十秒前) = "now-10s"
@test "AST: 十秒後 -> now+10s" (_task_parse_date 十秒後) = "now+10s"
@test "AST: 三十秒前 -> now-30s" (_task_parse_date 三十秒前) = "now-30s"
@test "AST: 三十秒後 -> now+30s" (_task_parse_date 三十秒後) = "now+30s"

# mixed
@test "AST: 三天後十二小時後三十分鐘後二十秒前 -> now+3d+12h+30min-20s" (_task_parse_date 三天後十二小時後三十分鐘後二十秒前) = "now+3d+12h+30min-20s"
@test "AST: 五天前三小時前 -> now-5d-3h" (_task_parse_date 五天前三小時前) = "now-5d-3h"
@test "AST: 兩天後五小時後十分鐘前 -> now+2d+5h-10min" (_task_parse_date 兩天後五小時後十分鐘前) = "now+2d+5h-10min"
@test "AST: 一天前兩小時後三十分鐘後 -> now-1d+2h+30min" (_task_parse_date 一天前兩小時後三十分鐘後) = "now-1d+2h+30min"
@test "AST: 十天後六小時前十五分鐘後四十五秒後 -> now+10d-6h+15min+45s" (_task_parse_date 十天後六小時前十五分鐘後四十五秒後) = "now+10d-6h+15min+45s"
