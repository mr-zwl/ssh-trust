#!/bin/bash

if type sshpass >/dev/null 2>&1; then 
    echo 'sshpass 已存在' 
else 
    echo '正在安装sshpass' 
    yum install gcc make -y >&2
    tar -xvf ./sshpass.tar.gz >&2
    cd ./sshpass-1.10 >&2
    ./configure >&2
    make >&2
    make install >&2
    if ! type sshpass >/dev/null 2>&1; then
        echo "sshpass 安装失败"
        exit 1
    fi
fi