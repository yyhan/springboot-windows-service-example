@echo off

chcp 65001

setlocal

echo 【 ==== 开始卸载 ==== 】


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

set "EXECUTABLE=%BIN_DIR%\${project.service.name}-service_x64.exe"


::::::::::::::::::::::::::::::::::::::::
:: 执行卸载命令
::::::::::::::::::::::::::::::::::::::::
%EXECUTABLE% //DS//%SERVICE_NAME%


:end
echo 【 ==== 卸载结束 ==== 】

REM 按任意键退出
pause
