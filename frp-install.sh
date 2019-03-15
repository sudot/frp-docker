#!/bin/bash
# 项目根目录
BASE_PATH=$(cd `dirname $0`; pwd)

FRP_VERSION=0.25.1
FRP_FILE=frp_${FRP_VERSION}_linux_amd64

if [ ! -f ${FRP_FILE}.tar.gz ]; then
    wget -O ${FRP_FILE}.tar.gz https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/${FRP_FILE}.tar.gz
fi

if [ ! -d ${FRP_FILE} ]; then
    tar -zxf ${FRP_FILE}.tar.gz
fi

if [ ! -d frp ]; then
    mv ${FRP_FILE} frp
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
           -e TZ="Asia/Shanghai" \
           -v /etc/localtime:/etc/localtime:ro \
           -v $BASE_PATH/frps.ini:/opt/frp/frps.ini \
           frp
