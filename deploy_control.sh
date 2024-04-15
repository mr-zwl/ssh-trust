#!/bin/bash

# 定义脚本路径
INSTALL_SSHPASS_SCRIPT="sshpass_install.sh"
MAIN_SCRIPT="ip_ssh_fenfa.sh"

# 检查依赖脚本是否存在
for script in $INSTALL_SSHPASS_SCRIPT $MAIN_SCRIPT; do
    if [ ! -f "$script" ]; then
        echo "脚本 $script 不存在，请检查路径。"
        exit 1
    fi
done

# 安装 sshpass
echo "开始安装 sshpass..."
bash "$INSTALL_SSHPASS_SCRIPT"

if [ $? -ne 0 ]; then
    echo "sshpass 安装失败！"
    exit 1
else
    echo "sshpass 安装成功。"
fi

# 执行主脚本
echo "开始部署密钥..."
bash "$MAIN_SCRIPT"

if [ $? -ne 0 ]; then
    echo "密钥部署失败！"
    exit 1
else
    echo "密钥部署成功。"
fi

echo "所有任务已完成。"