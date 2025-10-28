# ScriptGenerator.ps1 - Generates development workflow scripts

. "$PSScriptRoot/TemplateEngine.ps1"

function Generate-DevelopmentScripts {
    param(
        [hashtable]$Analysis,
        [string]$OutputPath = ".dev-workflow"
    )
    
    Write-Host "`n🔧 Generating development scripts..." -ForegroundColor Cyan
    
    # Create output directory
    if (-not (Test-Path $OutputPath)) {
        New-Item -Path $OutputPath -ItemType Directory -Force | Out-Null
    }
    
    # Get template variables
    $variables = Get-TemplateVariables -Analysis $Analysis
    
    # Get template directory
    $templateDir = Join-Path $PSScriptRoot "../templates/scripts"
    
    # Generate startup script
    $startupTemplate = Join-Path $templateDir "startup-dev-session.ps1.template"
    $startupOutput = Join-Path $OutputPath "startup-dev-session.ps1"
    
    if (Test-Path $startupTemplate) {
        Process-Template -TemplatePath $startupTemplate -Variables $variables -OutputPath $startupOutput
    }
    else {
        # Create a default startup script if template doesn't exist
        Generate-DefaultStartupScript -Analysis $Analysis -OutputPath $startupOutput
    }
    
    # Generate session closeout script
    $closeoutOutput = Join-Path $OutputPath "session-closeout.ps1"
    Generate-CloseoutScript -Analysis $Analysis -OutputPath $closeoutOutput
    
    # Generate project status script
    $statusOutput = Join-Path $OutputPath "project-status.ps1"
    Generate-StatusScript -Analysis $Analysis -OutputPath $statusOutput
    
    Write-Host "✅ Development scripts generated in: $OutputPath" -ForegroundColor Green
}

function Generate-DefaultStartupScript {
    param(
        [hashtable]$Analysis,
        [string]$OutputPath
    )
    
    $scriptContent = @"
# Development Session Startup Script
# Generated for: $($Analysis.ProjectName)
# Tech Stack: $($Analysis.TechStack)

Write-Host "=== Development Session Startup ===" -ForegroundColor Green
Write-Host "Project: $($Analysis.ProjectName)" -ForegroundColor White
Write-Host "Tech Stack: $($Analysis.TechStack)" -ForegroundColor White

# Check if project dependencies are installed
"@

    if ($Analysis.TechStack -match "Node|React|Vue|Angular") {
        $scriptContent += @"

Write-Host "`nChecking Node.js dependencies..." -ForegroundColor Cyan
if (-not (Test-Path "node_modules")) {
    Write-Host "Installing dependencies..." -ForegroundColor Yellow
    $($Analysis.PackageManager) install
}

Write-Host "`nStarting development server..." -ForegroundColor Cyan
Write-Host "Command: $($Analysis.DevCommand)" -ForegroundColor White
Write-Host "Server will be available at: http://localhost:$($Analysis.Port)" -ForegroundColor Green

# Uncomment to auto-start dev server:
# $($Analysis.DevCommand)
"@
    }
    elseif ($Analysis.Language -eq "Python") {
        $scriptContent += @"

Write-Host "`nChecking Python environment..." -ForegroundColor Cyan
if (-not (Test-Path "venv")) {
    Write-Host "Creating virtual environment..." -ForegroundColor Yellow
    python -m venv venv
}

Write-Host "Activating virtual environment..." -ForegroundColor Cyan
.\venv\Scripts\Activate.ps1

Write-Host "Installing dependencies..." -ForegroundColor Cyan
pip install -r requirements.txt

Write-Host "`nStarting development server..." -ForegroundColor Cyan
Write-Host "Command: $($Analysis.DevCommand)" -ForegroundColor White

# Uncomment to auto-start dev server:
# $($Analysis.DevCommand)
"@
    }
    elseif ($Analysis.Language -eq "Go") {
        $scriptContent += @"

Write-Host "`nChecking Go environment..." -ForegroundColor Cyan
go mod download

Write-Host "`nStarting development server..." -ForegroundColor Cyan
Write-Host "Command: $($Analysis.DevCommand)" -ForegroundColor White

# Uncomment to auto-start dev server:
# $($Analysis.DevCommand)
"@
    }

    $scriptContent += @"

Write-Host "`n=== Session Ready ===" -ForegroundColor Green
Write-Host "Happy coding! 🚀" -ForegroundColor White
"@

    Set-Content -Path $OutputPath -Value $scriptContent -Encoding UTF8
    Write-Host "✅ Generated: $OutputPath" -ForegroundColor Green
}

