# springboot-windows-service-example
springboot 打包成 windows 服务示例

## 依赖
+ springboot
+ [maven-assembly-plugin](http://maven.apache.org/plugins/maven-assembly-plugin/index.html)
+ [apache commons-daemon](https://commons.apache.org/proper/commons-daemon/)

## 打包 & 部署
+ 1、修改 `pom.xml`：  
    ```xml
    <!-- windows 服务名称 -->
    <project.service.name>${project.artifactId}</project.service.name>
    <!-- windows 服务显示名称 -->
    <project.service.displayName>${project.name}</project.service.displayName>
    <!-- windows 服务描述 -->
    <project.service.description>${project.description}</project.service.description>
    <!-- 打包为 windows 服务时，使用的入口类 -->
    <project.service.mainClass>org.yugong.daemon.MainApp</project.service.mainClass>
    ```
+ 2、打包：  
    ```shell script
    mvn clean package
    ```
+ 3、安装服务：
    + 3.1、 将 `target/${project.service.name}-windows-service.zip` 文件复制到目的地目录下，并解压。  
        例如：`C:\Program Files\${project.service.name}`。
    + 3.2、 修改 `bin/install.bat` 脚本中的 `Jvm` 变量，改为你自己的路径。  
        例如：`set "Jvm=C:\jdk1.8.0_181\jre\bin\server\jvm.dll"`
    + 3.3、 在 `bin` 目录下打开一个命令行窗口，然后执行 `.\install.bat` 安装服务。
        > 弹出窗口，点击 `是` 即可。
+ 4、启动服务  
    运行 `bin/${project.service.name}.exe`，点击 `start` 按钮启动服务。
    > 弹出窗口，点击 `是` 即可。
+ 5、停止服务  
    运行 `bin/${project.service.name}.exe`，点击 `stop` 按钮停止服务。
    > 弹出窗口，点击 `是` 即可。
+ 6、卸载服务  
    在 `bin` 目录下打开一个命令行窗口，然后执行 `.\uninstall.bat` 脚本卸载服务。
    > 弹出窗口，点击 `是` 即可。

## 核心文件说明
### deploy 目录
deploy 存放二进制文件、脚本。  

+ install.bat：  
    windows 服务安装脚本
+ uninstall.bat：  
    windows 服务卸载脚本
+ prunmgr.exe：    
    windows 服务管理程序。打包后，该程序会被重命名为： `${project.service.name}.exe`（必须与最终的 windows 服务名称一致）。
服务安装成功后，可通过该程序启动、停止服务；调整服务的一些配置，例如：启动参数、jvm配置等
+ prunsrv.exe：    
    windows 服务程序
+ amd64/prunsrv.exe：    
    `amd64` 处理器架构的 `prunsrv.exe`。

### assembly.xml 
`assembly.xml` 是 `maven-assembly-plugin` 的描述文件，用于配置打包规则。

## 安装包目录结构

```text
<app_home>      ; windows 服务安装目录（${user.dir} 目录）
    /bin        ; 二进制程序、脚本、可执行 jar 等路径
    /config     ; 配置文件路径：spring 配置、log4j2 配置等
    /lib        ; 依赖包存放路径（${java.ext.dirs} 目录）
    /temp       ; 临时文件路径（${java.io.tmpdir} 目录），执行 install.bat 脚本时生成
    /logs       ; 日志文件路径，执行 install.bat 脚本时生成
```


## License
Copyright (c) 小天. All rights reserved.

Licensed under the BSD 2-Clause license.

