function _task_parse_date
    set -l input $argv[1]

    if not functions -q cn2int; and not type -q cn2int
        echo $input
        return
    end

    set -l result ""

    if string match -qr '^現在$|^现在$' -- $input
        echo "now"
        return
    end

    if string match -qr '^昨天$' -- $input
        echo "sod-1d"
        return
    end

    if string match -qr '^今天$' -- $input
        echo "sod+0d"
        return
    end

    if string match -qr '^明天$' -- $input
        echo "sod+1d"
        return
    end

    if string match -qr '^後天$|^后天$' -- $input
        echo "sod+2d"
        return
    end

    if string match -qr '^大後天$|^大后天$' -- $input
        echo "sod+3d"
        return
    end

    if string match -qr '^(這|这)?(週|周)末$' -- $input
        echo "eow"
        return
    end

    if string match -qr '^上週$|^上周$' -- $input
        echo "sopw"
        return
    end

    if string match -qr '^上(週|周|個週|個周|个周)末$' -- $input
        echo "eopw"
        return
    end

    if string match -qr '^下週$|^下周$' -- $input
        echo "sonw"
        return
    end

    if string match -qr '^下(週|周|個週|個周|个周)末$' -- $input
        echo "eonw"
        return
    end

    if string match -qr '^((這|这)(個|个)?)?月初$' -- $input
        echo "som"
        return
    end

    if string match -qr '^((這|这)(個|个)?)?月底$' -- $input
        echo "eom"
        return
    end

    if string match -qr '^上(個|个)?月初$' -- $input
        echo "sopm"
        return
    end

    if string match -qr '^上(個|个)?月底$' -- $input
        echo "eopm"
        return
    end

    if string match -qr '^下(個|个)?月初$' -- $input
        echo "sonm"
        return
    end

    if string match -qr '^下(個|个)?月底$' -- $input
        echo "eonm"
        return
    end

    if string match -qr '^(今)?年(年)?初$' -- $input
        echo "soy"
        return
    end

    if string match -qr '^(今)?年(年)?底$' -- $input
        echo "eoy"
        return
    end

    if string match -qr '^前年初$' -- $input
        echo "sony"
        return
    end

    if string match -qr '^前年底$' -- $input
        echo "eony"
        return
    end

    if string match -qr '^前年年初$' -- $input
        echo "sopy"
        return
    end

    if string match -qr '^前年年底$' -- $input
        echo "eopy"
        return
    end

    if string match -qr '^去年(年)?初$' -- $input
        echo "sopy"
        return
    end

    if string match -qr '^去年(年)?底$' -- $input
        echo "eopy"
        return
    end

    if string match -qr '^明年(年)?初$' -- $input
        echo "sony"
        return
    end

    if string match -qr '^明年(年)?底$' -- $input
        echo "eony"
        return
    end

    if string match -qr '^(這|这)(個|个)?月$' -- $input
        echo "soy"
        return
    end

    if string match -qr '^上(個|个)?月$' -- $input
        echo "sopm"
        return
    end

    if string match -qr '^下(個|个)?月$' -- $input
        echo "sonm"
        return
    end

    if string match -qr '^某天$|^將來某[一]?天$|^将来某[一]?天$|^未來某[一]?天$|^未来某[一]?天$' -- $input
        echo "someday"
        return
    end

    if string match -qr '[0-9一二三四五六七八九十百零兩两半]+(天|小時|小时|分鐘|分钟|秒)(前|後|后)' -- $input
        _task_parse_relative_time $input
        return
    end

    if string match -qr '(週|周|星期|禮拜|礼拜)[一二三四五六日天]' -- $input
        _task_parse_weekday $input
        return
    end

    if string match -qr '(今天|明天|後天|后天|這個月|这个月|上個月|上个月|下個月|下个月|今年|明年|去年).*(點|点|分|秒)' -- $input
        _task_parse_datetime $input
        return
    end

    if string match -qr '[0-9一二三四五六七八九十百零兩两]+[號号].*(點|点|分|秒)' -- $input
        _task_parse_datetime $input
        return
    end

    if string match -qr '[0-9一二三四五六七八九十百零]+[號号]' -- $input
        _task_parse_day $input
        return
    end

    if string match -qr '(這|这|上|下)(個|个)?月[0-9一二三四五六七八九十百零]+号' -- $input
        _task_parse_day $input
        return
    end

    if string match -qr '[0-9一二三四五六七八九十百]+月' -- $input
        _task_parse_month $input
        return
    end

    echo $input
