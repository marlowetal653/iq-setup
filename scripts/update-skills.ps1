# IQ Setup — bootstrap updater for /iq-* skills, the deploy-to-vercel skill,
# and the global CLAUDE.md rules. Run when the /iq-update-skills slash
# command is broken or missing.
#
# Usage (paste into PowerShell):
#   iwr -useb https://raw.githubusercontent.com/marlowetal653/iq-setup/main/scripts/update-skills.ps1 | iex

$ErrorActionPreference = "Stop"

$RepoUrl = "https://github.com/marlowetal653/iq-setup.git"
$TmpDir = Join-Path $env:TEMP "iq-setup-update-$PID"
$CommandsDir = Join-Path $env:USERPROFILE ".claude\commands"
$SkillsDir = Join-Path $env:USERPROFILE ".claude\skills"
$DeployDir = Join-Path $SkillsDir "deploy-to-vercel"
$ClaudeMd = Join-Path $env:USERPROFILE ".claude\CLAUDE.md"

Write-Host "→ Updating IQ skills from $RepoUrl"

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "✗ git is not installed. Install it from https://git-scm.com first." -ForegroundColor Red
    exit 1
}

if (Test-Path $TmpDir) { Remove-Item -Recurse -Force $TmpDir }

try {
    git clone --depth 1 $RepoUrl $TmpDir 2>&1 | Out-Null
    if ($LASTEXITCODE -ne 0) { throw "clone failed" }
} catch {
    Write-Host "✗ git clone failed. Check your internet connection and try again." -ForegroundColor Red
    exit 1
}

if (-not (Test-Path $CommandsDir)) { New-Item -ItemType Directory -Force -Path $CommandsDir | Out-Null }
if (-not (Test-Path $DeployDir)) { New-Item -ItemType Directory -Force -Path $DeployDir | Out-Null }

Copy-Item -Force "$TmpDir\skills\*.md" $CommandsDir

if (Test-Path "$TmpDir\skills\deploy-to-vercel") {
    Copy-Item -Recurse -Force "$TmpDir\skills\deploy-to-vercel\*" $DeployDir
}

if (Test-Path "$TmpDir\config\CLAUDE.md") {
    Copy-Item -Force "$TmpDir\config\CLAUDE.md" $ClaudeMd
}

$skillCount = (Get-ChildItem -Path $CommandsDir -Filter "iq-*.md" -File).Count
Write-Host "✓ Installed $skillCount IQ skills."
Write-Host "✓ Updated deploy-to-vercel skill and global CLAUDE.md."
Write-Host ""
Write-Host "🔴 Restart Claude Code (close this window and reopen it) so the new skills load." -ForegroundColor Yellow

Remove-Item -Recurse -Force $TmpDir -ErrorAction SilentlyContinue
