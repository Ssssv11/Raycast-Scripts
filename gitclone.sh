#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title GitClone
# @raycast.mode compact

# Optional parameters:
# @raycast.icon images/git.png

# Documentation:
# @raycast.author Ssssv

gitWebUrl="git clone $(pbpaste)" # 拼接 git clone 命令行
path=$(osascript <<'EOF'
    tell application "Finder"
        if exists Finder window 1 then
            get the POSIX path of (target of Finder window 1 as alias)
        else
            get the POSIX path of (desktop as alias)
        end if
    end tell
EOF
)
currentPath=$path # 获取剪贴板中的当前目录路径
cd $currentPath && $gitWebUrl # 进入目录并执行 git clone 命令
echo "✔︎ Done!" # 显示成功信息

