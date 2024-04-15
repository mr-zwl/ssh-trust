#!/bin/bash

# 读取IP列表，忽略空行和注释行
ip_list=$(grep -v '^$' ./ip_list | grep -v '^#')

# 检查是否提供了远程执行命令参数
remote_command="${1:-}"

echo '#######################################'
echo '            批量检查ssh'
echo '#######################################'

# 使用xargs并行执行ssh检查，直接在命令中处理错误
echo "$ip_list" | xargs -n1 -P4 -I{} sh -c '
    ip="{}"
    remote_command="'"$remote_command"'"
    if ping -c1 -W1 "$ip" &>/dev/null; then
        if ssh -o BatchMode=yes root@$ip true; then
            echo "成功连接到 $ip"
            if [ -n "$remote_command" ]; then
                echo "执行远程命令: $remote_command"
                ssh -o BatchMode=yes root@$ip "$remote_command"
            fi
        else
            echo "无法连接到 $ip"
        fi
    else
        echo "无法访问 $ip (可能的原因：无效IP、DNS解析问题、网络问题)"
    fi
'