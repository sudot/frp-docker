#停止docker
systemctl stop docker
#移除docker自启配置
systemctl disable docker

#卸载旧版本docker
yum remove docker \
           docker-client \
           docker-client-latest \
           docker-common \
           docker-latest \
           docker-latest-logrotate \
           docker-logrotate \
           docker-selinux \
           docker-engine-selinux \
           docker-engine
