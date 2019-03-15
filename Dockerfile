FROM centos:7
MAINTAINER tangjialin <taogarfield@hotmail.com>

COPY ./frp /opt/frp

EXPOSE 80 443 7000 7001 7500

ENTRYPOINT ["/opt/frp/frps", "-c", "/opt/frp/frps.ini"]
