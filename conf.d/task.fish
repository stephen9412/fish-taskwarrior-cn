alias tl="task list"
alias ts="task sync"
alias tn="task next"
alias tnn="task next limit:1"

abbr --add --command task --set-cursor add 'add "%" +in'
abbr --add tm "task mod"
abbr --add td "task done"
abbr --add tsta "task start"
abbr --add tsto "task stop"
abbr --add tdel "task delete"
abbr --add tctx "task context"


for mode in default insert
    bind --mode $mode " " _task_smart_expand_space
end


function _task_smart_expand_space
    set -l cmd (commandline --cut-at-cursor)

    if string match -qr 'task mod [0-9]+$' -- $cmd
        set -l id (string split " " -- $cmd)[-1]

        if task $id count > /dev/null 2>&1
            set -l desc (task _get $id.description | string collect | string trim)
            commandline -r "task mod $id '$desc'"
            commandline -f backward-char
            
        else
            commandline -i " "
        end
    else
        if functions -q __abbr_tips_bind_space
            __abbr_tips_bind_space
        else
            commandline -i " "
        end
    end
end

function task
    set -l new_args

    for arg in $argv
        # ==========================================================
        # --- Step A: Brute-force resolve full-width colons ---
        set -l safe_arg (string replace -a "：" ":" -- $arg)
        
        # ==========================================================
        # --- Step B: Chinese keyword substitution ---
        set safe_arg (string replace -r '^(領域|领域):' 'area:' -- $safe_arg)
        set safe_arg (string replace -r '^(專案|专案|項目|项目):' 'project:' -- $safe_arg)
        set safe_arg (string replace -r '^(優先|優先級|優先權|优先|优先级|优先权):' 'priority:' -- $safe_arg)
        set safe_arg (string replace -r '^(標籤|标签):' 'tags:' -- $safe_arg)
        set safe_arg (string replace -r '^(註解|注解):' 'annotation:' -- $safe_arg)
        set safe_arg (string replace -r '^(依賴|依賴於|依赖|依赖于|卡在):' 'depends:' -- $safe_arg)
        set safe_arg (string replace -r '^(預估耗時|預估時間|耗時|预估耗时|预估时间|耗时):' 'estimate:' -- $safe_arg)
        set safe_arg (string replace -r '^(截止|到期|死線|死线|期限):' 'due:' -- $safe_arg)
        set safe_arg (string replace -r '^(等待|讓子彈飛到|让子弹飞到):' 'wait:' -- $safe_arg)
        set safe_arg (string replace -r '^(排程|預定|预定|預計|预计|計畫|計劃|计划):' 'scheduled:' -- $safe_arg)
        set safe_arg (string replace -r '^(直到|有效期|過期|过期):' 'until:' -- $safe_arg)
        set safe_arg (string replace -r '^(循環|重複|週期|循环|重复|周期):' 'recur:' -- $safe_arg)
        
        # ==========================================================
        # --- Step C: Centralized call to task_parse_date ---
        # Process only when the string contains ":"
        if string match -q "*:*" -- $safe_arg
            # 1. Split Key:Value
            set -l parts (string split -m 1 ":" -- $safe_arg)
            set -l key $parts[1]
            set -l val $parts[2]

            # 2. Parse "date-related fields"
            if contains -- $key due wait scheduled until entry start end
                # Call the parser to convert Chinese input (e.g., "Next Wednesday") into "sonw+2d"
                set -l new_val (_task_parse_date $val)
                set safe_arg "$key:$new_val"
            end
        end

        # ==========================================================
        # --- Step D: N+1 Correction ---
        # For 'due' and 'until', people usually expect the end of that day, not the start.
        # Therefore, 'due' and 'until' need to be automatically adjusted to N + 1 days.
        set -l match_due (string match -r '^due:.*\+([0-9]+)d' -- $safe_arg)
        if set -q match_due[1]
            set -l n $match_due[2] # Capture the number of days (e.g., 3)
            set -l new_n (math $n + 1)
            set safe_arg (string replace -r "\+$n"d "\+$new_n"d -- $safe_arg)
        end

        set -l match_until (string match -r '^until:.*\+([0-9]+)d' -- $safe_arg)
        if set -q match_until[1]
            set -l n $match_until[2]
            set -l new_n (math $n + 1)
            set safe_arg (string replace -r "\+$n"d "\+$new_n"d -- $safe_arg)
        end
        
        # ==========================================================
        # --- Step E: Push back into array ---
        set new_args $new_args $safe_arg
    end

    # Execute the real Task command
    command task $new_args
    #command task rc.data.location=/tmp/task_test $new_args
end
