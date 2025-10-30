# Setup-DevWorkflow.ps1
# Main entry point for dev-workflow-generator

param(
    [string]$ProjectPath = ".",
    [switch]$Force = $false,
    [switch]$SkipScripts = $false,
    [switch]$SkipDocs = $false,
    [switch]$ShowHelp = $false
)

# Automatically handle execution policy (no admin required)
try {
    $currentPolicy = Get-ExecutionPolicy -Scope Process
    if ($currentPolicy -eq 'Restricted') {
        Write-Host "Adjusting execution policy for this session..." -ForegroundColor Yellow
        Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force | Out-Null
    }
} catch {
    # If we can't check/set, try to continue anyway
    Write-Host "Note: Execution policy check skipped" -ForegroundColor Gray
}

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

# Defer script generation until functions are defined
$shouldGenerateScripts = -not $SkipScripts

# Generate documentation
if (-not $SkipDocs) {
    Generate-Documentation -Analysis $analysis -OutputPath $ProjectPath
}

# Defer summary until after functions are defined

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
    param([hashtable]$Analysis, [string]$ProjectPath, [switch]$SkipScripts, [switch]$SkipDocs)
    
    Write-Host "What You Got:" -ForegroundColor Cyan
    
    if (-not $SkipScripts) {
        Write-Host ""
        Write-Host "  PowerShell Scripts (.dev-workflow/):" -ForegroundColor Green
        Write-Host "    startup-dev-session.ps1  - Initialize your dev environment" -ForegroundColor White
        Write-Host "    session-closeout.ps1     - Updates context and clean up when done coding" -ForegroundColor White
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

# Automatically handle execution policy (no admin required)
try {
    `$currentPolicy = Get-ExecutionPolicy -Scope Process
    if (`$currentPolicy -eq 'Restricted') {
        Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force | Out-Null
    }
} catch {
    # Continue if policy check fails
}

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

# Set auto-open context by default (can be disabled with DEVWF_OPEN_CONTEXT=0)
if (-not `$env:DEVWF_OPEN_CONTEXT) {
    `$env:DEVWF_OPEN_CONTEXT = '1'
}

# Check context documentation
Write-Host "`nChecking project context..." -ForegroundColor Cyan
if (Test-Path "IDE_CONTEXT_SUMMARY.md") {
    Write-Host "✅ Context documentation ready" -ForegroundColor Green
    Write-Host "Tip: Reference IDE_CONTEXT_SUMMARY.md in your AI chat for project context" -ForegroundColor Yellow
}
else {
    Write-Host "⚠️  Context documentation not found. Run Setup-DevWorkflow.ps1 first." -ForegroundColor Yellow
}

