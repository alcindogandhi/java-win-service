@echo off
setlocal enabledelayedexpansion

:: Garante permissao de administrador
NET SESSION >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [ERRO] Execute este script como Administrador.
    exit /b 1
)

:: Define a pasta do script atual como base
SET "BASE_DIR=%~dp0"
SET "BASE_DIR=%BASE_DIR:~0,-1%"

:: Variaveis de Configuracao
if not defined JAVA_HOME (
    SET "JAVA_HOME=C:\Bin\Java\jdk-21"
)
SET "PATH=%JAVA_HOME%\bin;%PATH%"
SET "SERVICE_NAME=java-win-service"
SET "JAR_PATH=%BASE_DIR%\target\java-win-service-1.0.0.jar"
SET "PRUNSRV=%BASE_DIR%\%SERVICE_NAME%.exe"
SET "JVM_PATH=%JAVA_HOME%\bin\server\jvm.dll"
SET "LOG_PATH=%BASE_DIR%\logs"
SET "DISPLAY_NAME=JavaWinService"
SET "DESCRIPTION=Servico em segundo plano criado em Java"
SET "MAIN_CLASS=org.java.example.MainService"

echo ===================================================
echo     INSTALANDO SERVICO: %SERVICE_NAME%
echo ===================================================

if %ERRORLEVEL% NEQ 0 (
    echo [ERRO] Falha ao copiar o executavel do servico.
    exit /b 1
)

if not exist "%JAR_PATH%" (
    echo [ERRO] JAR da aplicacao nao encontrado: %JAR_PATH%
    exit /b 1
)

if not exist "%JVM_PATH%" (
    echo [ERRO] jvm.dll nao encontrada em: %JVM_PATH%
    echo [ERRO] Ajuste JAVA_HOME para uma JDK/JRE valida antes de instalar.
    exit /b 1
)

if not exist "%LOG_PATH%" (
    mkdir "%LOG_PATH%"
    echo [INFO] Pasta de logs criada.
)

echo [INFO] Instalando o servico...
"%PRUNSRV%" //IS//%SERVICE_NAME% ^
    --DisplayName="%DISPLAY_NAME%" ^
    --Description="%DESCRIPTION%" ^
    --Install="%PRUNSRV%" ^
    --Jvm="%JVM_PATH%" ^
    --Classpath="%JAR_PATH%" ^
    --StartMode=jvm ^
    --StartClass=%MAIN_CLASS% ^
    --StartMethod=start ^
    --StopMode=jvm ^
    --StopClass=%MAIN_CLASS% ^
    --StopMethod=stop ^
    --Startup=auto ^
    --LogPath="%LOG_PATH%" ^
    --LogPrefix=prunsrv ^
    --StdOutput=auto ^
    --StdError=stdout

if %ERRORLEVEL% NEQ 0 (
    echo [ERRO] Falha ao instalar o servico.
    exit /b 1
)

echo [INFO] Configurando conta do servico para LocalSystem...
sc.exe config %SERVICE_NAME% obj= LocalSystem >nul
if %ERRORLEVEL% NEQ 0 (
    echo [ERRO] Falha ao configurar conta do servico.
    exit /b 1
)

echo [INFO] Iniciando o servico...
net start %SERVICE_NAME%
if %ERRORLEVEL% NEQ 0 (
    echo [ERRO] Falha ao iniciar o servico.
    exit /b 2
)
echo [SUCESSO] Servico instalado e ativo.
echo ===================================================
exit /b 0
