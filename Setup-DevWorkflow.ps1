# Setup-DevWorkflow.ps1
# Main entry point for dev-workflow-generator

param(
    [string]$ProjectPath = ".",
    [switch]$Force = $false,
    [switch]$SkipScripts = $false,
    [switch]$SkipDocs = $false
)

Write-Host ""
Write-Host "â•”â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•—" -ForegroundColor Cyan
Write-Host "â•‘   Dev Workflow Generator                       â•‘" -ForegroundColor Cyan
Write-Host "â•‘   Automated Development Workflow Setup         â•‘" -ForegroundColor Cyan
Write-Host "â•šâ•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•" -ForegroundColor Cyan
Write-Host ""

# Get script directory
$scriptDir = $PSScriptRoot

# Import modules
Write-Host "Loading modules..." -ForegroundColor Cyan
. "$scriptDir/src/analyzers/ProjectAnalyzer.ps1"
. "$scriptDir/src/generators/TemplateEngine.ps1"
. "$scriptDir/src/generators/ScriptGenerator.ps1"
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

# Analyze project
Write-Host "Analyzing project..." -ForegroundColor Cyan
$analysis = Analyze-Project -Path $ProjectPath

if (-not $analysis -or $analysis.TechStack -eq "Unknown") {
    Write-Host ""
    Write-Host "Could not detect project type!" -ForegroundColor Yellow
    Write-Host "Supported types: Node.js, Python, Go" -ForegroundColor Gray
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

Write-Host ""

# Generate scripts
$workflowDir = Join-Path $ProjectPath ".dev-workflow"
if (-not $SkipScripts) {
    Generate-DevelopmentScripts -Analysis $analysis -OutputPath $workflowDir
}

# Generate documentation
if (-not $SkipDocs) {
    Generate-Documentation -Analysis $analysis -OutputPath $ProjectPath
}

# Success message
Write-Host ""
Write-Host "â•”â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•—" -ForegroundColor Green
Write-Host "â•‘   Workflow Setup Complete!                     â•‘" -ForegroundColor Green
Write-Host "â•šâ•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•" -ForegroundColor Green
Write-Host ""

Write-Host "Generated Files:" -ForegroundColor Cyan
Write-Host "   Development scripts created" -ForegroundColor Green
Write-Host "   Documentation created" -ForegroundColor Green

Write-Host ""
Write-Host "Next Steps:" -ForegroundColor Cyan
Write-Host "   1. Review the generated cheatsheet" -ForegroundColor White
Write-Host "   2. Run: .\.dev-workflow\startup-dev-session.ps1" -ForegroundColor White
Write-Host "   3. Start coding!" -ForegroundColor White
Write-Host ""
