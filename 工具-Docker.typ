#import "lib/lib.typ": *
#show: chapter-style.with(title: "Docker 入门", info: info-tool)

= container

== run

#let data = csv("data/tools-docker.csv")
#figure(
  tableq(data, 5),
  caption: "命令行参数",
)

== 其他

= image

= compose

== 对应关系

```shell
docker run -d --name nginx_host -p 8080:80 -v /opt/nginx:/opt/nginx/html nginx:latest
```
上述命令可转写为 `docker-compose.yml` 文件：

#let compose = read("data/dockerc.yml")
#code(compose, lang: "yaml")