end

function _task_parse_relative_time
    set -l input $argv[1]
    set -l result "now"
    
    set -l remaining $input
    
    while test -n "$remaining"
        if string match -qr '([0-9一二三四五六七八九十百零兩两]+)天(前|後|后)' -- $remaining
            set -l matches (string match -r '([0-9一二三四五六七八九十百零兩两]+)天(前|後|后)(.*)' -- $remaining)
            set -l num_str $matches[2]
            set -l direction $matches[3]
            set -l num (cn2int $num_str 2>/dev/null)
            
            if test -z "$num"
                echo $input
                return
            end
            
            if test "$direction" = "前"
                set result "$result-$num"d
            else
                set result "$result+$num"d
            end
            set remaining $matches[4]
        else if string match -qr '([0-9一二三四五六七八九十百零兩两半]+)小時(前|後|后)' -- $remaining
            set -l matches (string match -r '([0-9一二三四五六七八九十百零兩两半]+)小時(前|後|后)(.*)' -- $remaining)
            set -l num_str $matches[2]
            set -l direction $matches[3]
            set -l num
            
            if test "$num_str" = "半"
                if test "$direction" = "前"
                    set result "$result-30min"
                else
                    set result "$result+30min"
                end
            else
                set num (cn2int $num_str 2>/dev/null)
                if test -z "$num"
                    echo $input
                    return
                end
                if test "$direction" = "前"
                    set result "$result-$num"h
                else
                    set result "$result+$num"h
                end
            end
            set remaining $matches[4]
        else if string match -qr '([0-9一二三四五六七八九十百零兩两半]+)小时(前|後|后)' -- $remaining
            set -l matches (string match -r '([0-9一二三四五六七八九十百零兩两半]+)小时(前|後|后)(.*)' -- $remaining)
            set -l num_str $matches[2]
            set -l direction $matches[3]
            set -l num
            
            if test "$num_str" = "半"
                if test "$direction" = "前"
                    set result "$result-30min"
                else
                    set result "$result+30min"
                end
            else
                set num (cn2int $num_str 2>/dev/null)
                if test -z "$num"
                    echo $input
                    return
                end
                if test "$direction" = "前"
                    set result "$result-$num"h
                else
                    set result "$result+$num"h
                end
            end
            set remaining $matches[4]
        else if string match -qr '([0-9一二三四五六七八九十百零兩两半]+)分鐘(前|後|后)' -- $remaining
            set -l matches (string match -r '([0-9一二三四五六七八九十百零兩两半]+)分鐘(前|後|后)(.*)' -- $remaining)
            set -l num_str $matches[2]
            set -l direction $matches[3]
            set -l num
            
            if test "$num_str" = "半"
                set num 30
            else
                set num (cn2int $num_str 2>/dev/null)
            end
            
            if test -z "$num"
                echo $input
                return
            end
            
            if test "$direction" = "前"
                set result "$result-$num"min
            else
                set result "$result+$num"min
            end
            set remaining $matches[4]
        else if string match -qr '([0-9一二三四五六七八九十百零兩两半]+)分钟(前|後|后)' -- $remaining
            set -l matches (string match -r '([0-9一二三四五六七八九十百零兩两半]+)分钟(前|後|后)(.*)' -- $remaining)
            set -l num_str $matches[2]
            set -l direction $matches[3]
            set -l num
            
            if test "$num_str" = "半"
                set num 30
            else
                set num (cn2int $num_str 2>/dev/null)
            end
            
            if test -z "$num"
                echo $input
                return
            end
            
            if test "$direction" = "前"
                set result "$result-$num"min
            else
                set result "$result+$num"min
            end
            set remaining $matches[4]
        else if string match -qr '([0-9一二三四五六七八九十百零兩两]+)秒(前|後|后)' -- $remaining
            set -l matches (string match -r '([0-9一二三四五六七八九十百零兩两]+)秒(前|後|后)(.*)' -- $remaining)
            set -l num_str $matches[2]
            set -l direction $matches[3]
            set -l num (cn2int $num_str 2>/dev/null)
            
            if test -z "$num"
                echo $input
                return
            end
            
            if test "$direction" = "前"
                set result "$result-$num"s
            else
                set result "$result+$num"s
            end
            set remaining $matches[4]
        else
            break
        end
    end
    
    echo $result
