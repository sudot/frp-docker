#!/bin/bash
# 项目根目录
BASE_PATH=$(cd `dirname $0`; pwd)
cd $BASE_PATH
export PATH=$BASE_PATH:$PATH
chmod +x jq
FRP_VERSION=$(curl -s https://api.github.com/repos/fatedier/frp/releases/latest | jq -r '.tag_name')
FRP_FILE_NAME=frp_${FRP_VERSION#*v}_linux_amd64
FRP_FILE=${FRP_FILE_NAME}.tar.gz

if [ ! -f ${FRP_FILE} ]; then
    wget -O ${FRP_FILE} https://github.com/fatedier/frp/releases/download/${FRP_VERSION}/${FRP_FILE}
fi

if [ ! -d ${FRP_FILE} ]; then
    tar -zxf ${FRP_FILE}
fi

if [ ! -d frp ]; then
    mv ${FRP_FILE_NAME} frp
fi

#创建docker容器互联网络
NETWORK_NAME=docker-net
docker network create -d bridge $NETWORK_NAME

# 移除旧容器和镜像,并编译新镜像和创建新容器
docker stop frp
docker container rm frp
docker image rm frp
docker build -t frp .
docker run --name frp \
           --network $NETWORK_NAME \
           -d \
           -p 7000:7000 \
           -p 7500:7500 \
           -e TZ="Asia/Shanghai" \
           -v /etc/localtime:/etc/localtime:ro \
           -v $BASE_PATH/frps.ini:/opt/frp/frps.ini \
           frp

rm -rf frp
rm -rf $FRP_FILE_NAME