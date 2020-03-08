@echo off

chcp 65001

setlocal

echo 【 ==== 开始安装 ==== 】

::::::::::::::::::::::::::::::::::::::::
:: 检查是否以管理员身份运行
::::::::::::::::::::::::::::::::::::::::
fltmc > nul && (
    echo 正在以管理员身份运行
)||(
    echo 请以管理员身份运行!!
    goto end
)

::::::::::::::::::::::::::::::::::::::::
:: 修正根目录
::::::::::::::::::::::::::::::::::::::::
cd /d %~dp0

REM 上一级目录作为 home 目录
cd ..

::::::::::::::::::::::::::::::::::::::::
:: 变量定义
::::::::::::::::::::::::::::::::::::::::
set "HOME_DIR=%CD%"
set "BIN_DIR=%HOME_DIR%\bin"
set "LIB_DIR=%HOME_DIR%\lib"
set "CONFIG_DIR=%HOME_DIR%\config"
set "TEMP_DIR=%HOME_DIR%\temp"
set "LOG_DIR=%HOME_DIR%\logs"

set "SERVICE_NAME=${project.service.name}"
set "SERVICE_DISPLAY_NAME=${project.service.displayName}"
set "SERVICE_DESC=${project.service.description}"

set "SERVICE_STARTUP_MODE=manual"

set "EXECUTABLE=%BIN_DIR%\${project.service.name}-service_x64.exe"

set "CLASSPATH=%BIN_DIR%\${project.build.finalName}.jar"

rem jvm 路径设置
rem set "Jvm=C:\jdk1.8.0_181\jre\bin\server\jvm.dll"

set "JVM_OPTS=-Xms750m;-Xmx1024m"
set "JVM_OPTS=%JVM_OPTS%;-Dfile.encoding=UTF-8"
set "JVM_OPTS=%JVM_OPTS%;-Duser.timezone=Asia/Shanghai"
set "JVM_OPTS=%JVM_OPTS%;-Duser.dir=%HOME_DIR%"
set "JVM_OPTS=%JVM_OPTS%;-Djava.io.tmpdir=%TEMP_DIR%"
set "JVM_OPTS=%JVM_OPTS%;-Djava.ext.dirs=%LIB_DIR%"
set "JVM_OPTS=%JVM_OPTS%;-Dlog4j2.configurationFile=%CONFIG_DIR%\log4j2.xml"

set "PROGRAM_ARGS=--spring.config.location=%CONFIG_DIR%\application.properties"

::::::::::::::::::::::::::::::::::::::::
:: 路径检查和创建
::::::::::::::::::::::::::::::::::::::::
if not exist %TEMP_DIR% (
    mkdir %TEMP_DIR%
)
if not exist %LOG_DIR% (
    mkdir %LOG_DIR%
)

::::::::::::::::::::::::::::::::::::::::
:: 执行安装命令
::::::::::::::::::::::::::::::::::::::::
"%EXECUTABLE%" //IS//%SERVICE_NAME% ^
    --Description "%SERVICE_DESC%" ^
    --DisplayName "%SERVICE_DISPLAY_NAME%" ^
    --Install "%EXECUTABLE%" ^
    --ServiceUser "LocalSystem" ^
    --LogPath "%LOG_DIR%" ^
    --StdOutput auto ^
    --StdError auto ^
    --Classpath "%CLASSPATH%" ^
    --Jvm "%Jvm%" ^
    --StartMode jvm ^
    --StopMode jvm ^
    --StartClass ${project.service.mainClass} ^
    --StopClass ${project.service.mainClass} ^
    --StartMethod main ^
    --StopMethod main ^
    --StartParams start;%PROGRAM_ARGS% ^
    --StopParams stop ^
    --JvmOptions "%JVM_OPTS%" ^
    --Startup "%SERVICE_STARTUP_MODE%"


:end
echo 【 ==== 安装结束 ==== 】

REM 按任意键退出
pause