function Generate-CloseoutScript {
    param(
        [hashtable]$Analysis,
        [string]$OutputPath
    )
    
    $scriptContent = @"
# Development Session Closeout Script
# Generated for: $($Analysis.ProjectName)

Write-Host "=== Development Session Closeout ===" -ForegroundColor Cyan

# Stop any running development servers
Write-Host "`nStopping development servers..." -ForegroundColor Yellow
Get-Process | Where-Object {`$_.ProcessName -match "node|python|go"} | ForEach-Object {
    Write-Host "Found process: `$(`$_.ProcessName) (PID: `$(`$_.Id))" -ForegroundColor White
}

# Commit changes reminder
Write-Host "`nGit Status:" -ForegroundColor Cyan
git status --short

`$uncommittedChanges = git status --short
if (`$uncommittedChanges) {
    Write-Host "`n⚠️  You have uncommitted changes!" -ForegroundColor Yellow
    Write-Host "Consider committing your work before closing the session." -ForegroundColor White
}
else {
    Write-Host "`n✅ No uncommitted changes" -ForegroundColor Green
}

# Session summary
Write-Host "`n=== Session Summary ===" -ForegroundColor Green
Write-Host "Project: $($Analysis.ProjectName)" -ForegroundColor White
Write-Host "Session closed at: `$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" -ForegroundColor White

Write-Host "`nGoodbye! 👋" -ForegroundColor Cyan
"@

    Set-Content -Path $OutputPath -Value $scriptContent -Encoding UTF8
    Write-Host "✅ Generated: $OutputPath" -ForegroundColor Green
}

function Generate-StatusScript {
    param(
        [hashtable]$Analysis,
        [string]$OutputPath
    )
    
    $scriptContent = @"
# Project Status Script
# Generated for: $($Analysis.ProjectName)

Write-Host "=== Project Status ===" -ForegroundColor Cyan
Write-Host ""

# Project Information
Write-Host "📦 Project Information:" -ForegroundColor Green
Write-Host "  Name: $($Analysis.ProjectName)" -ForegroundColor White
Write-Host "  Tech Stack: $($Analysis.TechStack)" -ForegroundColor White
Write-Host "  Language: $($Analysis.Language)" -ForegroundColor White
Write-Host "  Framework: $($Analysis.Framework)" -ForegroundColor White

# Git Status
Write-Host "`n📊 Git Status:" -ForegroundColor Green
git status --short
git log -1 --oneline

# Dependencies
Write-Host "`n📚 Dependencies:" -ForegroundColor Green
"@

    if ($Analysis.TechStack -match "Node|React|Vue|Angular") {
        $scriptContent += @"
if (Test-Path "package.json") {
    `$packageJson = Get-Content "package.json" | ConvertFrom-Json
    Write-Host "  Dependencies: `$(`$packageJson.dependencies.PSObject.Properties.Count)" -ForegroundColor White
    Write-Host "  Dev Dependencies: `$(`$packageJson.devDependencies.PSObject.Properties.Count)" -ForegroundColor White
}
"@
    }
    elseif ($Analysis.Language -eq "Python") {
        $scriptContent += @"
if (Test-Path "requirements.txt") {
    `$reqCount = (Get-Content "requirements.txt" | Where-Object { `$_ -notmatch "^#" -and `$_.Trim() }).Count
    Write-Host "  Requirements: `$reqCount" -ForegroundColor White
}
"@
    }

    $scriptContent += @"

# Environment
Write-Host "`n🌍 Environment:" -ForegroundColor Green
"@

    if ($Analysis.EnvFiles -and $Analysis.EnvFiles.Count -gt 0) {
        $scriptContent += @"
Write-Host "  Environment files found:" -ForegroundColor White
"@
        foreach ($envFile in $Analysis.EnvFiles) {
            $scriptContent += @"
Write-Host "    - $envFile" -ForegroundColor Gray
"@
        }
    }
    else {
        $scriptContent += @"
Write-Host "  No environment files found" -ForegroundColor Gray
"@
    }

    if ($Analysis.Database) {
        $scriptContent += @"

# Database
Write-Host "`n💾 Database:" -ForegroundColor Green
Write-Host "  Type: $($Analysis.Database)" -ForegroundColor White
"@
    }

    $scriptContent += @"

Write-Host "`n=== End of Status ===" -ForegroundColor Cyan
"@

    Set-Content -Path $OutputPath -Value $scriptContent -Encoding UTF8
    Write-Host "✅ Generated: $OutputPath" -ForegroundColor Green
}

# Export-ModuleMember -Function Generate-DevelopmentScripts, Generate-DefaultStartupScript, Generate-CloseoutScript, Generate-StatusScript
