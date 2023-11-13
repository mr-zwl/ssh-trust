#!/bin/bash
#检查密钥是否分发

ip_list=`cat ./ip_list`
echo '#######################################'
echo '            批量检查ssh'
echo '######################################'

# 不跟命令会登陆到IP_list机器 ， 直接在bash 脚本后面跟shell命令会执行

for ip in $ip_list
do
	ssh root@$ip  hostname -f|cut -d'.' -f1 ; $@
done

 
