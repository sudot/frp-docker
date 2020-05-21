# frp-docker

此项目提供用于docker环境下的frp部署操作

## 服务端部署

1. 克隆此项目到你喜欢的地方
  ```bash
  git clone https://github.com/sudot/frp-docker.git frp
  ```

2. 进入克隆后的项目文件夹内
  ```bash
  cd frp
  ```

3. 修改`frps.ini`中你想改变的参数
    以下是建议修改的参数
  ```bash
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
  ```bash
  ./docker-install.sh
  ```

5. 执行`frp-install.sh`脚本
  ```bash
  ./frp-install.sh
  ```

6. 云服务器开墙

   若你使用的是云服务器，一般情况下都会因为安全策略限制无法正常访问，你需要放行 7500 和 7000 两个端口。你也可以使用 nginx 将指定域名通过 80 端口转发至 7500 端口，这样你只需要放行 7000 端口即可。

到现在，你已经完成frp的部署了，在浏览器输入`http://ip:7500`即可访问。

### 客户端使用

#### 安装

下载 frp：https://github.com/fatedier/frp/releases

> 其实里面包含客户端和服务端，我们只用客户端即可。

解压后修改 `frpc.ini`

```bash
[common]
server_addr = 你服务器的ip地址
server_port = 7000
# 与 frps.ini 中的 token 保持一致,用于验证客户端的合法性
token = 12345678

[web]
# 协议类型,一般本地调试都是http协议..如:http://localhost:8080,则 type 就是 http
type = http
# 本地服务的端口,也就是你应用本地访问时在浏览器输入的端口.如:http://localhost:8080,则 local_port 就是 8080
local_port = 8080
# 子域名,你配置给 frp 对外暴露的域名前的子域名.如:服务端绑定域名是 proxy.abc.com，且subdomain填写了wechat，则外网访问的最终域名为 wechat.proxy.abc.com
subdomain = wechat
host_header_rewrite = 127.0.0.1
```

#### 运行

**windows**

```bash
frpc.exe -c frpc.ini
```

**mac / linux**

```
./frpc -c frpc.ini
```

## 其它

- 若你想卸载 docker 环境可以执行 `docker-uninstall.sh` 脚本
- 若你想用 nginx 扩展你的服务器端口，可以参考项目内的 `nginx.conf` 文件
- 若你想参考一下客户端的配置，可以阅览 `frpc.ini` 文件