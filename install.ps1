<#
.SYNOPSIS
    VSCode-based IDE settings sync script for Windows
.DESCRIPTION
    Installs settings, keybindings, snippets, and extensions to Cursor, VSCode, and Antigravity
#>

param(
    [switch]$Cursor,
    [switch]$VSCode,
    [switch]$Antigravity,
    [switch]$All,
    [switch]$ExtensionsOnly,
    [switch]$SettingsOnly
)

$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# IDE configurations
$IDEs = @{
    "Cursor" = @{
        "SettingsPath" = "$env:APPDATA\Cursor\User"
        "ExtensionsPath" = "$env:USERPROFILE\.cursor\extensions"
        "CLI" = @(
            "$env:LOCALAPPDATA\Programs\cursor\resources\app\bin\cursor.cmd",
            "$env:LOCALAPPDATA\Programs\Cursor\resources\app\bin\cursor.cmd"
        )
    }
    "VSCode" = @{
        "SettingsPath" = "$env:APPDATA\Code\User"
        "ExtensionsPath" = "$env:USERPROFILE\.vscode\extensions"
        "CLI" = @(
            "$env:LOCALAPPDATA\Programs\Microsoft VS Code\bin\code.cmd",
            "code"
        )
    }
    "Antigravity" = @{
        "SettingsPath" = "$env:APPDATA\Antigravity\User"
        "ExtensionsPath" = "$env:USERPROFILE\.antigravity\extensions"
        "CLI" = @(
            "$env:LOCALAPPDATA\Programs\Antigravity\bin\antigravity.cmd",
            "antigravity"
        )
    }
}

function Find-CLI {
    param([string[]]$Paths)
    foreach ($path in $Paths) {
        if (Get-Command $path -ErrorAction SilentlyContinue) {
            return $path
        }
        if (Test-Path $path) {
            return $path
        }
    }
    return $null
}

function Install-Settings {
    param([string]$IDE, [hashtable]$Config)

    Write-Host "`n[$IDE] Installing settings..." -ForegroundColor Cyan

    $settingsPath = $Config.SettingsPath

    # Create directory if not exists
    if (-not (Test-Path $settingsPath)) {
        New-Item -ItemType Directory -Path $settingsPath -Force | Out-Null
    }

    # Copy settings.json
    if (Test-Path "$ScriptDir\settings.json") {
        Copy-Item "$ScriptDir\settings.json" "$settingsPath\settings.json" -Force
        Write-Host "  - settings.json copied" -ForegroundColor Green
    }

    # Copy keybindings.json
    if (Test-Path "$ScriptDir\keybindings.json") {
        Copy-Item "$ScriptDir\keybindings.json" "$settingsPath\keybindings.json" -Force
        Write-Host "  - keybindings.json copied" -ForegroundColor Green
    }

    # Copy snippets
    $snippetsDir = "$ScriptDir\snippets"
    if (Test-Path $snippetsDir) {
        $snippetFiles = Get-ChildItem $snippetsDir -File
        if ($snippetFiles.Count -gt 0) {
            $destSnippets = "$settingsPath\snippets"
            if (-not (Test-Path $destSnippets)) {
                New-Item -ItemType Directory -Path $destSnippets -Force | Out-Null
            }
            Copy-Item "$snippetsDir\*" $destSnippets -Force
            Write-Host "  - snippets copied" -ForegroundColor Green
        }
    }
}

function Install-Extensions {
    param([string]$IDE, [hashtable]$Config)

    $cli = Find-CLI $Config.CLI
    if (-not $cli) {
        Write-Host "[$IDE] CLI not found, skipping extensions" -ForegroundColor Yellow
        return
    }

    Write-Host "`n[$IDE] Installing extensions..." -ForegroundColor Cyan

    $extensions = Get-Content "$ScriptDir\extensions.txt" | Where-Object {
        $_ -and -not $_.StartsWith("#")
    }

    foreach ($ext in $extensions) {
        $ext = $ext.Trim()
        if ($ext) {
            Write-Host "  - Installing $ext..." -ForegroundColor Gray
            & $cli --install-extension $ext --force 2>$null
        }
    }

    Write-Host "[$IDE] Extensions installed" -ForegroundColor Green
}

function Process-IDE {
    param([string]$IDE, [hashtable]$Config)

    if (-not $ExtensionsOnly) {
        Install-Settings -IDE $IDE -Config $Config
    }

    if (-not $SettingsOnly) {
        Install-Extensions -IDE $IDE -Config $Config
    }
}

# Main
Write-Host "=== VSCode Profiles Sync ===" -ForegroundColor Magenta

# Determine which IDEs to process
$targetIDEs = @()

if ($All -or (-not $Cursor -and -not $VSCode -and -not $Antigravity)) {
    $targetIDEs = @("Cursor", "VSCode", "Antigravity")
} else {
    if ($Cursor) { $targetIDEs += "Cursor" }
    if ($VSCode) { $targetIDEs += "VSCode" }
    if ($Antigravity) { $targetIDEs += "Antigravity" }
}

foreach ($ide in $targetIDEs) {
    Process-IDE -IDE $ide -Config $IDEs[$ide]
}

Write-Host "`n=== Sync Complete ===" -ForegroundColor Magenta
Write-Host "Restart your IDE(s) to apply changes." -ForegroundColor Yellow
