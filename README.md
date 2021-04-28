# docker-xray-hexo
Docker-compose for Xray-core and Hexo Blog with webhook.

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
│           └── index.html
|           └── *
├── README.md
├── webhook
│   ├── hooks.json
│   └── redeploy.sh
└── xray
    ├── config
    │   └── config.json
    └── logs
```



目前还未达到预期效果，测试只能实现静态网页呈现。



## Tips

不建议使用 `git pull` 拉取本仓库，因为 webhook 的更新脚本是使用 `git pull` 拉取的 Github Pages，会引发一些冲突，可能会耗费更多时间折腾。

- 证书的申请参考 [Thanks](#Thanks) ，仓库里的证书都是空文件，需要申请后对应替换
- docker-compose.yml 可以不修改
- Dockerfile 为自制用于上传 Docker Hub，可以删去
- nginx 的 default.conf 需结合网站配置
- hexo 目录名可能会调整（直接 `git pull` 而不改名的话），需对应修改 webhook
- xray 配置自行参考
- 有些非配置目录是在运行后挂载生成的

## Thanks

https://github.com/Nativu5/docker-xray-web 

感谢 Nativu5 的项目为我提供灵感、参照，以及本人的指导😀



webhook综合参阅：

https://github.com/adnanh/webhook

https://www.fanhaobai.com/2018/03/hexo-deploy.html

https://www.liuin.cn/2018/03/02/%E4%BD%BF%E7%94%A8Docker%E9%83%A8%E7%BD%B2Hexo%E5%8D%9A%E5%AE%A2/

