@echo off
REM Script de sincronização Git - Patagang Ecommerce (Windows Batch)
REM Localização: scripts/git-sync.bat
REM Uso: git-sync.bat [mensagem do commit]

setlocal

if "%~1"=="" (
    set "COMMIT_MSG=chore: sync projeto local"
) else (
    set "COMMIT_MSG=%~1"
)

REM Navegar para a pasta raiz do projeto (pasta pai de scripts)
cd /d "%~dp0.."

echo ========================================
echo   GIT SYNC - Patagang Ecommerce
echo ========================================
echo Diretorio: %CD%
echo.

echo Verificando mudancas...
git status --porcelain >nul 2>&1
if errorlevel 1 (
    echo Nenhuma mudanca detectada. Nada para commitar.
    exit /b 0
)

echo Mudancas detectadas:
git status --short
echo.

echo Adicionando arquivos ao staging...
git add .
if errorlevel 1 (
    echo Erro ao adicionar arquivos
    exit /b 1
)
echo Arquivos adicionados
echo.

echo Criando commit...
git commit -m "%COMMIT_MSG%"
if errorlevel 1 (
    echo Erro ao criar commit
    exit /b 1
)
echo Commit criado: %COMMIT_MSG%
echo.

echo Enviando para GitHub...
git push origin main
if errorlevel 1 (
    echo Erro ao enviar para GitHub
    exit /b 1
)
echo Sincronizacao concluida com sucesso!
echo.

echo Status final:
git status
