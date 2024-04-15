#!/bin/bash

# 读取IP列表
ip_list=$(<./ip_list)
if [ -z "$ip_list" ]; then
    echo "IP列表为空"
    exit 1
fi

echo '###################################################'
echo '                1.创建key'
echo '##################################################'

# 生成密钥，检查是否有错误
ssh-keygen -f ~/.ssh/id_rsa -P '' >/dev/null
if [ $? -ne 0 ]; then
    echo "创建密钥失败"
    exit 1
fi

echo '###################################################'
echo '                2.分发 pub key'
echo '##################################################'

# 使用环境变量来获取密码
password=123456
echo "请输入密码："
read -s password

for ip in $ip_list; do
    # 检查IP地址有效性
    if ! [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        echo "无效的IP地址: $ip"
        continue
    fi

    # 分发公钥，检查是否有错误
    sshpass -p "$password" ssh-copy-id -i ~/.ssh/id_rsa.pub -o StrictHostKeyChecking=no root@$ip
    if [ $? -ne 0 ]; then
        echo "向 $ip 分发密钥失败"
    else
        echo "成功向 $ip 分发密钥"
    fi
done