# Auto-open context doc (enabled by default, disable with DEVWF_OPEN_CONTEXT=0)
`$shouldOpen = `$env:DEVWF_OPEN_CONTEXT -eq '1'
`$inCI = `$env:CI -or `$env:GITHUB_ACTIONS
if (`$shouldOpen -and -not `$inCI -and (Test-Path 'IDE_CONTEXT_SUMMARY.md')) {
    `$contextPath = Resolve-Path 'IDE_CONTEXT_SUMMARY.md' -ErrorAction SilentlyContinue
    if (`$null -ne `$contextPath) {
        try {
            if (`$env:OS -eq 'Windows_NT') {
                Start-Process -FilePath `$contextPath
            }
            elseif (Get-Command open -ErrorAction SilentlyContinue) {
                & open `$contextPath
            }
            elseif (Get-Command xdg-open -ErrorAction SilentlyContinue) {
                & xdg-open `$contextPath
            }
            else {
                Write-Host "Note: couldn't find a suitable opener for IDE_CONTEXT_SUMMARY.md" -ForegroundColor Yellow
            }
        } catch {
            try {
                Invoke-Item `$contextPath
            } catch {
                Write-Host "Note: couldn't auto-open IDE_CONTEXT_SUMMARY.md" -ForegroundColor Yellow
            }
        }
    } else {
        Write-Host "Note: couldn't auto-open IDE_CONTEXT_SUMMARY.md" -ForegroundColor Yellow
    }
}

# Show simple manual steps
Write-Host "`n📋 Quick Start:" -ForegroundColor Cyan
Write-Host "  1) Open IDE_CONTEXT_SUMMARY.md (for AI context)" -ForegroundColor White
Write-Host "  2) Start dev server: $($Analysis.DevCommand)" -ForegroundColor Yellow
Write-Host "  3) Open: http://localhost:$($Analysis.Port)" -ForegroundColor Yellow
Write-Host ""

# Auto-start dev server (can be disabled with DEVWF_AUTOSTART=0)
`$autoStart = if (`$env:DEVWF_AUTOSTART) { `$env:DEVWF_AUTOSTART } else { '1' }
if (`$autoStart -eq '1') {
    Write-Host "🚀 Auto-starting dev server..." -ForegroundColor Green
    try {
        Invoke-Expression "$($Analysis.DevCommand)"
    } catch {
        Write-Host "⚠️  Auto-start failed. Run manually: $($Analysis.DevCommand)" -ForegroundColor Yellow
    }
}

Write-Host "`n=== Session Ready ===" -ForegroundColor Green
Write-Host "Happy coding! 🚀" -ForegroundColor White
"@

    Set-Content -Path (Join-Path $OutputPath "startup-dev-session.ps1") -Value $startupScript -Encoding UTF8
    Write-Host "Generated: startup-dev-session.ps1" -ForegroundColor Green
    
    # Generate closeout script
    $projectNameValue = $Analysis.ProjectName
    $closeoutScript = @"
# Development Session Closeout Script
# Generated for: $($Analysis.ProjectName)

# Automatically handle execution policy (no admin required)
try {
    `$currentPolicy = Get-ExecutionPolicy -Scope Process
    if (`$currentPolicy -eq 'Restricted') {
        Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force | Out-Null
    }
} catch {
    # Continue if policy check fails
}

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

# Update context documentation for next session (KEY FEATURE)
Write-Host "`n🔄 Updating IDE_CONTEXT_SUMMARY.md with session context..." -ForegroundColor Cyan

# Capture session information
`$sessionDate = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
`$changedFiles = git diff --name-only
`$changedFilesStaged = git diff --cached --name-only
`$modifiedFiles = git ls-files -m
`$recentCommits = git log --oneline -5
`$gitStatusShort = git status --short

# Get git diff summary (brief)
`$diffSummary = ""
if (`$changedFiles -or `$changedFilesStaged -or `$modifiedFiles) {
    `$allChanged = (@(`$changedFiles) + @(`$changedFilesStaged) + @(`$modifiedFiles)) | Select-Object -Unique | Where-Object { `$_ }
    if (`$allChanged) {
        `$diffSummary = "Modified files: " + (`$allChanged -join ", ")
    }
}

