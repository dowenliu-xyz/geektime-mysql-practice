Geektime MySQL 实战45讲 实验环境及记录
---
当前项目记录了 Geektime MySQL 实战45讲 的实验环境及操作 SQL 记录。

> 当前项目为 Jetbrains DataGrip Project.

> 注意：当前实验环境在 macOS 系统下 、 安装 OrbStack 时直接可用，
> 其他系统或使用 Docker Desktop 需要自行调整 Datasource 配置。

> OrbStack domains 功能好像有点bug：
> 如果 docker compose 启动的容器达到一定数量，新开的容器无法通过 domain 连接访问。
> 所以，测试完对应 case 后注意及时 down 掉对应的 compose。
