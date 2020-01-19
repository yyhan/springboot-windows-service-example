@echo off

set "BIN_DIR=%CD%"
cd ..
set "HOME_DIR=%CD%"

set "SERVICE_NAME=${project.service.name}"

set "EXECUTABLE=%BIN_DIR%\${project.service.name}-service_x64.exe"

%EXECUTABLE% //DS//%SERVICE_NAME%

:end