# Prompt user for session notes
Write-Host "`n📝 What did you work on in this session?" -ForegroundColor Yellow
Write-Host "   (Quick notes: features added, bugs fixed, what you're working on next)" -ForegroundColor Gray
`$userNotes = Read-Host "   Notes (press Enter to skip)"

# Build session context
`$nl = [Environment]::NewLine
`$sessionContext = ''
`$sessionContext += '### Session: ' + `$sessionDate + `$nl + `$nl
`$sessionContext += '#### Files Changed:' + `$nl

if (`$gitStatusShort) {
    `$sessionContext += `$nl + ((`$gitStatusShort -split `$nl | ForEach-Object { '- ' + `$_ }) -join `$nl)
} else {
    `$sessionContext += `$nl + '- No changes detected'
}

`$sessionContext += `$nl + `$nl + '#### Recent Commits:' + `$nl

if (`$recentCommits) {
    `$sessionContext += `$nl + ((`$recentCommits -split `$nl | Select-Object -First 3 | ForEach-Object { '- ' + `$_ }) -join `$nl)
} else {
    `$sessionContext += `$nl + '- No recent commits'
}

if (`$userNotes) {
    `$trimmedNotes = (`$userNotes).Trim()
    if (`$trimmedNotes) {
        `$sessionContext += `$nl + `$nl + `$nl + '#### Session Notes:' + `$nl + '> ' + `$trimmedNotes
    }
}

`$sessionContext += `$nl + `$nl + '---' + `$nl

# Update IDE_CONTEXT_SUMMARY.md
`$contextPath = 'IDE_CONTEXT_SUMMARY.md'
if (Test-Path `$contextPath) {
    `$content = Get-Content `$contextPath -Raw
    
    # Find and replace the Recent Session Context section
    `$sectionHeader = '## Recent Session Context'
    
    `$pattern = '*' + `$sectionHeader + '*'
    if (`$content -like `$pattern) {
        # Split content into lines to find section
        `$lines = `$content -split `$nl
        `$startLineIndex = -1
        `$endLineIndex = -1
        
        for (`$i = 0; `$i -lt `$lines.Count; `$i++) {
            if (`$lines[`$i] -match "^## Recent Session Context") {
                `$startLineIndex = `$i
            }
            elseif (`$startLineIndex -ge 0 -and `$lines[`$i] -match "^## " -and `$lines[`$i] -notmatch "^## Recent Session Context") {
                `$endLineIndex = `$i
                break
            }
        }
        
        if (`$startLineIndex -ge 0) {
            # Build new section
            `$headerText = '## Recent Session Context'
            `$descText = '*This section is automatically updated when you run session-closeout.ps1 to maintain continuity between AI chat sessions.*'
            `$newSection = `$headerText + `$nl + `$nl + `$descText + `$nl + `$nl + `$sessionContext
            
            if (`$endLineIndex -gt `$startLineIndex) {
                # Replace section between lines
                `$beforeLines = `$lines[0..(`$startLineIndex - 1)] -join `$nl
                `$afterLines = `$lines[`$endLineIndex..(`$lines.Count - 1)] -join `$nl
                `$content = `$beforeLines + `$nl + `$newSection + `$nl + `$afterLines
            } else {
                # Replace from start line to end of file
                `$beforeLines = `$lines[0..(`$startLineIndex - 1)] -join `$nl
                `$content = `$beforeLines + `$nl + `$newSection
            }
        } else {
            # Append if section marker found but couldn't process
            `$content += `$nl + `$nl + `$sessionContext
        }
    } else {
        # Append if section doesn't exist
        `$headerText = '## Recent Session Context'
        `$descText = '*This section is automatically updated when you run session-closeout.ps1 to maintain continuity between AI chat sessions.*'
        `$newSection = `$headerText + `$nl + `$nl + `$descText + `$nl + `$nl + `$sessionContext
        `$content += `$nl + `$nl + `$newSection
    }
    
    Set-Content -Path `$contextPath -Value `$content -Encoding UTF8
    Write-Host 'Session context saved to IDE_CONTEXT_SUMMARY.md' -ForegroundColor Green
    Write-Host '   Next AI chat will have full context of this session!' -ForegroundColor Green
} else {
    Write-Host 'IDE_CONTEXT_SUMMARY.md not found. Run Setup-DevWorkflow.ps1 first.' -ForegroundColor Yellow
}

# Session summary
Write-Host ''
Write-Host '=== Session Summary ===' -ForegroundColor Green
Write-Host 'Project: PROJECT_NAME_PLACEHOLDER' -ForegroundColor White
`$closeoutTime = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
Write-Host 'Session closed at:' -NoNewline -ForegroundColor White
Write-Host `$closeoutTime -ForegroundColor White
Write-Host ''
Write-Host 'Goodbye!' -ForegroundColor Cyan
"@
    # Replace placeholders
    $closeoutScript = $closeoutScript -replace 'PROJECT_NAME_PLACEHOLDER', $Analysis.ProjectName

    Set-Content -Path (Join-Path $OutputPath "session-closeout.ps1") -Value $closeoutScript -Encoding UTF8
    Write-Host "Generated: session-closeout.ps1" -ForegroundColor Green
    
    # Generate status script
    $statusScript = @"
# Project Status Script
# Generated for: $($Analysis.ProjectName)

# Automatically handle execution policy (no admin required)
try {
    `$currentPolicy = Get-ExecutionPolicy -Scope Process
    if (`$currentPolicy -eq 'Restricted') {
        Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force | Out-Null
    }
} catch {
    # Continue if policy check fails
}

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

# Execute deferred steps now that functions are defined
if ($shouldGenerateScripts) {
    Write-Host "Generating development scripts..." -ForegroundColor Cyan
    Generate-SimpleScripts -Analysis $analysis -OutputPath $workflowDir
}

# Show what was created
Write-Host ""
Write-Host "================================================" -ForegroundColor Green
Write-Host "   Workflow Setup Complete!                     " -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Green
Write-Host ""

Show-FeaturesOverview -Analysis $analysis -ProjectPath $ProjectPath -SkipScripts:$SkipScripts -SkipDocs:$SkipDocs

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