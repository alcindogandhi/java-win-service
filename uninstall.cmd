@echo off
NET SESSION >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [ERRO] Execute este script como Administrador.
    exit /b 1
)

SET "BASE_DIR=%~dp0"
SET "BASE_DIR=%BASE_DIR:~0,-1%"

SET "SERVICE_NAME=java-win-service"
SET "PRUNSRV=%BASE_DIR%\%SERVICE_NAME%.exe"

echo ===================================================
echo     REMOVENDO SERVICO: %SERVICE_NAME%
echo ===================================================

echo [INFO] Parando o servico (se estiver rodando)...
net stop %SERVICE_NAME% >nul 2>&1

echo [INFO] Removendo registro do servico...
"%PRUNSRV%" //DS//%SERVICE_NAME% >nul 2>&1

echo [SUCESSO] Servico removido com sucesso.
echo ===================================================
exit /b 0