end

function _task_parse_weekday
    set -l input $argv[1]
    set -l base "sow"
    
    if string match -qr '上(週|周|個週|個周|个周|星期|個星期|个星期|禮拜|礼拜|個禮拜|个礼拜)' -- $input
        set base "sopw"
    else if string match -qr '下(週|周|個週|個周|个周|星期|個星期|个星期|禮拜|礼拜|個禮拜|个礼拜)' -- $input
        set base "sonw"
    end
    
    set -l day_str (string match -r '(週|周|星期|禮拜|礼拜)(.+)$' -- $input)[3]
    
    if test -z "$day_str"
        echo $input
        return
    end
    
    set -l day_offset -1
    
    if test "$day_str" = "一"
        set day_offset 0
    else if test "$day_str" = "二"
        set day_offset 1
    else if test "$day_str" = "三"
        set day_offset 2
    else if test "$day_str" = "四"
        set day_offset 3
    else if test "$day_str" = "五"
        set day_offset 4
    else if test "$day_str" = "六"
        set day_offset 5
    else if test "$day_str" = "日"
        set day_offset 6
    else if test "$day_str" = "天"
        set day_offset 6
    else
        set -l num (cn2int $day_str)
        if test -n "$num"
            set day_offset (math "$num - 1")
        else
            echo $input
            return
        end
    end
    
    echo "$base+$day_offset"d
end

function _task_parse_day
    set -l input $argv[1]
    set -l base "som"
    
    if string match -qr '上(個|个)?月' -- $input
        set base "sopm"
    else if string match -qr '下(個|个)?月' -- $input
        set base "sonm"
    end
    
    set -l day_str (string match -r '([0-9一二三四五六七八九十百零]+)[號号]' -- $input)[2]
    
    if test -z "$day_str"
        echo $input
        return
    end
    
    set -l day_num (cn2int $day_str)
    if test -z "$day_num"
        echo $input
        return
    end
    
    set -l offset (math "$day_num - 1")
    echo "$base+$offset"d
end

function _task_parse_month
    set -l input $argv[1]
    set -l base "soy"
    
    if string match -qr '^前年' -- $input
        set base "sopy"
    else if string match -qr '^明年' -- $input
        set base "sony"
    end
    
    set -l month_str (string match -r '([0-9一二三四五六七八九十百]+)月' -- $input)[2]
    
    if test -z "$month_str"
        echo $input
        return
    end
    
    set -l month_num (cn2int $month_str)
    if test -z "$month_num"
        echo $input
        return
    end
    
    if string match -qr '月[0-9一二三四五六七八九十百零兩两]+$' -- $input
        echo $input
        return
    end
    
    set -l offset (math "$month_num - 1")
    echo "$base+$offset"m
end

