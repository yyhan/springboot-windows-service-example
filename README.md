# springboot-windows-service-example
springboot 打包成 windows 服务示例

# 目录结构
```text
<app_home>      ; windows 服务安装目录（${user.dir} 目录）
    /bin        ; 二进制程序、脚本、可执行 jar 等路径
    /config     ; 配置文件路径：spring 配置、log4j2 配置等
    /lib        ; 依赖包存放路径（${java.ext.dirs} 目录）
    /temp       ; 临时文件路径（${java.io.tmpdir} 目录），执行 install.bat 脚本时生成
    /logs       ; 日志文件路径，执行 install.bat 脚本时生成

```
