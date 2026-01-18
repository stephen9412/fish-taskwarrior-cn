set -l test_dir (dirname (status filename))
source $test_dir/../functions/taskwarrior_parse_date.fish

@test "AST: 這個月 -> soy" (_task_parse_date 這個月) = "soy"
@test "AST: 这个月 -> soy" (_task_parse_date 这个月) = "soy"
@test "AST: 上個月 -> sopm" (_task_parse_date 上個月) = "sopm"
@test "AST: 上个月 -> sopm" (_task_parse_date 上个月) = "sopm"
@test "AST: 下個月 -> sonm" (_task_parse_date 下個月) = "sonm"
@test "AST: 下个月 -> sonm" (_task_parse_date 下个月) = "sonm"

@test "AST: 某天 -> someday" (_task_parse_date 某天) = "someday"
@test "AST: 將來某天 -> someday" (_task_parse_date 將來某天) = "someday"
@test "AST: 将来某天 -> someday" (_task_parse_date 将来某天) = "someday"
@test "AST: 將來某一天 -> someday" (_task_parse_date 將來某一天) = "someday"
@test "AST: 将来某一天 -> someday" (_task_parse_date 将来某一天) = "someday"
@test "AST: 未來某天 -> someday" (_task_parse_date 未來某天) = "someday"
@test "AST: 未来某天 -> someday" (_task_parse_date 未来某天) = "someday"
@test "AST: 未來某一天 -> someday" (_task_parse_date 未來某一天) = "someday"
@test "AST: 未来某一天 -> someday" (_task_parse_date 未来某一天) = "someday"

@test "AST: 這週三十 -> sow+29d" (_task_parse_date 這週三十) = "sow+29d"
@test "AST: 星期三十 -> sow+29d" (_task_parse_date 星期三十) = "sow+29d"
@test "AST: 禮拜三十 -> sow+29d" (_task_parse_date 禮拜三十) = "sow+29d"

@test "AST: 這個月一百八十號 -> som+179d" (_task_parse_date 這個月一百八十號) = "som+179d"
@test "AST: 上個月一百八十號 -> sopm+179d" (_task_parse_date 上個月一百八十號) = "sopm+179d"
@test "AST: 下個月一百八十號 -> sonm+179d" (_task_parse_date 下個月一百八十號) = "sonm+179d"

@test "AST: 今年三十月 -> soy+29m" (_task_parse_date 今年三十月) = "soy+29m"
@test "AST: 今年三十 -> 今年三十" (_task_parse_date 今年三十) = "今年三十"

@test "AST: 普通字串 (project:Work) -> 原樣回傳" (_task_parse_date "project:Work") = "project:Work"
@test "AST: 只有數字 (123) -> 原樣回傳" (_task_parse_date "123") = "123"
@test "AST: 下一個 (不完整語句) -> 原樣回傳" (_task_parse_date "下一個") = "下一個"
