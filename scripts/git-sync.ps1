# Script de sincronização Git - Patagang Ecommerce
# Uso: .\git-sync.ps1 [mensagem do commit]

param(
    [string]$Message = "chore: sync projeto local"
)

$ErrorActionPreference = "Stop"

# Navegar para o diretório do projeto
$projectPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $projectPath

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  GIT SYNC - Patagang Ecommerce" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Verificar se há mudanças
Write-Host "Verificando mudanças..." -ForegroundColor Yellow
$status = git status --porcelain

if (-not $status) {
    Write-Host "✓ Nenhuma mudança detectada. Nada para commitar." -ForegroundColor Green
    exit 0
}

Write-Host "Mudanças detectadas:" -ForegroundColor Yellow
git status --short
Write-Host ""

# Adicionar todos os arquivos
Write-Host "Adicionando arquivos ao staging..." -ForegroundColor Yellow
git add .
if ($LASTEXITCODE -ne 0) {
    Write-Host "✗ Erro ao adicionar arquivos" -ForegroundColor Red
    exit 1
}
Write-Host "✓ Arquivos adicionados" -ForegroundColor Green
Write-Host ""

# Fazer commit
Write-Host "Criando commit..." -ForegroundColor Yellow
git commit -m $Message
if ($LASTEXITCODE -ne 0) {
    Write-Host "✗ Erro ao criar commit" -ForegroundColor Red
    exit 1
}
Write-Host "✓ Commit criado: $Message" -ForegroundColor Green
Write-Host ""

# Push para GitHub
Write-Host "Enviando para GitHub..." -ForegroundColor Yellow
git push origin main
if ($LASTEXITCODE -ne 0) {
    Write-Host "✗ Erro ao enviar para GitHub" -ForegroundColor Red
    exit 1
}
Write-Host "✓ Sincronização concluída com sucesso!" -ForegroundColor Green
Write-Host ""

# Mostrar status final
Write-Host "Status final:" -ForegroundColor Cyan
git status
# Mostrar status final
Write-Host "Status final:" -ForegroundColor Cyan
git status