function _task_parse_datetime
    set -l input $argv[1]
    set -l base "sod"
    set -l offset_day -1
    
    if string match -qr '今年' -- $input
        set base "soy"
        set offset_day -1
        
        if string match -qr '([0-9一二三四五六七八九十百]+)月' -- $input
            set -l month_str (string match -r '([0-9一二三四五六七八九十百]+)月' -- $input)[2]
            if test -n "$month_str"
                set -l month_num (cn2int $month_str)
                if test -n "$month_num"
                    set -l month_offset (math "$month_num - 1")
                    set base "$base+$month_offset"m
                end
            end
        end
        
        if string match -qr '([0-9一二三四五六七八九十百零兩两]+)[號号]' -- $input
            set -l day_str (string match -r '([0-9一二三四五六七八九十百零兩两]+)[號号]' -- $input)[2]
            if test -n "$day_str"
                set -l day_num (cn2int $day_str)
                if test -n "$day_num"
                    set offset_day (math "$day_num - 1")
                end
            end
        end
    else if string match -qr '明年' -- $input
        set base "sony"
        set offset_day -1
        
        if string match -qr '([0-9一二三四五六七八九十百]+)月' -- $input
            set -l month_str (string match -r '([0-9一二三四五六七八九十百]+)月' -- $input)[2]
            if test -n "$month_str"
                set -l month_num (cn2int $month_str)
                if test -n "$month_num"
                    set -l month_offset (math "$month_num - 1")
                    set base "$base+$month_offset"m
                end
            end
        end
        
        if string match -qr '([0-9一二三四五六七八九十百零兩两]+)[號号]' -- $input
            set -l day_str (string match -r '([0-9一二三四五六七八九十百零兩两]+)[號号]' -- $input)[2]
            if test -n "$day_str"
                set -l day_num (cn2int $day_str)
                if test -n "$day_num"
                    set offset_day (math "$day_num - 1")
                end
            end
        end
    else if string match -qr '去年' -- $input
        set base "sopy"
        set offset_day -1
        
        if string match -qr '([0-9一二三四五六七八九十百]+)月' -- $input
            set -l month_str (string match -r '([0-9一二三四五六七八九十百]+)月' -- $input)[2]
            if test -n "$month_str"
                set -l month_num (cn2int $month_str)
                if test -n "$month_num"
                    set -l month_offset (math "$month_num - 1")
                    set base "$base+$month_offset"m
                end
            end
        end
        
        if string match -qr '([0-9一二三四五六七八九十百零兩两]+)[號号]' -- $input
            set -l day_str (string match -r '([0-9一二三四五六七八九十百零兩两]+)[號号]' -- $input)[2]
            if test -n "$day_str"
                set -l day_num (cn2int $day_str)
                if test -n "$day_num"
                    set offset_day (math "$day_num - 1")
                end
            end
        end
    else
        if string match -qr '^今天' -- $input
            set offset_day 0
        else if string match -qr '^明天' -- $input
            set offset_day 1
        else if string match -qr '^後天|^后天' -- $input
            set offset_day 2
        else if string match -qr '^大後天|^大后天' -- $input
            set offset_day 3
        else if string match -qr '[0-9一二三四五六七八九十百零兩两]+[號号]' -- $input
            set base "som"
            set -l day_str (string match -r '([0-9一二三四五六七八九十百零兩两]+)[號号]' -- $input)[2]
            if test -n "$day_str"
                set -l day_num (cn2int $day_str)
                if test -n "$day_num"
                    set offset_day (math "$day_num - 1")
                end
            end
            
            if string match -qr '上(個|个)?月' -- $input
                set base "sopm"
            else if string match -qr '下(個|个)?月' -- $input
                set base "sonm"
            else if string match -qr '(這|这)(個|个)?月' -- $input
                set base "som"
            end
        end
    end
    
    set -l result $base
    
    if test $offset_day -ge 0
        set result "$result+$offset_day"d
    end
    
    if string match -qr '早上|上午' -- $input
        set -l hour_str (string match -r '(早上|上午)([0-9一二三四五六七八九十百零兩两]+)[點点]' -- $input)[3]
        if test -n "$hour_str"
            set -l hour_num (cn2int $hour_str)
            if test -n "$hour_num"
                set result "$result+$hour_num"h
            end
        end
    else if string match -qr '下午|晚上' -- $input
        set -l hour_str (string match -r '(下午|晚上)([0-9一二三四五六七八九十百零兩两]+)[點点]' -- $input)[3]
        if test -n "$hour_str"
            set -l hour_num (cn2int $hour_str)
            if test -n "$hour_num"
                set -l final_hour (math "$hour_num + 12")
                set result "$result+$final_hour"h
            end
        end
    else if string match -qr '[0-9一二三四五六七八九十百零兩两]+[點点]' -- $input
        set -l hour_str (string match -r '([0-9一二三四五六七八九十百零兩两]+)[點点]' -- $input)[2]
        if test -n "$hour_str"
            set -l hour_num (cn2int $hour_str)
            if test -n "$hour_num"
                set result "$result+$hour_num"h
            end
        end
    end
    
    if string match -qr '半' -- $input
        set result "$result+30min"
    else if string match -qr '[0-9一二三四五六七八九十百零兩两]+分' -- $input
        set -l min_str (string match -r '([0-9一二三四五六七八九十百零兩两]+)分' -- $input)[2]
        if test -n "$min_str"
            set -l min_num (cn2int $min_str)
            if test -n "$min_num"
                set result "$result+$min_num"min
            end
        end
    end
    
    if string match -qr '[0-9一二三四五六七八九十百零兩两]+秒' -- $input
        set -l sec_str (string match -r '([0-9一二三四五六七八九十百零兩两]+)秒' -- $input)[2]
        if test -n "$sec_str"
            set -l sec_num (cn2int $sec_str)
            if test -n "$sec_num"
                set result "$result+$sec_num"s
            end
        end
    end
    
    echo $result
end
