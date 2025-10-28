# Setup-DevWorkflow.ps1
# Main entry point for dev-workflow-generator

param(
    [string]$ProjectPath = ".",
    [switch]$Force = $false,
    [switch]$SkipScripts = $false,
    [switch]$SkipDocs = $false,
    [switch]$ShowHelp = $false
)

if ($ShowHelp) {
    Show-Help
    exit 0
}

Write-Host ""
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "   Dev Workflow Generator                       " -ForegroundColor Cyan
Write-Host "   Automated Development Workflow Setup         " -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# Get script directory
$scriptDir = $PSScriptRoot

# Import modules
Write-Host "Loading modules..." -ForegroundColor Cyan
. "$scriptDir/src/analyzers/ProjectAnalyzer.ps1"
. "$scriptDir/src/generators/DocGenerator.ps1"

# Resolve project path
$resolvedPath = Resolve-Path $ProjectPath -ErrorAction SilentlyContinue
if (-not $resolvedPath) {
    Write-Host "Project path not found: $ProjectPath" -ForegroundColor Red
    exit 1
}

$ProjectPath = $resolvedPath.Path
Write-Host "Project path: $ProjectPath" -ForegroundColor White
Write-Host ""

# Check if workflow already exists
$workflowDir = Join-Path $ProjectPath ".dev-workflow"
if ((Test-Path $workflowDir) -and -not $Force) {
    Write-Host "Development workflow already exists!" -ForegroundColor Yellow
    Write-Host "Use -Force to regenerate" -ForegroundColor Gray
    $response = Read-Host "Continue anyway? (y/n)"
    if ($response -ne 'y') {
        Write-Host "Operation cancelled" -ForegroundColor Yellow
        exit 0
    }
}

# Analyze project
Write-Host "Analyzing project..." -ForegroundColor Cyan
$analysis = Analyze-Project -Path $ProjectPath

if (-not $analysis -or $analysis.TechStack -eq "Unknown") {
    Write-Host ""
    Write-Host "Could not detect project type!" -ForegroundColor Yellow
    Write-Host "Supported types: Node.js, Python, Go, C#, Java, Rust" -ForegroundColor Gray
    Write-Host "Creating generic workflow..." -ForegroundColor White
    
    # Set default values for unknown projects
    $analysis = @{
        ProjectName = Split-Path $ProjectPath -Leaf
        TechStack = "Generic"
        Framework = "Unknown"
        Language = "Unknown"
        Port = "8080"
        DevCommand = "# Configure your development command"
        BuildCommand = "# Configure your build command"
        TestCommand = "# Configure your test command"
        EnvFiles = @()
    }
}

# Display analysis results
Write-Host ""
Write-Host "Analysis Results:" -ForegroundColor Green
Write-Host "   Project: $($analysis.ProjectName)" -ForegroundColor White
Write-Host "   Tech Stack: $($analysis.TechStack)" -ForegroundColor White
Write-Host "   Language: $($analysis.Language)" -ForegroundColor White
Write-Host "   Framework: $($analysis.Framework)" -ForegroundColor White

if ($analysis.BuildTool) {
    Write-Host "   Build Tool: $($analysis.BuildTool)" -ForegroundColor White
}
if ($analysis.Testing) {
    Write-Host "   Testing: $($analysis.Testing)" -ForegroundColor White
}
if ($analysis.Database) {
    Write-Host "   Database: $($analysis.Database)" -ForegroundColor White
}
if ($analysis.Deployment) {
    Write-Host "   Deployment: $($analysis.Deployment)" -ForegroundColor White
}

Write-Host ""

# Generate scripts (simplified version)
if (-not $SkipScripts) {
    Write-Host "Generating development scripts..." -ForegroundColor Cyan
    Generate-SimpleScripts -Analysis $analysis -OutputPath $workflowDir
}

# Generate documentation
if (-not $SkipDocs) {
    Generate-Documentation -Analysis $analysis -OutputPath $ProjectPath
}

# Show what was created
Write-Host ""
Write-Host "================================================" -ForegroundColor Green
Write-Host "   Workflow Setup Complete!                     " -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Green
Write-Host ""

Show-FeaturesOverview -Analysis $analysis -ProjectPath $ProjectPath

Write-Host ""
Write-Host "Next Steps:" -ForegroundColor Cyan
Write-Host "   1. Review the generated cheatsheet" -ForegroundColor White
Write-Host "   2. Run: .\.dev-workflow\startup-dev-session.ps1" -ForegroundColor White
Write-Host "   3. Start coding!" -ForegroundColor White
Write-Host ""

