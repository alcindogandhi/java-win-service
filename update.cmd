@echo off
NET SESSION >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [ERRO] Execute este script como Administrador.
    exit /b 1
)

SET "CURRENT_DIR=%~dp0"

echo ===================================================
echo     INICIANDO ATUALIZACAO DO SERVICO JAVA
echo ===================================================

:: Chama o desinstalador usando o caminho absoluto do diretorio do script
call "%CURRENT_DIR%uninstall.cmd"

echo [INFO] Aguardando 2 segundos para liberacao de arquivos...
timeout /t 2 /nobreak >nul

:: Chama o instalador usando o caminho absoluto do diretorio do script
call "%CURRENT_DIR%install.cmd"

if %ERRORLEVEL% NEQ 0 (
    echo [ERRO] Falha durante o processo de atualizacao.
    pause
    exit /b 1
)

echo [SUCESSO] Todo o processo de atualizacao foi concluido.
echo ===================================================
pause
exit /b 0
