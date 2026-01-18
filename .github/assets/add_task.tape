# add_task.tape

Output .github/assets/add_task.gif

Set Shell fish
Set FontSize 20
Set Width 1050
Set Height 450
Set Padding 20
Set Framerate 15
Set FontFamily "霞鶩文楷等寬 TC, JetBrains Mono"
Set Theme "Dracula"

Hide
    Type "rm -rf /tmp/vhs_task_demo"
    Enter
    Type "mkdir -p /tmp/vhs_task_demo"
    Enter
    Type "set -x TASKDATA /tmp/vhs_task_demo"
    Enter

    Type "source ~/.config/fish/functions/cn2int.fish"
    Enter
    Type "source ~/.config/fish/functions/taskwarrior_parse_date.fish"
    Enter
    Type "source ~/.config/fish/conf.d/task.fish"
    Enter

    Type 'abbr --add --command task --set-cursor addl add "%" 領域：Lab 專案： 優先級：L 標籤：'
    Enter

    Type "bind ' ' self-insert expand-abbr"
    Enter

    Type "function fish_prompt; echo -e '\033[1;32m➜ \033[0m'; end"
    Enter
    Type "function fish_right_prompt; end"
    Enter

    Type "clear"
    Enter
Show

Sleep 500ms
Type "task addl"
Sleep 2s
Space
Sleep 2s

Type "這是個任務"
Sleep 2s
Right @100ms 11
Sleep 1s

Type "嗨起來"
Sleep 1s
Right @100ms 11
Sleep 1s

Type "期限：明年年底"
Sleep 1s
Space
Sleep 1s
Type "預定：這周末"
Sleep 3s
Enter
Sleep 3s

Type "task list"
Sleep 1s
Enter
Sleep 10s
