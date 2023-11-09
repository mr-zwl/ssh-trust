#!/bin/bash
# 自动化创建密钥和分发
ip_list=`cat ./ip_list`
echo '###################################################'
echo '                1.创建key'
echo '##################################################'
ssh-keygen  -f ~/.ssh/id_rsa -P ''

echo '###################################################'
echo '                2.分发 pub key'
echo '##################################################'


# 安装sshpass
#! /bin/bash
if type sshpass >/dev/null 2>&1; then 
	echo 'sshpass 已存在' 
else 
	echo '正在安装sshpass' 
	yum  install gcc make -y  >& /dev/null
    tar -xvf ./sshpass.tar.gz  >& /dev/null
    cd ./sshpass-1.10  >& /dev/null
    ./configure >& /dev/null
    make  >& /dev/null
    make install >& /dev/null
fi

for ip in $ip_list
do

# -p 参数是指定密码，最好机器密码一致可同步执行
	sshpass -p 'zwl159459...' ssh-copy-id -i ~/.ssh/id_rsa.pub -o StrictHostKeyChecking=no root@$ip

done
