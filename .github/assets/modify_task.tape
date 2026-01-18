# modify_task.tape

Output .github/assets/modify_task.gif

Set Shell fish
Set FontSize 20
Set Width 1050
Set Height 450
Set Padding 20
Set Framerate 15
Set FontFamily "霞鶩文楷等寬 TC, JetBrains Mono"
Set Theme "Dracula"

Hide
    Type "set -x TASKDATA /tmp/vhs_task_demo"
    Enter

    Type "source ~/.config/fish/functions/cn2int.fish"
    Enter
    Type "source ~/.config/fish/functions/taskwarrior_parse_date.fish"
    Enter
    Type "source ~/.config/fish/conf.d/task.fish"
    Enter

    Type "bind " " _task_smart_expand_space"
    Enter

    Type "function fish_prompt; echo -e '\033[1;32m➜ \033[0m'; end"
    Enter
    Type "function fish_right_prompt; end"
    Enter

    Type "clear"
    Enter
Show

Sleep 500ms
Type "task mod 1"
Sleep 2s
Space
Sleep 2s

Type "，在這裡再加點東西吧"
Sleep 2s
Enter

Sleep 5s
