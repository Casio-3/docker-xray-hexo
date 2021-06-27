# docker-xray-hexo
Docker-compose for Xray-core and Hexo Blog with webhook.

Aim：

Hexo **博客**挂到自己的域名上 + **梯子**

## Intro

通过 Docker-compose 简易部署 [Xray-core](https://github.com/XTLS/Xray-core) 和 Web 服务（Hexo 博客的 webhook 实现）

在 Xray 安装的同时部署了 Web 服务，方便建立博客 + 搭建梯子。

原理：Nginx 监听宿主机 80 端口，将流量重定向至 443 端口。而 Xray 监听宿主机 443 端口，识别出 Vless 协议的流量后按照 Xray 设置的规则处理，非 Vless 流量全部转发至 Nginx 容器的 8080 端口（即网站）。9000 端口供 webhook 使用。

结构参考：

```
.
├── cert
│   ├── xray.crt
│   └── xray.key
├── docker-compose.yml
├── Dockerfile
├── nginx
│   ├── conf.d
│   │   └── default.conf
│   ├── nginx_logs
│   │   ├── access.log
│   │   └── error.log
│   ├── web_logs
│   │   └── yourdomain.com.log
│   └── www
│       └── hexo
│           ├── index.html
|           └── *
├── README.md
├── webhook
│   ├── hooks.json
│   ├── redeploy.sh
│   └── git.log
└── xray
    ├── config
    │   └── config.json
    └── logs
        ├── access.log
        └── error.log
```



目前进展，

- [x] Nginx 起 Web 服务
- [x] webhook 更新 blog
- [x] Xray 通网



## Tips

不建议使用 `git pull` 拉取本仓库，因为 webhook 的更新脚本是使用 `git pull` 拉取的 Github Pages，会引发一些冲突，可能会耗费更多时间折腾。

- 证书的申请参考 [Thanks](#Thanks) ，仓库里的证书都是空文件，需要申请后对应替换
- docker-compose.yml 可以不修改
- Dockerfile 为自制用于上传 Docker Hub，可以删去
- nginx 的 default.conf 需结合网站配置
- hexo 目录名可能会调整（直接 `git pull` 而不改名的话），需对应修改 webhook
- xray 配置自行参考
- 有些非配置目录是在挂载运行后生成的



## Logs

**Webhook** 踩坑：

- redeploy.sh 需要给予执行权限

  遇到的报错：

  ```plain
  Error occurred while executing the hook's command. Please check your logs for more details.
  ```

- redeploy.sh 带了Windows换行符

  遇到的报错：

  ```plain
  /bin/sh^M: bad interpreter: No such file or directory
  ```

- webhook 配置 match 时的一些困难

**Xray** ：

挺怪的，Xray 最后通网的原因是因为我在客户端填上了伪装域名这一栏，

~~喜闻乐见~~的 503 和 `io:read write on closed pipe` 终于没了

然后发现我地址填 ip 的时候需要填伪装域名才不报 503，

地址直接填域名的话就好了( •̀ ω •́ )y

## Pics

![image-20210628001329324](https://i.loli.net/2021/06/28/NjdYh92pItFWlLS.png)

## Thanks

https://github.com/Nativu5/docker-xray-web 

感谢 Nativu5 的项目为我提供灵感、参照，以及本人的指导😀



webhook综合参阅：

https://github.com/adnanh/webhook

https://www.fanhaobai.com/2018/03/hexo-deploy.html

https://www.liuin.cn/2018/03/02/%E4%BD%BF%E7%94%A8Docker%E9%83%A8%E7%BD%B2Hexo%E5%8D%9A%E5%AE%A2/

