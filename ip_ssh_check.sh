#!/bin/bash

# 检查文件是否存在且不为空
if [ ! -s ./ip_list ]; then
    echo "错误：ip_list文件不存在或为空。"
    exit 1
fi

# 读取ip_list文件内容到数组
declare -a server_ips
while read -r ip; do
    server_ips+=("$ip")
done < ./ip_list

echo '#######################################'
echo '            批量检查ssh'
echo '######################################'

# 定义一个函数，用于执行ssh检查
check_ssh() {
    local ip=$1
    local retval=0
    if ping -c 1 -W 1 "$ip" &> /dev/null; then
        # 如果主机可达，则尝试ssh连接
        ssh -o ConnectTimeout=5 -o StrictHostKeyChecking=no root@"$ip"  "$@" || retval=$?
    else
        echo "主机 $ip 不可达。"
        retval=1
    fi
    return $retval
}

# 使用并行执行来提高效率
parallel --will-cite check_ssh ::: "${server_ips[@]}"