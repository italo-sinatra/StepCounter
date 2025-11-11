@echo off
REM Script de Instalação do StepCounter
REM Para Windows

echo.
echo 🚀 Instalando StepCounter...
echo.

REM Verificar se Node.js está instalado
echo 📦 Verificando Node.js...
where node >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Node.js não está instalado!
    echo Por favor, instale Node.js 18 ou superior em: https://nodejs.org/
    pause
    exit /b 1
)

for /f "tokens=*" %%i in ('node -v') do set NODE_VERSION=%%i
echo ✅ Node.js %NODE_VERSION% instalado

REM Verificar se npm está instalado
echo 📦 Verificando npm...
where npm >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ❌ npm não está instalado!
    echo npm geralmente vem com Node.js. Por favor, reinstale Node.js.
    pause
    exit /b 1
)

for /f "tokens=*" %%i in ('npm -v') do set NPM_VERSION=%%i
echo ✅ npm %NPM_VERSION% instalado
echo.

REM Perguntar se deseja limpar instalações anteriores
set /p CLEAN="Deseja limpar instalações anteriores? (node_modules, package-lock.json) [s/N]: "
if /i "%CLEAN%"=="s" (
    echo 🧹 Limpando instalações anteriores...
    if exist node_modules rmdir /s /q node_modules
    if exist package-lock.json del /q package-lock.json
    echo ✅ Limpeza concluída
    echo.
)

REM Limpar cache do npm
echo 🧹 Limpando cache do npm...
call npm cache clean --force
echo ✅ Cache limpo
echo.

REM Instalar dependências
echo 📥 Instalando dependências...
echo Isso pode levar alguns minutos...
echo.

call npm install --legacy-peer-deps
if %ERRORLEVEL% EQU 0 (
    echo.
    echo ✅ Dependências instaladas com sucesso!
    echo.
    echo 🎉 Instalação concluída!
    echo.
    echo Para iniciar o servidor de desenvolvimento, execute:
    echo   npm run dev
    echo.
    echo A aplicação estará disponível em: http://localhost:5173
    echo.
) else (
    echo.
    echo ❌ Erro ao instalar dependências
    echo.
    echo Tente executar manualmente:
    echo   npm install --legacy-peer-deps
    echo.
    echo Ou verifique a seção 'Solução de Problemas' no README.md
    pause
    exit /b 1
)

pause

