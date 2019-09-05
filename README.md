# frp-docker

此项目提供用于docker环境下的frp部署操作

## 部署步骤

1. 克隆此项目到你喜欢的地方
  ```
  git clone https://github.com/sudot/frp-docker.git frp
  ```

2. 进入克隆后的项目文件夹内
  ```
  cd frp
  ```

3. 修改`frps.ini`中你想改变的参数
  以下是建议修改的参数
  ```
  # 管理界面的账号和密码
  dashboard_user = admin
  dashboard_pwd = admin
  
  # 用于验证客户端的密钥
  token = 12345678

  # subdomain_host is not empty, you can set subdomain when type is http or https in frpc's configure file
  # when subdomain is test, the host used by routing is test.frps.com
  subdomain_host = proxy.sudot.net
  ```

4. 安装docker环境(如果你已经安装过,并且不想重装一遍,一定要忽略此步骤)
  执行此脚本会删除已安装的docker版本,若你已安装docker且不想重新安装它,千万不要执行此脚本
  ```
  ./docker-install.sh
  ```

5. 执行`frp-install.sh`脚本
  ```
  ./frp-install.sh
  ```

到现在，你已经完成frp的部署了，在浏览器输入`http://ip:7500`即可访问

## 其它

- 若你想卸载docker环境可以执行`docker-uninstall.sh`脚本
- 若你想用nginx扩展你的服务器端口,可以参考项目内的`nginx.conf`文件
- 若你想参考一下客户端的配置,可以阅览`frpc.ini`文件