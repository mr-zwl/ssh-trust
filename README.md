# ssh-trust

# 用于集群初始化之前的ssh互信
# 适用于linux下的ssh互信脚本

## 使用方法 ： 
编辑设备IP清单 
ip_list  文件中键入 需要做互信的IP （前提  IP可以ping 通 sshd服务正常运行且为默认端口22，如端口不是22也可以修改脚本中指定的端口 但需要保证同一批IP使用端口和密码一致）

## 执行deploy_control.sh 脚本部署密钥


## 互信分发完成后，执行 sh ip_ssh_check.sh脚本
执行方式 ：

bash ip_ssh_check.sh
直接执行脚本只进行探测返回是否连接成功


bash ip_ssh_check.sh  command 
传入一个参数会被当做远程执行命令 示例如下
eg:  sh ip_ssh_check.sh "hostname"
