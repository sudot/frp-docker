#卸载已安装的docker环境
`dirname $0`/docker-uninstall.sh
#安装yum工具
yum install -y yum-utils \
            device-mapper-persistent-data \
            lvm2
#配置yum国内docker源
yum-config-manager \
    --add-repo \
    https://mirrors.ustc.edu.cn/docker-ce/linux/centos/docker-ce.repo
#配置docker版本
yum-config-manager --enable docker-ce-edge

#安装Docker CE
yum makecache fast
yum install docker-ce

#配置docker开机自启
systemctl enable docker
#立刻启动docker
systemctl start docker
