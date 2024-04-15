# ssh-trust

# 用于集群初始化之前的ssh互信
# 适用于 centos 6.x 7.x 8.x 

## 使用方法 ： 
编辑设备IP清单 
ip_list  文件中键入 需要做互信的IP （前提  IP可以ping 通 sshd服务正常运行且为默认端口22）

执行

## 互信分发完成后，执行 sh ip_ssh_check.sh脚本
执行方式 ： sh ip_ssh_check.sh  command
eg:  sh ip_ssh_check.sh hostname