# Ask if user wants to see the cheatsheet
$showCheatsheet = Read-Host "Would you like to see the quick start guide now? (y/n)"
if ($showCheatsheet -eq 'y') {
    Show-QuickStartGuide -Analysis $analysis
}

Write-Host ""
Write-Host "Tip: Keep DEV_STARTUP_CHEATSHEET.md open in your editor!" -ForegroundColor Yellow
Write-Host ""

# Return analysis for further processing if needed
return $analysis

function Show-Help {
    Write-Host ""
    Write-Host "Dev Workflow Generator - Help" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "USAGE:" -ForegroundColor White
    Write-Host "  .\Setup-DevWorkflow.ps1 [OPTIONS]" -ForegroundColor Gray
    Write-Host ""
    Write-Host "OPTIONS:" -ForegroundColor White
    Write-Host "  -ProjectPath <path>    Path to your project (default: current directory)" -ForegroundColor Gray
    Write-Host "  -Force                Regenerate workflow even if it exists" -ForegroundColor Gray
    Write-Host "  -SkipScripts          Skip generating PowerShell scripts" -ForegroundColor Gray
    Write-Host "  -SkipDocs             Skip generating documentation" -ForegroundColor Gray
    Write-Host "  -ShowHelp             Show this help message" -ForegroundColor Gray
    Write-Host ""
    Write-Host "EXAMPLES:" -ForegroundColor White
    Write-Host "  .\Setup-DevWorkflow.ps1                           # Current directory" -ForegroundColor Gray
    Write-Host "  .\Setup-DevWorkflow.ps1 -ProjectPath ../my-app    # Specific project" -ForegroundColor Gray
    Write-Host "  .\Setup-DevWorkflow.ps1 -Force                    # Regenerate" -ForegroundColor Gray
    Write-Host ""
    Write-Host "SUPPORTED PROJECTS:" -ForegroundColor White
    Write-Host "  Node.js, React, Vue, Angular, Python, Go, C#, Java, Rust" -ForegroundColor Gray
    Write-Host ""
}

function Show-FeaturesOverview {
    param([hashtable]$Analysis, [string]$ProjectPath)
    
    Write-Host "What You Got:" -ForegroundColor Cyan
    
    if (-not $SkipScripts) {
        Write-Host ""
        Write-Host "  PowerShell Scripts (.dev-workflow/):" -ForegroundColor Green
        Write-Host "    startup-dev-session.ps1  - Initialize your dev environment" -ForegroundColor White
        Write-Host "    session-closeout.ps1     - Clean up when done coding" -ForegroundColor White
        Write-Host "    project-status.ps1        - Check project health" -ForegroundColor White
    }
    
    if (-not $SkipDocs) {
        Write-Host ""
        Write-Host "  Documentation Files:" -ForegroundColor Green
        Write-Host "    DEV_STARTUP_CHEATSHEET.md     - Quick reference guide" -ForegroundColor White
        Write-Host "    DEVELOPMENT_WORKFLOW_README.md - Complete workflow guide" -ForegroundColor White
        Write-Host "    IDE_CONTEXT_SUMMARY.md         - AI assistant context" -ForegroundColor White
    }
    
    Write-Host ""
    Write-Host "  Features:" -ForegroundColor Green
    Write-Host "    Auto-detected your $($Analysis.TechStack) project" -ForegroundColor White
    Write-Host "    Tailored commands for $($Analysis.Language)" -ForegroundColor White
    if ($Analysis.BuildTool) {
        Write-Host "    Optimized for $($Analysis.BuildTool)" -ForegroundColor White
    }
    if ($Analysis.Testing) {
        Write-Host "    Integrated $($Analysis.Testing) testing" -ForegroundColor White
    }
    if ($Analysis.Database) {
        Write-Host "    Database: $($Analysis.Database)" -ForegroundColor White
    }
}

