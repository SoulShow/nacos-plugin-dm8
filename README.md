# Nacos 达梦数据库插件

[![Maven Central](https://img.shields.io/maven-central/v/com.pig4cloud.plugin/nacos-datasource-plugin-dm8.svg?style=flat-square)](https://maven.badges.herokuapp.com/maven-central/com.pig4cloud.plugin/nacos-datasource-plugin-dm8)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

## 项目介绍

本插件为 Nacos（2.2.0 版本及以上）提供达梦数据库（DM8）的数据源支持。通过 SPI 机制实现，无需修改nacos源码，只需要将插件放到对应目录下即可。

![Nacos 插件架构](https://minio.pigx.top/oss/202212/1671179590.jpg)

> Nacos 官方默认支持 MySQL 和 Derby 数据库，本插件扩展了对达梦数据库的支持。

## 版本兼容性

只支持nacos2.5.1版本，如果是其他版本请参考其他项目，或者联系本人邮箱 zhitao0902@163.com

## 快速开始

### 1. 添加依赖
在nacos下新建plugins目录将DmJdbcDriver18-8.1.3.140.jar和nacos-plugin-dm8-2.5.1.jar添加到目录下

```

### 1. 数据库迁移

执行nacos-dm-2.5.1.sql，创建达梦数据库表DDL，将数据迁移到达梦库下

### 2. 配置数据源

在 Nacos application.properties 配置文件中添加以下配置：

```properties
spring.datasource.platform=dameng
db.num=1
db.url.0=jdbc:dm://192.168.20.179:5236/NACOS?schema=NACOS&compatibleMode=mysql&ignoreCase=true&ENCODING=utf-8
db.user=SYSDBA
db.password=CtRp7P64zHYymrEQxe
db.pool.config.driverClassName=dm.jdbc.driver.DmDriver

```


## 参与贡献

我们欢迎所有形式的贡献，如果您有任何改进建议或功能扩展，请提交 Pull Request。如果觉得满意可以打赏一下。
<img width="404" alt="image" src="https://github.com/user-attachments/assets/a635b5e0-e951-4d15-9acd-2bbd4b69da9a" />


## 开源协议

本项目采用 Apache License 2.0 开源协议。
