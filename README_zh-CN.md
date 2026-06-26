# Adminer

![Docker Image Version](https://img.shields.io/docker/v/snowdreamtech/adminer)
![Docker Image Size](https://img.shields.io/docker/image-size/snowdreamtech/adminer/latest)
![Docker Pulls](https://img.shields.io/docker/pulls/snowdreamtech/adminer)
![Docker Stars](https://img.shields.io/docker/stars/snowdreamtech/adminer)

[Adminer](https://www.adminer.org/)（前身为 phpMinAdmin）的 Docker 镜像，一个用 PHP 编写的全功能数据库管理工具。支持 MySQL、MariaDB、PostgreSQL、SQLite、MS SQL、Oracle、Elasticsearch、MongoDB 等数据库——全部集成在一个 PHP 文件中。

## 概述

本项目基于 `snowdreamtech/php`（Nginx 版本）提供生产就绪的 Adminer Docker 镜像，可选三种发行版变体：

- **Alpine** — 轻量级，最小镜像体积
- **Debian** — 默认推荐，广泛兼容
- **Rocky** — 企业级，RHEL 兼容

## 快速开始

```bash
# 拉取并运行默认的 Debian 变体
docker pull snowdreamtech/adminer:debian
docker run -d --name=adminer -p 8080:80 snowdreamtech/adminer:debian

# 通过 http://localhost:8080/adminer.php 访问 Adminer
```

## 发行版变体

### Debian（默认）

推荐用于大多数用例的变体，提供广泛的兼容性和丰富的软件包可用性。

```bash
docker run -d \
  --name=adminer \
  -p 8080:80 \
  -e TZ=Asia/Shanghai \
  --restart unless-stopped \
  snowdreamtech/adminer:debian
```

**支持的架构**：i386、amd64、arm32v5、arm32v7、arm64、riscv64、ppc64le、s390x

**基础镜像**：`snowdreamtech/php:8.4.16-nginx-debian`

### Alpine

轻量级变体，针对最小镜像大小和快速启动时间进行了优化。

```bash
docker run -d \
  --name=adminer \
  -p 8080:80 \
  -e TZ=Asia/Shanghai \
  --restart unless-stopped \
  snowdreamtech/adminer:alpine
```

**支持的架构**：i386、amd64、arm32v6、arm32v7、arm64、ppc64le、riscv64、s390x

**基础镜像**：`snowdreamtech/php:8.4.22-nginx-alpine`

### Rocky

基于 Rocky Linux 的企业级变体，适用于需要 RHEL 兼容性的生产环境。

```bash
docker run -d \
  --name=adminer \
  -p 8080:80 \
  -e TZ=Asia/Shanghai \
  --restart unless-stopped \
  snowdreamtech/adminer:rocky
```

**支持的架构**：amd64、arm64、ppc64le、s390x

**基础镜像**：`snowdreamtech/php:8.4.21-nginx-rocky`

## 构建说明

### 单架构构建

```bash
# 构建 Debian 变体
docker build -t snowdreamtech/adminer:debian ./docker/debian/

# 构建 Alpine 变体
docker build -t snowdreamtech/adminer:alpine ./docker/alpine/

# 构建 Rocky 变体
docker build -t snowdreamtech/adminer:rocky ./docker/rocky/
```

### 多架构构建

使用 `docker buildx` 为多个架构构建镜像：

```bash
# 创建并使用 buildx 构建器
docker buildx create --use --name build --node build --driver-opt network=host

# 为多个架构构建 Debian
docker buildx build \
  --platform=linux/386,linux/amd64,linux/arm/v5,linux/arm/v7,linux/arm64,linux/riscv64,linux/ppc64le,linux/s390x \
  -t snowdreamtech/adminer:debian \
  ./docker/debian/ \
  --push

# 为多个架构构建 Alpine
docker buildx build \
  --platform=linux/386,linux/amd64,linux/arm/v6,linux/arm/v7,linux/arm64,linux/ppc64le,linux/riscv64,linux/s390x \
  -t snowdreamtech/adminer:alpine \
  ./docker/alpine/ \
  --push

# 为多个架构构建 Rocky
docker buildx build \
  --platform=linux/amd64,linux/arm64,linux/ppc64le,linux/s390x \
  -t snowdreamtech/adminer:rocky \
  ./docker/rocky/ \
  --push
```

## 环境变量

所有变体都支持以下环境变量进行运行时配置：

| 变量 | 默认值 | 描述 |
|----------|---------|-------------|
| `KEEPALIVE` | `0` | 保持容器运行（1=启用，0=禁用）|
| `CAP_NET_BIND_SERVICE` | `0` | 启用绑定到特权端口（<1024）|
| `LANG` | `C.UTF-8` | UTF-8 字符支持的区域设置 |
| `UMASK` | `022` | 默认文件创建掩码 |
| `DEBUG` | `false` | 在入口点脚本中启用调试输出 |
| `PGID` | `0` | 自定义用户创建的主组 ID |
| `PUID` | `0` | 自定义用户创建的用户 ID |
| `USER` | `root` | 自定义用户创建的用户名 |
| `WORKDIR` | `/root` | 工作目录路径 |
| `TZ` | - | 时区（例如 `Asia/Shanghai`、`America/New_York`）|
| `ADMINER_VERSION` | `5.4.2` | Adminer 版本 |
| `ADMINER_SQLITE_PASSWORD` | `` | SQLite 免密登录插件的密码 |
| `ADMINER_PATH` | `/var/www/html` | Adminer Web 根目录路径 |
| `ADMINER_PLUGINS_PATH` | `/var/www/html/plugins` | Adminer 插件路径 |
| `ADMINER_DESIGNS_PATH` | `/var/www/html/designs` | Adminer 设计/主题路径 |

**Debian 特定**：

| 变量 | 默认值 | 描述 |
|----------|---------|-------------|
| `DEBIAN_FRONTEND` | `noninteractive` | Debian 软件包安装模式 |

## Docker Compose 示例

### 简单配置

```yaml
services:
  adminer:
    image: snowdreamtech/adminer:debian
    container_name: adminer
    ports:
      - "8080:80"
    environment:
      - TZ=Asia/Shanghai
    restart: unless-stopped
```

### 搭配数据库的高级配置

```yaml
services:
  adminer:
    image: snowdreamtech/adminer:debian
    container_name: adminer
    ports:
      - "8080:80"
    environment:
      - TZ=Asia/Shanghai
      - DEBUG=true
    restart: unless-stopped

  mysql:
    image: mysql:8
    container_name: mysql
    environment:
      - MYSQL_ROOT_PASSWORD=secret
    volumes:
      - mysql_data:/var/lib/mysql
    restart: unless-stopped

volumes:
  mysql_data:
```

## 语义化版本标签

镜像遵循语义化版本控制，格式为：`{major}.{minor}.{patch}-{variant}`

示例：

- `snowdreamtech/adminer:5.4.2-debian`
- `snowdreamtech/adminer:5.4.2-alpine`
- `snowdreamtech/adminer:5.4.2-rocky`

此格式允许：

- **完整版本固定**：`5.4.2-debian`（精确版本）
- **变体最新标签**：`latest-debian`（跟踪 Debian 最新版本）
- **全局最新标签**：`latest`（跟踪最新版本，默认指向 Debian）

## 架构支持

每个发行版变体都支持多个 CPU 架构，可在多样化的硬件平台上部署：

| 变体 | 架构 |
|---------|---------------|
| **Debian** | i386、amd64、arm32v5、arm32v7、arm64、riscv64、ppc64le、s390x |
| **Alpine** | i386、amd64、arm32v6、arm32v7、arm64、ppc64le、riscv64、s390x |
| **Rocky** | amd64、arm64、ppc64le、s390x |

Docker 在拉取镜像时会自动为您的平台选择适当的架构。

## 入口点系统

镜像包含一个灵活的入口点系统，在启动应用程序之前执行自定义初始化脚本。

### 工作原理

1. `docker-entrypoint.sh` 脚本在容器启动时运行
2. 它按字典顺序执行 `/usr/local/bin/entrypoint.d/` 中的所有可执行脚本
3. 每个脚本都接收容器的命令行参数
4. 如果任何脚本失败，容器将停止（快速失败行为）

### 调试模式

启用调试输出以排查入口点执行问题：

```bash
docker run -e DEBUG=true snowdreamtech/adminer:debian
```

## 参考资料

1. [Adminer 官方网站](https://www.adminer.org/)
2. [Adminer GitHub 仓库](https://github.com/vrana/adminer)
3. [使用 buildx 构建多平台 Docker 镜像](https://icloudnative.io/posts/multiarch-docker-with-buildx/)
4. [如何使用 docker buildx 构建跨平台 Go 镜像](https://waynerv.com/posts/building-multi-architecture-images-with-docker-buildx/#buildx-%E7%9A%84%E8%B7%A8%E5%B9%B3%E5%8F%B0%E6%9E%84%E5%BB%BA%E7%AD%96%E7%95%A5)
5. [Building Multi-Arch Images for Arm and x86 with Docker Desktop](https://www.docker.com/blog/multi-arch-images/)
6. [How to Rapidly Build Multi-Architecture Images with Buildx](https://www.docker.com/blog/how-to-rapidly-build-multi-architecture-images-with-buildx/)
7. [docker/buildx](https://github.com/docker/buildx)

## 联系方式（备注：adminer）

* Email: <sn0wdr1am@qq.com>
* QQ: 3217680847
* QQ群: 949022145
* WeChat/微信群: sn0wdr1am

## 许可证

MIT