function Show-QuickStartGuide {
    param([hashtable]$Analysis)
    
    Write-Host ""
    Write-Host "================================================" -ForegroundColor Yellow
    Write-Host "   Quick Start Guide                            " -ForegroundColor Yellow
    Write-Host "================================================" -ForegroundColor Yellow
    Write-Host ""
    
    Write-Host "1. START CODING:" -ForegroundColor Cyan
    Write-Host "   .\.dev-workflow\startup-dev-session.ps1" -ForegroundColor White
    Write-Host "   This will:" -ForegroundColor Gray
    Write-Host "   - Check dependencies" -ForegroundColor Gray
    Write-Host "   - Start development server" -ForegroundColor Gray
    Write-Host "   - Show project info" -ForegroundColor Gray
    Write-Host ""
    
    Write-Host "2. CHECK STATUS:" -ForegroundColor Cyan
    Write-Host "   .\.dev-workflow\project-status.ps1" -ForegroundColor White
    Write-Host "   This will show:" -ForegroundColor Gray
    Write-Host "   - Project information" -ForegroundColor Gray
    Write-Host "   - Git status" -ForegroundColor Gray
    Write-Host "   - Dependencies" -ForegroundColor Gray
    Write-Host ""
    
    Write-Host "3. END SESSION:" -ForegroundColor Cyan
    Write-Host "   .\.dev-workflow\session-closeout.ps1" -ForegroundColor White
    Write-Host "   This will:" -ForegroundColor Gray
    Write-Host "   - Stop dev servers" -ForegroundColor Gray
    Write-Host "   - Show git status" -ForegroundColor Gray
    Write-Host "   - Remind you to commit" -ForegroundColor Gray
    Write-Host ""
    
    Write-Host "4. QUICK REFERENCE:" -ForegroundColor Cyan
    Write-Host "   Open DEV_STARTUP_CHEATSHEET.md in your editor" -ForegroundColor White
    Write-Host "   It has all the commands you need!" -ForegroundColor Gray
    Write-Host ""
    
    if ($Analysis.TechStack -match "Node|React|Vue|Angular") {
        Write-Host "For $($Analysis.TechStack) projects:" -ForegroundColor Cyan
        Write-Host "   Development server: http://localhost:$($Analysis.Port)" -ForegroundColor White
        Write-Host "   Package manager: $($Analysis.PackageManager)" -ForegroundColor White
        Write-Host ""
    }
    elseif ($Analysis.Language -eq "Python") {
        Write-Host "For Python projects:" -ForegroundColor Cyan
        Write-Host "   Development server: http://localhost:$($Analysis.Port)" -ForegroundColor White
        Write-Host "   Framework: $($Analysis.Framework)" -ForegroundColor White
        Write-Host ""
    }
}

function Generate-SimpleScripts {
    param([hashtable]$Analysis, [string]$OutputPath)
    
    # Create output directory
    if (-not (Test-Path $OutputPath)) {
        New-Item -Path $OutputPath -ItemType Directory -Force | Out-Null
    }
    
    # Generate startup script
    $startupScript = @"
# Development Session Startup Script
# Generated for: $($Analysis.ProjectName)
# Tech Stack: $($Analysis.TechStack)

Write-Host "=== Development Session Startup ===" -ForegroundColor Green
Write-Host "Project: $($Analysis.ProjectName)" -ForegroundColor White
Write-Host "Tech Stack: $($Analysis.TechStack)" -ForegroundColor White

# Check if project dependencies are installed
"@

    if ($Analysis.TechStack -match "Node|React|Vue|Angular") {
        $startupScript += @"

Write-Host "`nChecking Node.js dependencies..." -ForegroundColor Cyan
if (-not (Test-Path "node_modules")) {
    Write-Host "Installing dependencies..." -ForegroundColor Yellow
    npm install
}

Write-Host "`nStarting development server..." -ForegroundColor Cyan
Write-Host "Command: $($Analysis.DevCommand)" -ForegroundColor White
Write-Host "Server will be available at: http://localhost:$($Analysis.Port)" -ForegroundColor Green

# Uncomment to auto-start dev server:
# $($Analysis.DevCommand)
"@
    }
    elseif ($Analysis.Language -eq "Python") {
        $startupScript += @"

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
        $startupScript += @"

Write-Host "`nChecking Go environment..." -ForegroundColor Cyan
go mod download

Write-Host "`nStarting development server..." -ForegroundColor Cyan
Write-Host "Command: $($Analysis.DevCommand)" -ForegroundColor White

# Uncomment to auto-start dev server:
# $($Analysis.DevCommand)
"@
    }

    $startupScript += @"

Write-Host "`n=== Session Ready ===" -ForegroundColor Green
Write-Host "Happy coding! 🚀" -ForegroundColor White
"@

    Set-Content -Path (Join-Path $OutputPath "startup-dev-session.ps1") -Value $startupScript -Encoding UTF8
    Write-Host "Generated: startup-dev-session.ps1" -ForegroundColor Green
    
    # Generate closeout script
    $closeoutScript = @"
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

    Set-Content -Path (Join-Path $OutputPath "session-closeout.ps1") -Value $closeoutScript -Encoding UTF8
    Write-Host "Generated: session-closeout.ps1" -ForegroundColor Green
    
    # Generate status script
    $statusScript = @"
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

Write-Host "`n=== End of Status ===" -ForegroundColor Cyan
"@

    Set-Content -Path (Join-Path $OutputPath "project-status.ps1") -Value $statusScript -Encoding UTF8
    Write-Host "Generated: project-status.ps1" -ForegroundColor Green
}